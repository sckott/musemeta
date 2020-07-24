#' Get metadata for objects in the Getty Museum.
#'
#' @export
#' @param id An object id
#' @param ascii (logical) Allow non-ascii characters. Set to `TRUE` to show
#' non-ascii characters. Default: `FALSE`
#' @param ... Curl args passed on to [crul::verb-GET]
#' @examples \dontrun{
#' getty(233750)
#' getty(138860)
#' getty(8197)
#' getty(3242)
#' getty(4967)
#' getty(112297)
#' lapply(c(140725,8197), getty)
#' }
getty <- function(id, ascii = FALSE, ...) {
  out <- getty_GET(file.path(gettybase(), id), ...)
  getty_parse(out, id, ascii)
}

getty_GET <- function(url, ...) {
  con <- crul::HttpClient$new(url, opts = list(followlocation=TRUE, ...))
  res <- con$get()
  res$raise_for_status()
  if (grepl("404", res$url)) {
    res$status_code <- 404
    res$raise_for_status()
  }
  txt <- res$parse("UTF-8")
  if (grepl("No Object Found", txt)) stop(args$objectid, " not found", call. = FALSE)
  return(txt)
}

#' @export
print.getty <- function(x, ...){
  cat(sprintf("<Getty metadata> %s", x$name), sep = "\n")
  catpaswrap(x$maker, "Artist", "  ")
  catpaswrap(x$culture, "Culture", "  ")
  catpaswrap(x$date, "Date", "  ")
  catpaswrap(x$dimensions, "Dimensions", "  ")
  catpaswrap(x$classification, "Classification", "  ")
  catpaswrap(x$place_created, "Place created", "  ")
  catpaswrap(x$object_type, "Object type", "  ")
  catpaswrap(x$object_number, "Object number", "  ")
  catpaswrap(x$thumbimage, "Thumb image", "  ")
  catpaswrap(x$department, "Department", "  ")
  catpaswrap(x$on_view, "On view?", "  ")
  cat("  Provenance", sep = "\n")
  for (i in seq_along(x$provenance)) {
    cat(sprintf("     - %s", x$provenance[[i]]), sep = "\n")
  }
  cat("  Bibliography", sep = "\n")
  for (i in seq_along(x$bibliography)) {
    cat(sprintf("     - %s", x$bibliography[[i]]), sep = "\n")
  }
}

l2i <- function(x) if (x) 1 else 0

getty_parse <- function(x, id, ascii) {
  html <- read_html(x)
  name <- exmeta(html, "title")
  culture <- exmeta(html, "culture")
  medium <- exmeta(html, "medium")
  date <- exmeta(html, "date")
  dimensions <- exmeta(html, "dimensions")
  maker <- exmeta(html, "maker")
  classification <- exmeta(html, "classification")
  place_created <- exmeta(html, "place_created")
  object_type <- exmeta(html, "object_type")
  object_number <- exmeta(html, "object_number")
  thumbimage <- exmeta(html, "thumbimage")
  department <- exmeta(html, "department")
  on_view <- exmeta(html, "on_view")

  prov <- xml_find_all(html, '//section[@id="object-section-provenance"]/div/div[@class="row"]')
  prov <- xml_text(prov)

  biblio <- xml_find_all(html, '//div[@data-slug="object-section-bibliography-content"]/p')
  biblio <- xml_text(biblio)

  all <- list(name = name,
    culture = culture,
    medium = medium,
    date = date,
    dimensions = dimensions,
    maker = maker,
    classification = classification,
    place_created = place_created,
    object_type = object_type,
    object_number = object_number,
    thumbimage = thumbimage,
    department = department,
    on_view = on_view, provenance=prov, bibliography=biblio,
    link = file.path(gettybase(), id))
  structure(nonascii(all, ascii), class="getty")
}

exmeta <- function(html, name) {
  xml_attr(xml_find_first(html, sprintf('//meta[@name="%s"]', name)), "content")
}

gettybase <- function() "http://www.getty.edu/art/collection/objects"
