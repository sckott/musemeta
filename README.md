musemeta
=======



[![R-check](https://github.com/ropensci/musemeta/workflows/R-check/badge.svg)](https://github.com/ropensci/musemeta/actions/)
[![codecov](https://codecov.io/gh/ropensci/musemeta/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/musemeta)

**R client for museum metadata**

Currently `musemeta` can get data from:

* The [Canadian Science & Technology Museum Corporation](http://techno-science.ca/en/index.php) (CSTMC) (see functions `cstmc_()`)
* The [Getty Museum](http://www.getty.edu/) (see function `getty()`)
* The [Art Institute of Chicago](http://www.artic.edu/) (see function `aic()`)
* The [Asian Art Museum of San Francisco](http://www.asianart.org/) (see function `aam()`)

Other sources of museum metadata will be added...check back later & see [issues](https://github.com/ropensci/musemeta/issues).

## Install


```r
install.packages("musemeta")
```

OR


```r
remotes::install_github("ropensci/musemeta")
```


```r
library("musemeta")
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/musemeta/issues).
* License: MIT
* Get citation information for `musemeta` in R doing `citation(package = 'musemeta')`
* Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.

[![ro_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
