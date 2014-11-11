#' Use the scrapi API for The Metropolitan Museum of Art data
#'
#' @name scrapi
#' @param id (numeric) An object id
#' @param query (character) Query terms
#' @param fields (character) One or more fields to return in a vector
#' @param ... Curl args passed on to \code{\link[httr]{GET}}
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
#' }
NULL

#' @export
#' @rdname scrapi
scrapi_random <- function(fields=NULL, ...){
  res <- musemeta_GET(paste0(scbase(), "random"), mc(list(fields=p2c(fields))), ...)
  jsonlite::fromJSON(res, FALSE)
}

#' @export
#' @rdname scrapi
scrapi_info <- function(id, fields=NULL, ...){
  res <- musemeta_GET(paste0(scbase(), "object/", id), mc(list(fields=p2c(fields))), ...)
  jsonlite::fromJSON(res, FALSE)
}

#' @export
#' @rdname scrapi
scrapi_search <- function(query, ...){
  res <- musemeta_GET(paste0(scbase(), "search/", gsub("\\s", "+", query)), ...)
  out <- jsonlite::fromJSON(res, TRUE)
  links <- as.list(setNames(unname(unlist(out$`_links`)), names(out$`_links`)))
  list(out=out$collection$items$href, links=links)
}

scbase <- function() 'http://scrapi.org/'
