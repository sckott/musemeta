context("getty")

test_that("getty works", {
  skip_on_cran()
  skip_on_travis()

  aa <- getty(140725)
  bb <- lapply(c(140725,8197), getty)

  expect_is(aa, "getty")
  expect_is(aa$name, "character")
  expect_is(aa$link, "character")
  expect_is(aa$artist, "character")
  expect_is(aa$provenance, "list")
  expect_is(aa$description, "list")
  expect_is(aa$history, "list")
  expect_is(aa$history[[1]], "list")
  expect_named(aa$history[[1]], c('text', 'href', 'where_when'))

  expect_is(bb, "list")
  expect_is(bb[[1]], "getty")
  expect_is(bb[[2]], "getty")
  expect_is(bb[[1]]$name, "character")
  expect_is(bb[[1]]$provenance, "list")
  expect_is(bb[[1]]$provenance[[1]], "list")
  expect_named(bb[[1]]$description[[1]], c('name', 'value'))

  expect_more_than(length(aa), length(bb))
})

test_that("getty fails well", {
  skip_on_cran()
  skip_on_travis()

  # no input
  expect_error(getty(), "argument \"id\" is missing")
  # not found
  expect_error(getty("afafdaf"), "afafdaf not found")
})
