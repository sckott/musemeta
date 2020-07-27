context("cstmc")

test_that("cstmc works", {
  skip_on_cran()

  vcr::use_cassette("cstmc_package_show", {
    aa <- cstmc_package_show('34d60b13-1fd5-430e-b0ec-c8bc7f4841cf')
  })
  expect_is(aa, "ckan_package")
  expect_equal(aa$organization$title, "CSTMC")
  expect_equal(aa$organization$title, "CSTMC")

  vcr::use_cassette("cstmc_package_search", {
    bb <- cstmc_package_search(q = '*:*', rows = 2)
  })
  expect_is(bb, "list")
  expect_is(bb$results, "list")
  expect_is(bb$results[[1]], "ckan_package")
})
