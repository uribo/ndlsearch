test_that("OpenSearch", {
  expect_equal(
    .ndl_search(params = list(creator = "夏目漱石")),
    .ndl_search(creator = "夏目漱石")
  )
  expect_equal(
    .ndl_search(params = list(creator = "夏目漱石")),
    .ndl_search(params = list(creator = "夏目漱石"), creator = "夏目漱石")
  )
  expect_equal(
    .ndl_search(params = list(creator = "夏目漱石"), creator = "芥川龍之介"),
    .ndl_search(creator = "芥川龍之介")
  )
  expect_s3_class(
    ndl_search(creator = "夏目漱石"),
    "xml_document"
  )
  x <-
    .ndl_search(creator = "芥川龍之介 太宰治")
  expect_equal(
    x$url,
    paste0("https://ndlsearch.ndl.go.jp/api/opensearch?creator=",
           URLencode("芥川龍之介 太宰治"))
  )
})

test_that("OpenURL", {
  expect_s3_class(
    ndl_search(creator = "夏目漱石",
               end_point = "OpenURL"),
    "xml_document"
  )
})
