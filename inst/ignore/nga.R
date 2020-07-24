#' Get metadata for objects in the National Gallery of Art.
#'
#' @export
#' @param id An object id
#' @param ascii (logical) Allow non-ascii characters. Set to `TRUE` to show
#' non-ascii characters. Default: `FALSE`
#' @param ... Curl args passed on to [crul::verb-GET]
#' @examples \dontrun{
#' nga(33267)
#' nga(47242)
#' nga(47243)
#' nga(45987)
#' nga(33268)
#' lapply(c(75861,20820,75959,27809,143679,27773,28487), nga)
#' nga(45987, verbose = TRUE)
#' browse(nga(33268))
#' }
nga <- function(id, ascii = FALSE, ...){
  out <- musemeta_GET(sprintf(ngabase(), id), ...)
  nga_parse(out, ascii)
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

nga_parse <- function(x, ascii) {
  html <- read_html(x)
  # xml2::write_html(html, "x.html")
  name <- xml_attr(xml_find_all(html, '//meta[@property="og:title"]'), "content")
  link <- xml_attr(xml_find_all(html, '//div[@data-url]'), "data-url")
  artist <- xml_find_all(html, '//dt[@class="artist"]//a')[[1]]
  artist <- list(
    name=gsub("\n|\\s\\s+", "", xml_text(artist)), 
    link=paste0('https://www.nga.gov', xml_attr(artist, "href")))
  desc <- xml_find_all(html, '//dl[@class="artwork-details"]')[[1]]
  desc <- list(
    created=namval(desc, "dt", "created"),
    medium=namval(desc, "dd", "medium"),
    dimensions=namval(desc, "dd", "dimensions"),
    credit=namval(desc, "dd", "credit"),
    accession=namval(desc, "dd", "accession"))
  prov <- xml_text(xml_find_first(html, "//div[@data-id='provenance']/p"))
  insc <- xml_text(xml_find_first(html, "//div[@data-id='inscription']/p"))
  hist <- ext_(html, "history")
  biblio <- ext_(html, "bibliography")
  all <- list(name=name, link=link, artist=artist, provenance=prov,
              description=desc, inscription=insc, history=hist,
              bibliography=biblio)
  structure(nonascii(all, ascii), class="nga")
}

ngabase <- function() "https://www.nga.gov/collection/art-object-page.%s.html"
