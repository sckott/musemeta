#' Use the scrapi API for The Metropolitan Museum of Art data.
#'
#' NOTE: THE RANDOM ENDPOINT IS DOWN FOR NOW.
#'
#' @name scrapi
#' @param id (numeric) An object id
#' @param query (character) Query terms
#' @param fields (character) One or more fields to return in a vector
#' @param ... Curl args passed on to \code{\link[httr]{GET}}
#' @param x URL or ID for a scrapi object.
#' @references \url{http://scrapi.org/} \url{https://github.com/jedahan/collections-api}
#' @seealso \code{\link{met}}
#' @details You can also use the \code{\link{met}} function. The equivalent function with the
#' scrapi API is \code{\link{scrapi_get}}. The latter gets much more data, and uses a REST API,
#' while the former scrapes the html directly.
#' @examples \donttest{
#' # Get a random object
#' scrapi_random()
#' scrapi_random(fields=c('medium','whoList'))
#'
#' # Get object information
#' scrapi_info(123)
#' scrapi_info(123, fields='title')
#' scrapi_info(123, fields=c('title','primaryArtistNameOnly','medium'))
#'
#' # Search for objects
#' scrapi_search(query='mirror')
#' scrapi_search(query='siphon nozzle')
#'
#' # Get an object
#' ## with a url for a scrapi object
#' scrapi_get("http://scrapi.org/object/427581")
#' ## with an object id
#' scrapi_get(427581)
#' }
NULL

#' @export
#' @rdname scrapi
scrapi_random <- function(fields=NULL, ...){
  scrapi_down()
#   res <- musemeta_GET(paste0(scbase(), "random"), mc(list(fields = p2c(fields))), ...)
#   jsonlite::fromJSON(res, FALSE)
}

#' @export
#' @rdname scrapi
scrapi_info <- function(id, fields=NULL, ...){
  res <- musemeta_GET(paste0(scbase(), "object/", id), mc(list(fields = p2c(fields))), ...)
  jsonlite::fromJSON(res, FALSE)
}

#' @export
#' @rdname scrapi
scrapi_search <- function(query, ...){
  res <- musemeta_GET(paste0(scbase(), "search/", gsub("\\s", "+", query)), ...)
  out <- jsonlite::fromJSON(res, TRUE)
  links <- as.list(setNames(unname(unlist(out$`_links`)), names(out$`_links`)))
  ids <- gsub("http://scrapi.org/object/", "", out$collection$items$href)
  list(links = out$collection$items$href, ids = ids, paging = links)
}

#' @export
#' @rdname scrapi
scrapi_get <- function(x, ...){
  res <- if (grepl("http://scrapi.org", x)) musemeta_GET(x, ...) else musemeta_GET(paste0(scbase(), "object/", x), ...)
  jsonlite::fromJSON(res, FALSE)
}

scbase <- function() 'http://scrapi.org/'

scrapi_down <- function() message("Sorry, the scrapi.org API random endpoint is temporarily down\n will work again when the API is back up")
