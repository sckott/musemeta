context("getty")

test_that("getty works", {
  skip_on_cran()
  skip_on_ci()

  aa <- getty(138860)
  bb <- lapply(c(138860, 4967), getty)

  expect_is(aa, "getty")
  expect_is(aa$name, "character")
  expect_is(aa$link, "character")
  expect_is(aa$maker, "character")
  expect_is(aa$provenance, "character")

  expect_is(bb, "list")
  expect_is(bb[[1]], "getty")
  expect_is(bb[[2]], "getty")
  expect_is(bb[[1]]$name, "character")
  # expect_is(bb[[2]]$provenance, "list")
  # expect_is(bb[[1]]$provenance[[1]], "list")
  # expect_named(bb[[1]]$description[[1]], c('name', 'value'))

  expect_gt(length(aa), length(bb))
})

test_that("getty fails well", {
  skip_on_cran()
  skip_on_ci()

  # no input
  expect_error(getty(), "argument \"id\" is missing")
  # not found
  expect_error(getty("afafdaf"), class = "http_404")
})
