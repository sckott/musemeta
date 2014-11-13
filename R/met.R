#' Get metadata for objects in the Metropolitan Museum of Art.
#'
#' @importFrom httr GET content stop_for_status
#' @importFrom jsonlite fromJSON
#' @importFrom XML xpathApply xpathSApply xmlValue htmlParse
#' @name met
#'
#' @param id An object id
#' @param ... Curl args passed on to \code{\link[httr]{GET}}
#' @details This function currently only gets data for The Metropolitan Museum of Art
#'
#' \code{muse_get} has changed to \code{met_get}
#' @examples \donttest{
#' out <- met_get(559490)
#' out$name
#' out$values
#' met_get(246562)
#' lapply(c(479283, 228901, 436876, 444244), muse_get)
#' }

#' @export
#' @rdname met
met_get <- function(id, ...){
  out <- musemeta_GET(paste0(metbase(), id), ...)
  met_parse(out)
}

#' @export
#' @rdname met
muse_get <- function(id, ...){
  .Deprecated("met_get", "musemeta", "Decided to change fxn name, see met_get()")
}

met_parse <- function(x){
  tmp <- htmlParse(x)
  tcon <- xpathApply(tmp, "//div[@class='tombstone-container']")[[1]]
  name <- xmlValue(xpathApply(tcon, "h2")[[1]])
  tomb <- xpathApply(tcon, "//div[@class='tombstone']")[[1]]
  tags <- lapply(xpathApply(tomb, "div"), function(x){
    list(name = gsub(":", "", xpathSApply(x, "strong", xmlValue)),
         value = gsub("^\\s+", "", gsub(".+\n|.+\r", "", xmlValue(x))))
  })
  structure(list(name=name, values=tags), class="muse")
}

metbase <- function() "http://www.metmuseum.org/collection/the-collection-online/search/"

# url <- 'http://www.metmuseum.org/collection/the-collection-online/search/559490?rpp=30&pg=1&rndkey=20140815&ft=*&what=Bronze&pos=1'
# url <- 'http://www.metmuseum.org/collection/the-collection-online/search/559490'
