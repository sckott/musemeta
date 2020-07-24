musemeta_GET <- function(url, args = NULL, ...) {
  con <- crul::HttpClient$new(url, opts = list(followlocation=TRUE, ...))
  res <- con$get(query = args)
  res$raise_for_status()
  res$parse("UTF-8")
}

#' @export
print.muse <- function(x, ...){
  cat(sprintf("<Museum metadata> %s", x$name), sep = "\n")
  for (i in seq_along(x$values)) {
    cat(sprintf("  %s: %s", x$values[[i]]$name, x$values[[i]]$value),
      sep = "\n")
  }
}

mc <- function(l) Filter(Negate(is.null), l)

p2c <- function(x) if (is.null(x)) NULL else paste0(x, collapse = ",")

catpaswrap <- function(x, y, space, width=70, exdent=10, ...) {
  cat(sprintf("%s%s: %s", space, y,
    paste0(strwrap(x, width = width, exdent = exdent, ...), collapse = "\n")),
  sep = "\n")
}

namval <- function(desc, x, y) {
  tmp <- xml_find_all(desc, sprintf('%s[@class="%s"]', x, y))
  if (length(tmp) == 1) {
    list(
      name = xml_attr(tmp[[1]], "class"),
      value = xml_text(tmp[[1]])
    )
  } else {
    list(
      name = xml_attr(tmp[[1]], "class"),
      value = paste0(sapply(tmp, xml_text), collapse = ", ")
    )
  }
}

ext_ <- function(input, name){
  tmp <- xml_children(
    xml_find_all(input, sprintf("//div[@data-id='%s']", name)))
  res <- unname(lapply(tmp[ xml_name(tmp) == "dl" ], function(x) {
    as.list(stats::setNames(unname(sapply(c('dt','dd'), function(y)
        xml_text(xml_find_all(x, y))
      )), c('year','info')))
  }))
  lapply(res, function(w) {
    if ("year" %in% names(w)) {
      w$year <- gsub("[[:blank:]]|\n", "", w$year)
    }
    w
  })
}

strmatch <- function(x, y) regmatches(x, gregexpr(y, x))

nonascii <- function(z, ascii = FALSE) {
  if (ascii) {
    return(z)
  } else {
    rapply(z, function(x) gsub("[^\x20-\x7F]", " ", x), how = "list")
  }
}

c2utf8 <- function(x) {
  content(x, "text", encoding = "UTF-8")
}

strw <- function(x) gsub("^\\s|\\s$", "", x)
strwnewl <- function(x) gsub("^\\s+|\\s+$|\n\\s+$", "", x)
noquotes <- function(x) gsub("\"", "", x)
