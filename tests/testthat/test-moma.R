context("moma")

test_that("moma works", {
  skip_on_cran()
  skip_on_ci()

  vcr::use_cassette("moma_artists", {
    aa <- moma_artists()
  })
  expect_is(aa, "tbl")

  # vcr::use_cassette("moma_artwork", {
  #   bb <- moma_artwork()
  # })
  # expect_is(bb, "tbl")
})
