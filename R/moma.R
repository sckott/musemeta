#' Get metadata from Museum of Modern Art
#'
#' @export
#' @name moma
#' @param ... Curl args passed on to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' # artists
#' (arts <- moma_artists())
#'
#' # artwork
#' (work <- moma_artwork(config = verbose()))
#' }

#' @export
#' @rdname moma
moma_artists <- function(...) {
  out <- musemeta_GET(paste0(momabase(), 'Artists.json'), ...)
  json <- jsonlite::fromJSON(out)
  names(json) <- tolower(names(json))
  tibble::as_data_frame(json)
}

#' @export
#' @rdname moma
moma_artwork <- function(...) {
  out <- musemeta_GET(paste0(momabase(), 'Artworks.json'), ...)
  json <- jsonlite::fromJSON(out)
  names(json) <- tolower(names(json))
  tibble::as_data_frame(json)
}

momabase <- function() "https://github.com/MuseumofModernArt/collection/raw/master/"
