musemeta
=======



[![Build Status](https://api.travis-ci.org/ropensci/musemeta.png)](https://travis-ci.org/ropensci/musemeta)
[![Build status](https://ci.appveyor.com/api/projects/status/y3tefs9xb6pmql36/branch/master?svg=true)](https://ci.appveyor.com/project/sckott/musemeta/branch/master)

**R client for museum metadata**

Currently `musemeta` only gets data for [The Metropolitan Museum of Art](http://www.metmuseum.org/) via 

* scraping the MET website (see function `muse_get()`)
* http://scrapi.org/ (see functions `scrapi_()`)

Other sources of museum metadata will be added...check back later.

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
#> Error in function (type, msg, asError = TRUE) : easy handled already used in multi handle
```

Or index to name of object, or values in the description


```r
muse_get(559490)$name
#> Error in function (type, msg, asError = TRUE) : easy handled already used in multi handle
```


```r
muse_get(559490)$values[1:2]
#> Error in function (type, msg, asError = TRUE) : easy handled already used in multi handle
```

A different object


```r
muse_get(246562)
#> Error in function (type, msg, asError = TRUE) : easy handled already used in multi handle
```

Get many objects


```r
lapply(c(479283, 228901, 436876), muse_get)
#> Error in function (type, msg, asError = TRUE) : easy handled already used in multi handle
```


### Use the scrapi API

This is again, for The Metropolitan Museum of Art only 

Get a random object, limit to a few fields for brevity


```r
scrapi_random(fields=c('medium','whoList'))
#> $medium
#> [1] "Tin, iron"
```

Get a specific object


```r
scrapi_info(123, fields=c('title','primaryArtistNameOnly','medium'))
#> $title
#> [1] "Andiron"
#> 
#> $primaryArtistNameOnly
#> [1] "Richard Wittingham"
#> 
#> $medium
#> [1] "Brass"
```

Search for objects


```r
scrapi_search(query='mirror')
#> $out
#>  [1] "http://scrapi.org/object/207785" "http://scrapi.org/object/156225"
#>  [3] "http://scrapi.org/object/425550" "http://scrapi.org/object/436839"
#>  [5] "http://scrapi.org/object/60142"  "http://scrapi.org/object/54118" 
#>  [7] "http://scrapi.org/object/421538" "http://scrapi.org/object/421541"
#>  [9] "http://scrapi.org/object/421542" "http://scrapi.org/object/421543"
#> [11] "http://scrapi.org/object/421877" "http://scrapi.org/object/421892"
#> [13] "http://scrapi.org/object/414082" "http://scrapi.org/object/414085"
#> [15] "http://scrapi.org/object/413260" "http://scrapi.org/object/425547"
#> [17] "http://scrapi.org/object/412623" "http://scrapi.org/object/49591" 
#> [19] "http://scrapi.org/object/36624"  "http://scrapi.org/object/54864" 
#> [21] "http://scrapi.org/object/50397"  "http://scrapi.org/object/284630"
#> [23] "http://scrapi.org/object/267055" "http://scrapi.org/object/468197"
#> [25] "http://scrapi.org/object/44848"  "http://scrapi.org/object/284629"
#> [27] "http://scrapi.org/object/255880" "http://scrapi.org/object/427562"
#> [29] "http://scrapi.org/object/452364" "http://scrapi.org/object/449949"
#> [31] "http://scrapi.org/object/487410" "http://scrapi.org/object/467733"
#> [33] "http://scrapi.org/object/544234" "http://scrapi.org/object/38968" 
#> [35] "http://scrapi.org/object/198323" "http://scrapi.org/object/248153"
#> [37] "http://scrapi.org/object/247562" "http://scrapi.org/object/345749"
#> [39] "http://scrapi.org/object/415290" "http://scrapi.org/object/415292"
#> [41] "http://scrapi.org/object/461607" "http://scrapi.org/object/45522" 
#> [43] "http://scrapi.org/object/52475"  "http://scrapi.org/object/64481" 
#> [45] "http://scrapi.org/object/38424"  "http://scrapi.org/object/244558"
#> [47] "http://scrapi.org/object/244297" "http://scrapi.org/object/255617"
#> [49] "http://scrapi.org/object/255391" "http://scrapi.org/object/256949"
#> [51] "http://scrapi.org/object/247479" "http://scrapi.org/object/247869"
#> [53] "http://scrapi.org/object/249227" "http://scrapi.org/object/253556"
#> [55] "http://scrapi.org/object/253640" "http://scrapi.org/object/346681"
#> [57] "http://scrapi.org/object/317748" "http://scrapi.org/object/307734"
#> [59] "http://scrapi.org/object/386624" "http://scrapi.org/object/431176"
#> [61] "http://scrapi.org/object/431179" "http://scrapi.org/object/431181"
#> [63] "http://scrapi.org/object/427560" "http://scrapi.org/object/452852"
#> [65] "http://scrapi.org/object/452809" "http://scrapi.org/object/452948"
#> [67] "http://scrapi.org/object/434964" "http://scrapi.org/object/434966"
#> [69] "http://scrapi.org/object/459206" "http://scrapi.org/object/464248"
#> [71] "http://scrapi.org/object/471283" "http://scrapi.org/object/550263"
#> [73] "http://scrapi.org/object/17566"  "http://scrapi.org/object/63333" 
#> [75] "http://scrapi.org/object/55068"  "http://scrapi.org/object/53937" 
#> [77] "http://scrapi.org/object/193593" "http://scrapi.org/object/207520"
#> [79] "http://scrapi.org/object/203757" "http://scrapi.org/object/255960"
#> [81] "http://scrapi.org/object/251169" "http://scrapi.org/object/412628"
#> [83] "http://scrapi.org/object/415261" "http://scrapi.org/object/421876"
#> [85] "http://scrapi.org/object/413175" "http://scrapi.org/object/417966"
#> [87] "http://scrapi.org/object/423650" "http://scrapi.org/object/271708"
#> [89] "http://scrapi.org/object/427581" "http://scrapi.org/object/427585"
#> 
#> $links
#> $links$first
#> [1] "http://scrapi.org/search/mirror?page=1"
#> 
#> $links$`next`
#> [1] "http://scrapi.org/search/mirror?page=2"
#> 
#> $links$last
#> [1] "http://scrapi.org/search/mirror?page=29"
```


### Meta

* Please report any issues or bugs](https://github.com/ropensci/musemeta/issues).
* License: MIT
* Get citation information for `musemeta` in R doing `citation(package = 'musemeta')`

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
