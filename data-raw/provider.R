# [WIP]
# ref) https://ndlsearch.ndl.go.jp/file/help/api/specifications/ndlsearch_api_ap1_20240209.pdf
provider <-
  tibble::tribble(
  ~name, ~id, ~no, ~search, ~harvest,
  "国立国会図書館雑誌記事索引", "zassaku", "R000000004", TRUE, TRUE,
  "青空文庫", "aozora", "R000000014", TRUE, TRUE
)

usethis::use_data(provider, overwrite = TRUE)
