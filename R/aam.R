#' Get metadata for objects in the Asian Art Museum of San Francisco.
#'
#' @export
#' @param id An object id
#' @param ascii (logical) Allow non-ascii characters. Set to `TRUE` to show
#' non-ascii characters. Default: `FALSE`
#' @param ... Curl args passed on to [crul::verb-GET]
#' @examples \dontrun{
#' aam(17150)
#' aam(17140)
#' aam(17146)
#' aam(17144)
#' aam(17142)
#' aam(11462)
#' lapply(c(17150,17140,17144), aam)
#' }
aam <- function(id, ascii = FALSE, ...){
  out <- musemeta_GET(paste0(aambase(), id), ...)
  aam_parse(out, id, ascii)
}

#' @export
print.aam <- function(x, ...){
  cat(sprintf("<AAM metadata> %s", x$title), sep = "\n")
  catpaswrap(x$object_number, "Object Number", "  ")
  catpaswrap(x$object_name, "Object name", "  ")
  catpaswrap(x$place_of_origin, "Place of Origin", "  ")
  catpaswrap(x$historical_period, "Historical Period", "  ")
  catpaswrap(x$location, "Location", "  ")
  catpaswrap(x$culture, "Culture", "  ")
  catpaswrap(x$date, "Date", "  ")
  catpaswrap(x$artist, "Artist", "  ")
  catpaswrap(x$materials, "Materials", "  ")
  catpaswrap(x$credit_line, "Credit line", "  ")
  catpaswrap(x$on_display, "On display?", "  ")
  catpaswrap(x$collection, "Collection", "  ")
  catpaswrap(x$department, "Department", "  ")
  catpaswrap(x$dimensions, "Dimensions", "  ")
  catpaswrap(x$label, "Label", "  ")
}

aam_parse <- function(x, id, ascii){
  tmp <- xml2::read_html(x)
  nodes <- xml2::xml_find_all(tmp, '//div[@id="singledata"]')
  if (length(nodes) == 0) {
    warning("'", id, "' not found")
    return(list())
  }
  out <- lapply(xml2::xml_children(nodes[[1]]), function(z) {
    tmp <- stats::setNames(as.list(xml2::xml_text(z)), 
      xml2::xml_attr(z, "class"))
    if (grepl(":", tmp[[1]])) {
      vals <- gsub("^\\s+|\\s+$", "", strsplit(tmp[[1]], ":")[[1]])
      tmp <- as.list(stats::setNames(vals[2], vals[1]))
    }
    if (grepl("item-title", names(tmp))) names(tmp) <- "title"
    names(tmp) <- gsub("-|\\s", "_", tolower(names(tmp)))
    tmp
  })
  structure(nonascii(unlist(out, FALSE), ascii), class="aam")
}

aambase <- function() "http://searchcollection.asianart.org/view/objects/asitem/nid/"
