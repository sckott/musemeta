musemeta_GET <- function(url, args = list(), ...){
  res <- GET(url, query = args, ...)
  stop_for_status(res)
  content(res, "text")
}

#' @export
print.muse <- function(x, ...){
  cat(sprintf("<Museum metadata> %s", x$name), sep = "\n")
  for(i in seq_along(x$values)){
    cat(sprintf("  %s: %s", x$values[[i]]$name, x$values[[i]]$value), sep = "\n")
  }
}

mc <- function (l) Filter(Negate(is.null), l)

p2c <- function(x) if(is.null(x)) NULL else paste0(x, collapse = ",")
