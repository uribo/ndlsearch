#' NDL Harvest API
#'
#' @inheritParams ndl_search
#' @export
#' @examples
#' \dontrun{
#' ndl_harvest(params = list(verb = "GetRecord",
#'                           identifier = "oai:ndlsearch.ndl.go.jp:R100000002-I032561201",
#'                           metadataPrefix = "dcndl",
#'                           set = "iss-ndl-opac"))
#' }
ndl_harvest <- function(params = NULL, ...) {
  req <-
    .ndl_harvest(params, ...)
  resp <-
    req |>
    httr2::req_perform()
  if (httr2::resp_status(resp) != 200L) {
    resp
  } else {
    resp |>
      httr2::resp_body_xml()
  }
}

.ndl_harvest <- function(params = NULL, ...) {
  req <-
    httr2::request(base_url) |>
    httr2::req_url_path_append(end_points[["OAI-PMH"]])
  if (!is.null(params)) {
    params <-
      params |>
      purrr::list_assign(...)
  } else {
    params <-
      list(...)
  }
  req <-
    req |>
    httr2::req_url_query(!!!params)
  req
}
