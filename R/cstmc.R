#' Query for data from the CSTMC (Canadian Science & Technology Museum Corporation)
#'
#' @import ckanr
#' @name cstmc
#' @param id (character) The name or id of the tag
#' @param query (character) A tag name query to search for, if given only tags whose names contain
#' this string will be returned
#' @param vocabulary_id (character) The id or name of a vocabulary, if give only tags that belong
#' to this vocabulary will be returned
#' @param all_fields (logical) Return full tag or group dictionaries instead of just names.
#' Default: FALSE
#' @param q Query terms, defaults to '*:*', or everything. It is a string of the form
#' \code{field:term} or a list of strings, each of the same form.  Within each string, \code{field}
#' is a field or extra field on the Resource domain object. If \code{field} is hash, then an
#' attempt is made to match the \code{term} as a *prefix* of the Resource.hash field. If
#' \code{field} is an extra field, then an attempt is made to match against the extra fields
#' stored against the Resource.
#' @param sort Field to sort on. You can specify ascending (e.g., score desc) or
#' descending (e.g., score asc), sort by two fields (e.g., score desc, price asc),
#' or sort by a function (e.g., sum(x_f, y_f) desc, which sorts by the sum of
#' x_f and y_f in a descending order).
#' @param offset Record to start at, default to beginning.
#' @param limit Number of records to return.
#' @param use_default_schema (logical) Use default package schema instead of a custom
#' schema defined with an IDatasetForm plugin. Default: FALSE
#' @param fq Filter query, this does not affect the search, only what gets returned
#' @param rows Number of records to return. Defaults to 10.
#' @param start Record to start at, default to beginning.
#' @param facet (logical) Whether to return facet results or not. Default: FALSE
#' @param facet.limit (numeric) This param indicates the maximum number of constraint counts
#' that should be returned for the facet fields. A negative value means unlimited.
#' Default: 100. Can be specified on a per field basis.
#' @param facet.field (charcter) This param allows you to specify a field which should be
#' treated as a facet. It will iterate over each Term in the field and generate a
#' facet count using that Term as the constraint. This parameter can be specified
#' multiple times to indicate multiple facet fields. None of the other params in
#' this section will have any effect without specifying at least one field name
#' using this param.
#' @param include_datasets (logical) Include a list of the group's datasets. Default: TRUE
#' @param groups (character) A list of names of the groups to return, if given only groups whose
#' names are in this list will be returned
#' @param as (character) One of list (default), table, or json. Parsing with table option
#' uses \code{jsonlite::fromJSON(..., simplifyDataFrame = TRUE)}, which attempts to parse
#' data to data.frame's when possible, so the result can vary.
#' @param ... Curl args passed on to \code{\link[httr]{POST}}
#'
#' @references \url{http://data.techno-science.ca/}
#' @examples \donttest{
#' # Changes
#' cstmc_changes()
#' cstmc_changes(as='json')
#' cstmc_changes(as='table')
#'
#' # List datasets
#' cstmc_datasets()
#'
#' # List groups
#' cstmc_group_list()
#'
#' # Show groups
#' cstmc_group_show('communications')
#'
#' # List tags
#' cstmc_tag_list('aviation')
#'
#' # Show tags
#' cstmc_tag_show('Aviation')
#'
#' # Search for packages
#' cstmc_package_search(q = '*:*')
#' cstmc_package_search(q = '*:*', rows = 2, as='json')
#' cstmc_package_search(q = '*:*', rows = 2, as='table')
#'
#' cstmc_package_search(q = '*:*', sort = 'score asc')
#' cstmc_package_search(q = '*:*', fq = 'num_tags:[3 TO *]')$count
#'
#' # Show packages
#' cstmc_package_show('34d60b13-1fd5-430e-b0ec-c8bc7f4841cf')
#' cstmc_package_show('34d60b13-1fd5-430e-b0ec-c8bc7f4841cf', as='json')
#' cstmc_package_show('34d60b13-1fd5-430e-b0ec-c8bc7f4841cf', as='table')
#' cstmc_package_show('34d60b13-1fd5-430e-b0ec-c8bc7f4841cf', TRUE)
#'
#' # Search for resources
#' cstmc_resource_search(q = 'name:data')
#' cstmc_resource_search(q = 'name:data', as='json')
#' cstmc_resource_search(q = 'name:data', as='table')
#' cstmc_resource_search(q = 'name:data', limit = 2, as='table')
#' }
NULL

#' @export
#' @rdname cstmc
cstmc_changes <- function(offset=0, limit=31, as='list', ...){
  ckanr::changes(offset=offset, limit=limit, url=cstmcbase(), as=as, ...)
}

#' @export
#' @rdname cstmc
cstmc_datasets <- function(offset=0, limit=31, as='list', ...){
  ckanr::datasets(offset=offset, limit=limit, url=cstmcbase(), as=as, ...)
}

#' @export
#' @rdname cstmc
cstmc_group_list <- function(offset=0, limit=31, sort = NULL, groups = NULL, all_fields = FALSE,
  as='list', ...)
{
  ckanr::group_list(offset=offset, limit=limit, sort=sort, groups=groups,
                    all_fields=all_fields, url=cstmcbase(), as=as, ...)
}

#' @export
#' @rdname cstmc
cstmc_group_show <- function(id, include_datasets = TRUE, as='list', ...){
  ckanr::group_show(id=id, include_datasets=include_datasets, url=cstmcbase(), as=as, ...)
}

#' @export
#' @rdname cstmc
cstmc_tag_list <- function(query = "*:*", vocabulary_id = NULL, all_fields = FALSE, as='list', ...){
  ckanr::tag_list(query = query, vocabulary_id = vocabulary_id,
                  all_fields = all_fields, url=cstmcbase(), as=as, ...)
}

#' @export
#' @rdname cstmc
cstmc_tag_show <- function(id, as='list', ...){
  ckanr::tag_show(id=id, url=cstmcbase(), as=as, ...)
}

#' @export
#' @rdname cstmc
cstmc_package_search <- function(q = "*:*", fq = NULL, sort = NULL, rows = NULL, start = NULL,
  facet = FALSE, facet.limit = NULL, facet.field = NULL, as='list', ...)
{
  ckanr::package_search(q = q, fq = fq, sort = sort, rows = rows,
                        start = start, facet = facet, facet.limit = facet.limit,
                        facet.field = facet.field, url=cstmcbase(), as=as, ...)
}

#' @export
#' @rdname cstmc
cstmc_package_show <- function(id, use_default_schema = FALSE, as='list', ...){
  ckanr::package_show(id = id, use_default_schema = use_default_schema, url=cstmcbase(), as=as, ...)
}

#' @export
#' @rdname cstmc
cstmc_resource_search <- function(q = "*:*", sort = NULL, offset = NULL, limit = NULL, as='list', ...){
  ckanr::resource_search(q = q, sort = sort, offset = offset, limit = limit, url=cstmcbase(), as=as, ...)
}

cstmcbase <- function() 'http://data.techno-science.ca'
