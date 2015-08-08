context("met")

test_that("met works", {
  skip_on_cran()

  aa <- met(559490)
  bb <- met(246562)
  cc <- lapply(c(479283, 228901), met)

  expect_is(aa, "muse")
  expect_is(aa$name, "character")
  expect_is(aa$values, "list")
  expect_is(aa$values[[1]], "list")
  expect_named(aa$values[[1]], c('name', 'value'))

  expect_is(bb, "muse")
  expect_is(bb$name, "character")
  expect_is(bb$values, "list")
  expect_is(bb$values[[1]], "list")
  expect_named(bb$values[[1]], c('name', 'value'))

  expect_is(cc, "list")
  expect_is(cc[[1]], "muse")
  expect_is(cc[[2]], "muse")
  expect_is(cc[[1]]$name, "character")
  expect_is(cc[[1]]$values, "list")
  expect_is(cc[[1]]$values[[1]], "list")
  expect_named(cc[[1]]$values[[1]], c('name', 'value'))

  expect_equal(length(aa), length(bb))
  expect_equal(length(cc), length(bb))
})

test_that("met fails well", {
  skip_on_cran()

  # no input
  expect_error(met(), "argument \"id\" is missing")
  # not found
  expect_error(met(id = "afafdaf"), "afafdaf not found")
})
