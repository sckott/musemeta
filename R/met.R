#' Get metadata for objects in the Metropolitan Museum of Art.
#'
#' @export
#' @param id An object id
#' @param ascii (logical) Allow non-ascii characters. Set to `TRUE` to show
#' non-ascii characters. Default: `FALSE`
#' @param ... curl options passed on to [crul::verb-GET]
#' @examples \dontrun{
#' (out <- met(246562))
#' out$name
#' out$values
#' met(228901)
#' met(479283)
#' lapply(c(479283, 228901, 436876, 444244), met)
#' }
met <- function(id, ascii = FALSE, ...) {
  out <- musemeta_GET(paste0(metbase(), id), useragent=sample(zoob, 1), ...)
  met_parse(out, ascii, id)
}

met_parse <- function(x, ascii, id) {
  tmp <- xml2::read_html(x)
  title <- strw(strsplit(xml2::xml_text(xml2::xml_find_first(tmp, "//title")), "\\|")[[1]])[[1]]

  tcon <- xml2::xml_find_first(tmp, "//div[@class='artwork__tombstone']")
  name <- gsub(":", "", xml2::xml_text(xml2::xml_find_all(tcon, '//p/span[@class="artwork__tombstone--label"]')))
  tags <- xml2::xml_text(xml2::xml_find_all(tcon, '//p/span[@class="artwork__tombstone--value"]'))
  tags <- unname(Map(function(x, y) list(name = x, value = y), name, tags))
  structure(nonascii(list(name = id, values = tags), ascii), class = "muse")
}

metbase <- function() "https://www.metmuseum.org/art/collection/search/"

zoob <- c(
  "Mozilla/5.0 (Macintosh; PPC Mac OS X 10_10_8 rv:2.0; af-ZA) AppleWebKit/533.14.7 (KHTML, like Gecko) Version/5.0.1 Safari/533.14.7",
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_0) AppleWebKit/5312 (KHTML, like Gecko) Chrome/15.0.847.0 Safari/5312",
  "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/5321 (KHTML, like Gecko) Chrome/37.0.815.0 Safari/5321",
  "Opera/8.83.(Windows NT 5.2; cy-GB) Presto/2.9.184 Version/11.00",
  "Opera/9.26.(X11; Linux x86_64; ss-ZA) Presto/2.9.183 Version/12.00",
  "Mozilla/5.0 (compatible; MSIE 5.0; Windows NT 6.2; Trident/3.0)",
  "Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_11_0) AppleWebKit/5361 (KHTML, like Gecko) Chrome/49.0.815.0 Safari/5361"
)
