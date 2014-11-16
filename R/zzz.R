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

catpaswrap <- function(x, y, space, width=70, exdent=10, ...){
  cat(sprintf("%s%s: %s", space, y, paste0(strwrap(x, width = width, exdent = exdent, ...), collapse = "\n")), sep="\n")
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

strmatch <- function(x, y) regmatches(x, regexpr(y, x))
