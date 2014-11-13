#' Get metadata for objects in the National Gallery of Art.
#'
#' @name met
#'
#' @param id An object id
#' @param ... Curl args passed on to \code{\link[httr]{GET}}
#' @examples \donttest{
#' nga(id=33267)
#' nga(47242)
#' nga(47243)
#' nga(45987)
#' }

#' @export
#' @rdname met
nga <- function(id, ...){
  out <- musemeta_GET(sprintf(ngabase(), id), ...)
  nga_parse(out)
}

#' @export
print.nga <- function(x, ...){
  cat(sprintf("<NGA metadata> %s", x$name), sep = "\n")
  cat(sprintf("  Inscription: %s", x$inscription), sep = "\n")
  cat(sprintf("  Provenance: %s", x$provenance), sep = "\n")
  cat("  Exhibition history:", sep = "\n")
  for(i in seq_along(x$history)){
    cat(sprintf("      %s: %s", x$history[[i]]$year, x$history[[i]]$info), sep = "\n")
  }
  cat("  Bibliography:", sep = "\n")
  for(i in seq_along(x$bibliography)){
    cat(sprintf("      %s: %s", x$bibliography[[i]]$year, x$bibliography[[i]]$info), sep = "\n")
  }
}

nga_parse <- function(x){
  tmp <- htmlParse(x)
  name <- xpathSApply(tmp, '//meta[@property="og:title"]', xmlGetAttr, "content")
  prov <- xmlValue(xpathApply(tmp, "//div[@id='provenance']", xmlChildren)[[1]][['p']])
  insc <- xmlValue(xpathApply(tmp, "//div[@id='inscription']", xmlChildren)[[1]][['p']])
  hist <- ext_(tmp, "history")
  biblio <- ext_(tmp, "bibliography")
  structure(list(name=name, provenance=prov, inscription=insc, history=hist,
                 bibliography=biblio), class="nga")
}

ngabase <- function() "http://www.nga.gov/content/ngaweb/Collection/art-object-page.%s.html"

ext_ <- function(input, name){
  tmp <- xpathApply(input, sprintf("//div[@id='%s']", name), xmlChildren)[[1]]
  unname(lapply(tmp[ names(tmp) == "dl" ], function(x){
    setNames(unname(sapply(c('dt','dd'), function(y) xpathApply(x, y, xmlValue))), c('year','info'))
  }))
}
