context("aam")

test_that("aam works", {
  skip_on_cran()

  vcr::use_cassette("aam", {
    aa <- aam(17150)
  })

  vcr::use_cassette("aam_many", {
    bb <- lapply(c(17150,17140), aam)
  })

  expect_is(aa, "aam")
  expect_is(aa$title, "character")
  expect_is(aa$artist, "character")
  expect_is(aa$materials, "character")
  expect_is(aa$collection, "character")

  expect_is(bb, "list")
  expect_is(bb[[1]], "aam")
  expect_is(bb[[2]], "aam")
  expect_is(bb[[1]]$title, "character")

  expect_gt(length(aa), length(bb))
})

test_that("aam fails well", {
  skip_on_cran()

  # no input
  expect_error(aam(), "argument \"id\" is missing")
  # not found
  expect_warning(aam("afafdaf"))
})
