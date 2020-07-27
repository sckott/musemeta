context("aic")

test_that("aic works", {
  skip_on_cran()

  vcr::use_cassette("aic", {
    aa <- aic(87531)
  })

  vcr::use_cassette("aic_many", {
    bb <- lapply(c(11475,41594,59978), aic)
  })

  expect_is(aa, "aic")
  expect_is(aa$id, "character")
  expect_is(aa$artist, "character")
  expect_is(aa$title, "character")
  expect_is(aa$medium, "character")

  expect_is(bb, "list")
  expect_is(bb[[1]], "aic")
  expect_is(bb[[2]], "aic")
  expect_is(bb[[1]]$title, "character")

  expect_gt(length(aa), length(bb))
})

test_that("aic fails well", {
  skip_on_cran()

  # no input
  expect_error(aic(), "argument \"id\" is missing")
  # not found
  expect_error(aic("afafdaf"))
})
