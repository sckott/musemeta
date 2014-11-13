#' Get metadata for objects in the National Gallery of Art.
#'
#' @export
#' @param id An object id
#' @param ... Curl args passed on to \code{\link[httr]{GET}}
#' @examples \donttest{
#' nga(id=33267)
#' nga(47242)
#' nga(47243)
#' nga(45987)
#' nga(33268)
#' lapply(c(75861,20820,75959,27809,143679,27773,28487), nga)
#'
#' library('httr')
#' nga(45987, config=verbose())
#' }
nga <- function(id, ...){
  out <- musemeta_GET(sprintf(ngabase(), id), ...)
  nga_parse(out)
}

#' @export
print.nga <- function(x, ...){
  cat(sprintf("<NGA metadata> %s", x$name), sep = "\n")
  catpaswrap(x$artist$name, "Artist", "  ")
  catpaswrap(x$inscription, "Inscription", "  ")
  catpaswrap(x$provenance, "Provenance", "  ")
  cat("  Description:", sep = "\n")
  for(i in seq_along(x$description)){
    cat(sprintf("     %s: %s", x$description[[i]]$name, x$description[[i]]$value), sep = "\n")
  }
  cat("  Exhibition history:", sep = "\n")
  for(i in seq_along(x$history)){
    catpaswrap(x$history[[i]]$info, x$history[[i]]$year, "     ")
  }
  cat("  Bibliography:", sep = "\n")
  for(i in seq_along(x$bibliography)){
    catpaswrap(x$bibliography[[i]]$info, x$bibliography[[i]]$year, "     ")
  }
}

catpaswrap <- function(x, y, space, width=70, exdent=10, ...){
  cat(sprintf("%s%s: %s", space, y, paste0(strwrap(x, width = width, exdent = exdent, ...), collapse = "\n")), sep="\n")
}

nga_parse <- function(x){
  tmp <- htmlParse(x)
  name <- xpathSApply(tmp, '//meta[@property="og:title"]', xmlGetAttr, "content")
  link <- xpathSApply(tmp, "//div[@data-url]", xmlGetAttr, "data-url")
  artist <- xpathSApply(tmp, '//dt[@class="artist"]//a')[[1]]
  artist <- list( name=gsub("\n|\\s\\s+", "", xmlValue(artist)), link=paste0('http://www.nga.gov', xmlGetAttr(artist, "href")) )
  desc <- xpathSApply(tmp, '//dl[@class="artwork-details"]')[[1]]
  desc <- list(created=namval(desc, "dt", "created"),
               medium=namval(desc, "dd", "medium"),
               dimensions=namval(desc, "dd", "dimensions"),
               credit=namval(desc, "dd", "credit"),
               accession=namval(desc, "dd", "accession"))

  prov <- xmlValue(xpathApply(tmp, "//div[@id='provenance']", xmlChildren)[[1]][['p']])
  insc <- xmlValue(xpathApply(tmp, "//div[@id='inscription']", xmlChildren)[[1]][['p']])
  hist <- ext_(tmp, "history")
  biblio <- ext_(tmp, "bibliography")
  structure(list(name=name, link=link, artist=artist, provenance=prov,
                 description=desc, inscription=insc, history=hist,
                 bibliography=biblio), class="nga")
}

namval <- function(desc, x, y){
  tmp <- xpathSApply(desc, sprintf('%s[@class="%s"]', x, y))
  if(length(tmp) == 1){
    list(name=xmlGetAttr(tmp[[1]], "class"), value=xmlValue(tmp[[1]]))
  } else {
    list(name=xmlGetAttr(tmp[[1]], "class"), value=paste0(sapply(tmp, xmlValue), collapse = ", "))
  }
}

ext_ <- function(input, name){
  tmp <- xpathApply(input, sprintf("//div[@id='%s']", name), xmlChildren)[[1]]
  unname(lapply(tmp[ names(tmp) == "dl" ], function(x){
    setNames(unname(sapply(c('dt','dd'), function(y) xpathApply(x, y, xmlValue))), c('year','info'))
  }))
}

ngabase <- function() "http://www.nga.gov/content/ngaweb/Collection/art-object-page.%s.html"
