#' Get metadata for objects in the Asian Art Museum of San Francisco.
#'
#' @export
#' @param id An object id
#' @param ascii (logical) Allow non-ascii characters. Set to \code{TRUE} to show
#' non-ascii characters. Default: FALSE
#' @param ... Curl args passed on to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' aam(17150)
#'
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
  cat(sprintf("<AAM metadata> %s", x$designation), sep = "\n")
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

nameele <- function(x){
  if(nchar(x)==0){
    NULL
  } else {
    vals <- gsub("^\\s+|\\s+$", "", strsplit(x, ":")[[1]])
    tmp <- as.list(stats::setNames(vals[2], vals[1]))
    if(names(tmp) == "Permalink to this object") NULL else tmp
  }
}

aam_parse <- function(x, id, ascii){
  tmp <- htmlParse(x)
  nodes <- xpathApply(tmp, '//div[@id="singledata"]')
  out <- do.call(c, mc(lapply(xpathApply(nodes[[1]], "div", xmlValue), nameele)))
  names(out) <- gsub("\\s", "_", tolower(names(out)))
  structure(nonascii(out, ascii), class="aam")
}

aambase <- function() "http://searchcollection.asianart.org/view/objects/asitem/nid/"
