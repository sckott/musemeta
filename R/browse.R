#' Browse the object
#'
#' @param x Output from any of the functions in this package.
#' @param ... Further arguments passed on to `browseURL()`
browse <- function(x, ...){
  UseMethod("browse")
}

#' @export
#' @rdname browse
browse.aic <- function(x, ...) utils::browseURL(x$link, ...)

#' @export
#' @rdname browse
browse.nga <- function(x, ...) utils::browseURL(x$link, ...)
