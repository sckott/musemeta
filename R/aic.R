#' Get metadata for objects in the Art Institute of Chicago.
#'
#' @export
#' @param id An object id
#' @param ascii (logical) Allow non-ascii characters. Set to \code{TRUE} to show
#' non-ascii characters. Default: FALSE
#' @param ... Curl args passed on to \code{\link[httr]{GET}}
#' @details Sorry, but the metadata returned in this function is a bit messy because the metadata
#' given for each piece is not stuctured, i.e., all elements are simply in html p tags, so its
#' hard to have consistent parsing.
#' @examples \donttest{
#' aic(40652)
#' aic(145241)
#' aic(87531)
#' aic(80538)
#' aic(11332)
#' aic(11287)
#' aic(210804)
#' aic(11475) # with artwork body description
#' aic(41033) # with history
#' lapply(c(11475,41594,59978,129410,41033,3394,21535,11475,41033), aic)
#' out <- aic(210765)
#' out
#' unclass(out)
#' browse(out)
#'
#' aic(8254)
#' aic(25316)
#' }
aic <- function(id, ascii = FALSE, ...){
  out <- musemeta_GET(paste0(aicbase(), id), ...)
  aic_parse(out, id, ascii)
}

#' @export
print.aic <- function(x, ...){
  cat(sprintf("<AIC metadata> %s", x$id), sep = "\n")
  cat("   Artist:", sep = "\n")
  cat(paste0("      Name: ", x$artist$name), sep = "\n")
  cat(paste0("      Years: ", x$artist$years), sep = "\n")
  cat(paste0("   Link: ", x$link), sep = "\n")
  catpaswrap(x$title, "Title", "   ", exdent = 6)
  catpaswrap(x$description, "Description", "   ", exdent = 6)
  catpaswrap(x$display, "Description-2", "   ")
  catpaswrap(x$artwork_body, "Artwork body", "   ")
  cat("   Exhibition history:", sep = "\n")
  for(i in seq_along(x$exhibition_history)){
    catpaswrap(x$exhibition_history[[i]], "- ", "     ")
  }
  cat("   Publication history:", sep = "\n")
  for(i in seq_along(x$publication_history)){
    catpaswrap(x$publication_history[[i]], "- ", "     ")
  }
  catpaswrap(x$ownership_history, "Ownership history", "   ")
}

aic_parse <- function(x, id, ascii){
  tmp <- htmlParse(x)
  ps <- xpathSApply(tmp, '//div[@id="tombstone"]//p')
  title <- xmlValue(ps[[2]])
  artist <- gsub("\n", " ", xmlValue(ps[[1]]))
  artist <- list(name=getname(artist), years=strmatch(artist, "[0-9]{4}.[0-9]+|[0-9]{4}"))
  desc <- gsub("\n|^\\s+", "", xmlValue(ps[[3]]))
  display <- gsub("\n|^\\s+|\\s+$", "", xmlValue(ps[[4]]))
  link <- paste0(aicbase(), id)
  deets <- get_deets(tmp)
  all <- c(list(id=id, title=title, link=link, artist=artist,
         description=desc, display=display), deets)
  structure(nonascii(all, ascii), class="aic")
}

aicbase <- function() "http://www.artic.edu/aic/collections/artwork/"

getname <- function(x) gsub("\\(", ", ", strsplit(x, ",")[[1]][[1]])

get_deets <- function(x){
  nn <- xpathSApply(x, '//div[@id="artwork-body"]')
  if(length(nn) == 0){
    c(artwork_body=NULL, exhibition_history=NULL,
      publication_history=NULL, ownership_history=NULL)
  } else {
    nn <- nn[[1]]
    xmllist <- xmlToList(nn)
    keep1 <- mc(xmllist[ names(xmllist) == "p" ])
    ab <- if(length(keep1)==0) NULL else paste0(keep1[[1]], collapse = " ")
    div1 <- unlist(xmllist[ names(xmllist) == "div" ])
    divh2locs <- grep("div.h2", names(div1))
    nms <- sub("\\s", "_", tolower(unname(div1[grep("div.h2", names(div1))])))
    ptextlocs <- grep("div.p.text", names(div1))
    if(length(ptextlocs)==0) ptextlocs <- grep("div.p", names(div1))
    out <- list()
    for(i in seq_along(divh2locs)){
      if(i < length(divh2locs)){
        out[[i]] <- gsub("\n", "", unname(div1[ptextlocs[ptextlocs > divh2locs[i] & ptextlocs < divh2locs[i+1]]]))
      } else {
        matches <- ptextlocs > divh2locs[i]
        if(!all(matches)){
          pt <- grep("div.p", names(div1))
          out[[i]] <- gsub("\n", "", unname(div1[pt[pt > divh2locs[i]]]))
        } else {
          out[[i]] <- NULL
        }
      }
    }
    c(artwork_body=ab, setNames(out, nms))
  }
}
