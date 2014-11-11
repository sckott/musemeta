#' Get metadata for an object id.
#'
#' @importFrom httr GET content stop_for_status
#' @importFrom jsonlite fromJSON
#' @importFrom XML xpathApply xpathSApply xmlValue htmlParse
#' @export
#'
#' @param id An object id
#' @param ... Curl args passed on to \code{\link[httr]{GET}}
#' @details This function currently only gets data for The Metropolitan Museum of Art
#' @examples \donttest{
#' muse_get(559490)
#' muse_get(559490)$name
#' muse_get(559490)$values
#' muse_get(246562)
#' lapply(c(479283, 228901, 436876, 444244), muse_get)
#' }
muse_get <- function(id, ...){
  out <- musemeta_GET(paste0(mmbase(), id), ...)
  muse_parse(out)
}

#' @export
print.muse <- function(x, ...){
  cat(sprintf("<Museum metadata> %s", x$name), sep = "\n")
  for(i in seq_along(x$values)){
    cat(sprintf("  %s: %s", x$values[[i]]$name, x$values[[i]]$value), sep = "\n")
  }
}

musemeta_GET <- function(url, args = list(), ...){
  res <- GET(url, query = args, ...)
  stop_for_status(res)
  content(res, "text")
}

muse_parse <- function(x){
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

mmbase <- function() "http://www.metmuseum.org/collection/the-collection-online/search/"

# url <- 'http://www.metmuseum.org/collection/the-collection-online/search/559490?rpp=30&pg=1&rndkey=20140815&ft=*&what=Bronze&pos=1'
# url <- 'http://www.metmuseum.org/collection/the-collection-online/search/559490'
