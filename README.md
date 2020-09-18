musemeta
=======



[![R-check](https://github.com/sckott/musemeta/workflows/R-check/badge.svg)](https://github.com/sckott/musemeta/actions/)
[![codecov](https://codecov.io/gh/sckott/musemeta/branch/master/graph/badge.svg)](https://codecov.io/gh/sckott/musemeta)

**R client for museum metadata**

Currently `musemeta` can get data from:

* The [Canadian Science & Technology Museum Corporation](http://techno-science.ca/en/index.php) (CSTMC) (see functions `cstmc_()`)
* The [Getty Museum](http://www.getty.edu/) (see function `getty()`)
* The [Art Institute of Chicago](http://www.artic.edu/) (see function `aic()`)
* The [Asian Art Museum of San Francisco](http://www.asianart.org/) (see function `aam()`)

Other sources of museum metadata will be added...check back later & see [issues](https://github.com/sckott/musemeta/issues).

## Install


```r
remotes::install_github("sckott/musemeta")
```


```r
library("musemeta")
```

## Meta

* Please [report any issues or bugs](https://github.com/sckott/musemeta/issues).
* License: MIT
* Get citation information for `musemeta` in R doing `citation(package = 'musemeta')`

## Code of Conduct

Please note that the musemeta project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
