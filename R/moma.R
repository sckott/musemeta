#' Get metadata from Museum of Modern Art
#'
#' @export
#' @name moma
#' @param ... Curl args passed on to [crul::verb-GET]
#' @examples \dontrun{
#' # artists
#' (arts <- moma_artists())
#'
#' # artwork
#' (work <- moma_artwork())
#' }

#' @export
#' @rdname moma
moma_artists <- function(...) {
  out <- musemeta_GET(paste0(momabase, 'Artists.json'), ...)
  json <- jsonlite::fromJSON(out)
  names(json) <- tolower(names(json))
  tibble::as_tibble(json)
}

#' @export
#' @rdname moma
moma_artwork <- function(...) {
  out <- musemeta_GET(paste0(momabase, 'Artworks.json'), ...)
  json <- jsonlite::fromJSON(out)
  names(json) <- tolower(names(json))
  tibble::as_tibble(json)
}

momabase <- "https://media.githubusercontent.com/media/MuseumofModernArt/collection/master/"
