#' NDL Search API
#' @param params A named list of parameters to be passed to the API.
#' @param end_point A character string specifying the end point of the API.
#' @param ... Additional parameters to be passed to the API.
#' @export
#' @examples
#' \dontrun{
#' ndl_search(creator = "\u590f\u76ee")
#' }
#' @rdname ndl_search
ndl_search <- function(params = NULL, end_point = "OpenSearch", ...) {
  req <-
    .ndl_search(params, end_point, ...)
  resp <-
    req |>
    httr2::req_perform()
  if (httr2::resp_status(resp) != 200L) {
    resp
  } else {
    if (end_point == "OpenURL") {
      resp |>
        httr2::resp_body_html()
    } else {
      resp |>
        httr2::resp_body_xml()
    }
  }
}

#' @noRd
.ndl_search <- function(params = NULL, end_point = "OpenSearch", ...) {
  end_point <-
    rlang::arg_match(end_point,
                     c("SRU", "OpenSearch", "OpenURL"))
  req <-
    httr2::request(base_url) |>
    httr2::req_url_path_append(end_points[[end_point]])

  if (!is.null(params)) {
    params <-
      params |>
      purrr::list_assign(...)
    if (end_point == "SRU") {
      params <-
        .sru_param_modify(params)
    }
    req <-
      req |>
      httr2::req_url_query(!!!params)
  } else {
    if (end_point == "SRU") {
      params <-
        list(...)
      params <-
        .sru_param_modify(params)
      req <-
        req |>
        httr2::req_url_query(!!!params)
    } else {
      req <-
        req |>
        httr2::req_url_query(...)
    }
  }
  req
}

.sru_param_modify <- function(params) {
  list(
      operation = "searchRetrieve",
      version = "1.2",
      query = paste(names(params), params, sep = "=", collapse = " AND ")
    )
}
