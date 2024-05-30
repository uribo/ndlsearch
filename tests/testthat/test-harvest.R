test_that("OAI-PMH", {
  expect_equal(
    .ndl_harvest(params = list(verb = "GetRecord",
                               identifier = "oai:ndlsearch.ndl.go.jp:R100000002-I032561201",
                               metadataPrefix = "dcndl",
                               set = "iss-ndl-opac"))$url,
    "https://ndlsearch.ndl.go.jp/api/oaipmh?verb=GetRecord&identifier=oai%3Andlsearch.ndl.go.jp%3AR100000002-I032561201&metadataPrefix=dcndl&set=iss-ndl-opac"
  )
  expect_equal(
    .ndl_harvest(params = list(verb = "GetRecord",
                               identifier = "oai:ndlsearch.ndl.go.jp:R100000002-I032561201",
                               metadataPrefix = "dcndl",
                               set = "iss-ndl-opac"))$url,
    .ndl_harvest(verb = "GetRecord",
                 identifier = "oai:ndlsearch.ndl.go.jp:R100000002-I032561201",
                 metadataPrefix = "dcndl",
                 set = "iss-ndl-opac")$url
  )
})

test_that("OpenURL", {
  expect_s3_class(
    ndl_harvest(verb = "ListMetadataFormats"),
    "xml_document"
  )
})
