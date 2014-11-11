musemeta
=======



[![Build Status](https://api.travis-ci.org/ropensci/musemeta.png)](https://travis-ci.org/ropensci/musemeta)
[![Build status](https://ci.appveyor.com/api/projects/status/ytgtb62gsgf5hddi/branch/master)](https://ci.appveyor.com/project/sckott/musemeta/branch/master)

**R client for museum metadata**

## Quick start

### Install

Install musemeta


```r
install.packages("devtools")
devtools::install_github("ropensci/musemeta")
```


```r
library("musemeta")
```

### Get metadata

Data for a single object


```r
muse_get(559490)
#> <Museum metadata> Siphon nozzle
#>   Period: New Kingdom, Ramesside
#>   Dynasty: Dynasty 19–20
#>   Date: ca. 1295–1070 B.C.
#>   Geography: From Egypt, Memphite Region, Lisht North, Cemetery, MMA 1913–1914
#>   Medium: Bronze
#>   Dimensions: l. 5.4 cm (2 1/8 in)
#>   Credit Line: Rogers Fund and Edward S. Harkness Gift, 1922
#>   Accession Number: 22.1.962
```

Or index to name of object, or values in the description


```r
muse_get(559490)$name
#> [1] "Siphon nozzle"
```


```r
muse_get(559490)$values
#> [[1]]
#> [[1]]$name
#> [1] "Period"
#> 
#> [[1]]$value
#> [1] "New Kingdom, Ramesside"
#> 
#> 
#> [[2]]
#> [[2]]$name
#> [1] "Dynasty"
#> 
#> [[2]]$value
#> [1] "Dynasty 19–20"
#> 
#> 
#> [[3]]
#> [[3]]$name
#> [1] "Date"
#> 
#> [[3]]$value
#> [1] "ca. 1295–1070 B.C."
#> 
#> 
#> [[4]]
#> [[4]]$name
#> [1] "Geography"
#> 
#> [[4]]$value
#> [1] "From Egypt, Memphite Region, Lisht North, Cemetery, MMA 1913–1914"
#> 
#> 
#> [[5]]
#> [[5]]$name
#> [1] "Medium"
#> 
#> [[5]]$value
#> [1] "Bronze"
#> 
#> 
#> [[6]]
#> [[6]]$name
#> [1] "Dimensions"
#> 
#> [[6]]$value
#> [1] "l. 5.4 cm (2 1/8 in)"
#> 
#> 
#> [[7]]
#> [[7]]$name
#> [1] "Credit Line"
#> 
#> [[7]]$value
#> [1] "Rogers Fund and Edward S. Harkness Gift, 1922"
#> 
#> 
#> [[8]]
#> [[8]]$name
#> [1] "Accession Number"
#> 
#> [[8]]$value
#> [1] "22.1.962"
```

A different object


```r
muse_get(246562)
#> <Museum metadata> Terracotta guttus (flask with handle and spout)
#>   Period: Classical
#>   Date: 4th century B.C.
#>   Culture: Greek, South Italian, Campanian
#>   Medium: Terracotta; black-glaze
#>   Dimensions: 2 7/8in. (7.3cm)
#>   Classification: Vases
#>   Credit Line: Purchase by subscription, 1896
#>   Accession Number: 96.18.35
```

### Meta

* Please report any issues or bugs](https://github.com/ropensci/musemeta/issues).
* License: MIT
* Get citation information for `musemeta` in R doing `citation(package = 'musemeta')`

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
