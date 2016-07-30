#' Get metadata for objects in the Metropolitan Museum of Art.
#'
#' @importFrom httr GET content stop_for_status config
#' @importFrom jsonlite fromJSON
#' @importFrom XML xpathApply xpathSApply xmlValue htmlParse xmlChildren xmlGetAttr readHTMLTable
#' xmlToList
#' @importFrom xml2 read_html xml_find_first xml_text xml_find_all
#' @name met
#'
#' @param id An object id
#' @param ascii (logical) Allow non-ascii characters. Set to \code{TRUE} to show
#' non-ascii characters. Default: FALSE
#' @param ... Curl args passed on to \code{\link[httr]{GET}}
#' @details \code{muse_get} has changed to \code{met}
#' @examples \dontrun{
#' out <- met(559490)
#' out$name
#' out$values
#' met(246562)
#' lapply(c(479283, 228901, 436876, 444244), met)
#' }

#' @export
#' @rdname met
met <- function(id, ascii = FALSE, ...){
  out <- musemeta_GET(paste0(metbase(), id), config(followlocation = TRUE), ...)
  met_parse(out, ascii, id)
}

#' @export
#' @rdname met
muse_get <- function(id, ...){
  .Deprecated("met", "musemeta", "Decided to change fxn name, see met()")
}

met_parse <- function(x, ascii, id){
  tmp <- xml2::read_html(x)
  #tcon <- xpathApply(tmp, "//div[@class='tombstone-container']")[[1]]
  #tcon <- xpathApply(tmp, "//div[@class='collection-details__tombstone']")[[1]]
  tcon <- xml2::xml_find_first(tmp, "//div[@class='collection-details__tombstone']")
  name <- gsub(":", "", xml2::xml_text(xml2::xml_find_all(tcon, "//dt")))
  tags <- xml2::xml_text(xml2::xml_find_all(tcon, "//dd"))
  tags <- unname(Map(function(x, y) list(name = x, value = y), name, tags))
  # tomb <- xpathApply(tcon, "//div[@class='tombstone']")[[1]]
  # tags <- lapply(xpathApply(tomb, "div"), function(x){
  #   list(name = gsub(":", "", xpathSApply(x, "strong", xmlValue)),
  #        value = gsub("^\\s+", "", gsub(".+\n|.+\r", "", xmlValue(x))))
  # })
  structure(nonascii(list(name = id, values = tags), ascii), class = "muse")
}

metbase <- function() "http://www.metmuseum.org/collection/the-collection-online/search/"
