#' Get metadata for objects in the Asian Art Museum of San Francisco.
#'
#' @export
#' @param id An object id
#' @param ... Curl args passed on to \code{\link[httr]{GET}}
#' @examples \donttest{
#' aam(17150)
#'
#' aam(17140)
#' aam(17146)
#' aam(17144)
#' aam(17142)
#' aam(11462)
#' lapply(c(17150,17140,17144), aam)
#' }
aam <- function(id, ...){
  out <- musemeta_GET(paste0(aambase(), id), ...)
  aam_parse(out, id)
}

#' @export
print.aam <- function(x, ...){
  cat(sprintf("<AAM metadata> %s", x$designation), sep = "\n")
  catpaswrap(x$object_id, "Object id", "  ")
  catpaswrap(x$object_name, "Object name", "  ")
  catpaswrap(x$date, "Date", "  ")
  catpaswrap(x$artist, "Artist", "  ")
  catpaswrap(x$medium, "Medium", "  ")
  catpaswrap(x$credit_line, "Credit line", "  ")
  catpaswrap(x$on_display, "On display?", "  ")
  catpaswrap(x$collection, "Collection", "  ")
  catpaswrap(x$department, "Department", "  ")
  catpaswrap(x$dimensions, "Dimensions", "  ")
  catpaswrap(x$label, "Label", "  ")
}

# tryget <- function(x){
#   out <- tryCatch(x, error=function(e) e)
#   if(is(out, "simpleError")) NA else out
# }
# #     tmp <- xmlToList(x)
# #     list(tryget(tmp$div$span$text), tryget(tmp$div$text))

nameele <- function(x){
  if(nchar(x)==0){
    NULL
  } else {
    vals <- gsub("^\\s+|\\s+$", "", strsplit(x, ":")[[1]])
    tmp <- as.list(setNames(vals[2], vals[1]))
    if(names(tmp) == "Permalink to this object") NULL else tmp
  }
}

aam_parse <- function(x, id){
  tmp <- htmlParse(x)
  nodes <- xpathApply(tmp, '//div[@id="singledata"]')
  out <- do.call(c, mc(lapply(xpathApply(nodes[[1]], "div", xmlValue), nameele)))
  names(out) <- gsub("\\s", "_", tolower(names(out)))
  structure(out, class="aam")
}

aambase <- function() "http://searchcollection.asianart.org/view/objects/asitem/nid/"
