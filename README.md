musemeta
=======



[![Build Status](https://api.travis-ci.org/ropensci/musemeta.png)](https://travis-ci.org/ropensci/musemeta)
[![Build status](https://ci.appveyor.com/api/projects/status/ytgtb62gsgf5hddi/branch/master)](https://ci.appveyor.com/project/sckott/musemeta/branch/master)

**R client for museum metadata**

Currently only getting data for [The Metropolitan Museum of Art](http://www.metmuseum.org/)

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
muse_get(559490)$values[1:2]
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

Get many objects


```r
lapply(c(479283, 228901, 436876), muse_get)
#> [[1]]
#> <Museum metadata> Papyri Fragments
#>   Date: 7th century
#>   Geography: Made in Thebes, Byzantine Egypt
#>   Culture: Coptic
#>   Medium: Papyrus and ink
#>   Dimensions: Framed: 11 1/4 x 15 in. (28.5 x 38.1 cm)
#>   Classification: Papyrus
#>   Accession Number: 14.1.616
#> 
#> [[2]]
#> <Museum metadata> Piece
#>   Date: 19th century
#>   Culture: German
#>   Dimensions: 1 1/4 x 6 1/4in. (3.2 x 15.9cm)
#>   Classification: Textiles-Laces
#>   Accession Number: 63.80.18
#> 
#> [[3]]
#> <Museum metadata> Marion Lenbach (1892–1947), the Artist's Daughter
#>   Date: 1900
#>   Medium: Oil on canvas
#>   Dimensions: 58 7/8 x 41 1/2 in. (149.5 x 105.4 cm)
#>   Classification: Paintings
#>   Credit Line: Bequest of Collis P. Huntington, 1900
#>   Accession Number: 25.110.46
```


### Use the scrapi API

This is again, for The Metropolitan Museum of Art only 

Get a random object, limit to a few fields for brevity


```r
scrapi_random(fields=c('medium','whoList'))
#> $medium
#> [1] "Lithograph; second state of two (Delteil)"
#> 
#> $whoList
#> $whoList[[1]]
#> $whoList[[1]]$name
#> [1] "Aubert et Cie$Aubert et Cie"
#> 
#> $whoList[[1]]$count
#> [1] 1249
#> 
#> $whoList[[1]]$orderId
#> [1] 0
#> 
#> $whoList[[1]]$isCurrent
#> [1] FALSE
#> 
#> $whoList[[1]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;who=Aubert+et+Cie%24Aubert+et+Cie"
#> 
#> 
#> $whoList[[2]]
#> $whoList[[2]]$name
#> [1] "Daumier, Honoré$Honoré Daumier"
#> 
#> $whoList[[2]]$count
#> [1] 1078
#> 
#> $whoList[[2]]$orderId
#> [1] 0
#> 
#> $whoList[[2]]$isCurrent
#> [1] FALSE
#> 
#> $whoList[[2]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;who=Daumier%2c+Honor%c3%a9%24Honor%c3%a9+Daumier"
#> 
#> 
#> $whoList[[3]]
#> $whoList[[3]]$name
#> [1] "Bauger et Cie$Bauger et Cie"
#> 
#> $whoList[[3]]$count
#> [1] 377
#> 
#> $whoList[[3]]$orderId
#> [1] 0
#> 
#> $whoList[[3]]$isCurrent
#> [1] FALSE
#> 
#> $whoList[[3]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;who=Bauger+et+Cie%24Bauger+et+Cie"
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
