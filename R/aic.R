#' Get metadata for objects in the Art Institute of Chicago.
#'
#' @export
#' @param id An object id
#' @param ascii (logical) Allow non-ascii characters. Set to `TRUE` to show
#' non-ascii characters. Default: `FALSE`
#' @param ... Curl args passed on to [crul::verb-GET]
#' @details Sorry, but the metadata returned in this function is a bit messy
#' because the metadata given for each piece is not stuctured, i.e., all
#' elements are simply in html p tags, so its hard to have consistent parsing.
#' @examples \dontrun{
#' aic(40652)
#' aic(145241)
#' aic(87531)
#' aic(80538)
#' aic(11332)
#' aic(11287)
#' aic(210804)
#' 
#' # with artwork body description
#' aic(11475) 
#' 
#' # many at once
#' lapply(c(11475,41594,59978,129410,41033,3394,21535,11475,41033), aic)
#' 
#' # browse to the page
#' out <- aic(210765)
#' out
#' unclass(out)
#' browse(out)
#'
#' aic(8254)
#' aic(25316)
#' }
aic <- function(id, ascii = FALSE, ...) {
  out <- musemeta_GET(paste0(aicbase(), id), ...)
  aic_parse(out, id, ascii)
}

#' @export
print.aic <- function(x, ...){
  cat(sprintf("<AIC metadata> %s", x$id), sep = "\n")
  cat(paste0("   Artist: ", x$artist), sep = "\n")
  cat(paste0("   Link: ", x$link), sep = "\n")
  catpaswrap(x$title, "Title", "   ", exdent = 6)
  catpaswrap(x$origin, "Origin", "   ", exdent = 6)
  catpaswrap(x$date, "Date", "   ", exdent = 6)
  catpaswrap(x$medium, "Medium", "   ", exdent = 6)
  catpaswrap(x$dimensions, "Dimensions", "   ", exdent = 6)
  catpaswrap(x$`credit line`, "Credit line", "   ", exdent = 6)
  catpaswrap(x$description, "Description", "   ", exdent = 6)
}

aic_parse <- function(x, id, ascii) {
  aictxt <- "\"| \\| The Art Institute of Chicago"
  html <- read_html(x)
  material <- xml_text(xml_find_first(html, '//dd[@itemprop="material"]/span'))
  desc <- xml_text(xml_find_first(html, '//div[@itemprop="description"]/p'))
  keys <- noquote(strwnewl(xml_text(
    xml_find_all(html, '//dl[@id="dl-artwork-details"]/dt'))))
  vals <- noquotes(strwnewl(xml_text(
    xml_find_all(html, '//dl[@id="dl-artwork-details"]/dd'))))
  deets <- as.list(stats::setNames(vals, keys))
  link <- paste0(aicbase(), id)
  all <- c(list(id=id, link=link, description=desc), deets)
  names(all) <- tolower(names(all))
  structure(nonascii(all, ascii), class="aic")
}

aicbase <- function() "https://www.artic.edu/artworks/"
