#' @title musemeta
#' @description R client for museum metadata
#' @importFrom crul HttpClient
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET content stop_for_status config
#' @importFrom xml2 read_html xml_find_first xml_text xml_find_all xml_attr
#' xml_children xml_name
#' @importFrom ckanr changes package_list group_list group_show tag_list tag_show
#' package_search package_show resource_search
#' @importFrom tibble as_tibble
#' @name musemeta-package
#' @aliases musemeta
#' @docType package
#' @author Scott Chamberlain
#' @keywords package
NULL
