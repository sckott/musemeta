musemeta
=======



[![Build Status](https://api.travis-ci.org/ropensci/musemeta.png)](https://travis-ci.org/ropensci/musemeta)
[![Build status](https://ci.appveyor.com/api/projects/status/y3tefs9xb6pmql36/branch/master?svg=true)](https://ci.appveyor.com/project/sckott/musemeta/branch/master)

**R client for museum metadata**

Currently `musemeta` can get data from:

* [The Metropolitan Museum of Art](http://www.metmuseum.org/) via 
    * scraping the MET website (see function `muse_get()`)
    * http://scrapi.org/ (see functions `scrapi_()`)
* The Canadian Science & Technology Museum Corporation (CSTMC) (see functions `cstmc_()`)

Other sources of museum metadata will be added...check back later.

## Install

Get `ckanr` first, not on CRAN yet (I'll get `ckanr` up to CRAN before this is on CRAN)


```r
devtools::install_github("sckott/ckanr")
```

Then install musemeta


```r
devtools::install_github("ropensci/musemeta")
```


```r
library("musemeta")
```

## MET data

To get actual metadata for an object, you can use `met()` or `scrapi_get()` functions. The latter gets much more data, and uses a REST API, while the former scrapes the html directly, and can be more fragile with any changes in the html on the site.

### Scraping site directly

Data for a single object


```r
muse_get(559490)
```

Or index to name of object, or values in the description


```r
muse_get(559490)$name
#> Error in muse_get(559490)$name: $ operator is invalid for atomic vectors
```


```r
muse_get(559490)$values[1:2]
#> Error in muse_get(559490)$values: $ operator is invalid for atomic vectors
```

A different object


```r
muse_get(246562)
```

Get many objects


```r
lapply(c(479283, 228901, 436876), muse_get)
#> [[1]]
#> [1] "Decided to change fxn name, see met()"
#> 
#> [[2]]
#> [1] "Decided to change fxn name, see met()"
#> 
#> [[3]]
#> [1] "Decided to change fxn name, see met()"
```

### Using the scrapi API

This is again, for The Metropolitan Museum of Art only 

Get a random object, limit to a few fields for brevity


```r
scrapi_random(fields=c('medium','whoList'))
#> $medium
#> [1] "Engraving"
#> 
#> $whoList
#> $whoList[[1]]
#> $whoList[[1]]$name
#> [1] "Sadeler, Aegidius$Aegidius Sadeler"
#> 
#> $whoList[[1]]$count
#> [1] 141
#> 
#> $whoList[[1]]$orderId
#> [1] 0
#> 
#> $whoList[[1]]$isCurrent
#> [1] FALSE
#> 
#> $whoList[[1]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;who=Sadeler%2c+Aegidius%24Aegidius+Sadeler"
#> 
#> 
#> $whoList[[2]]
#> $whoList[[2]]$name
#> [1] "Brueghel, Jan, the Elder$Jan Brueghel the Elder"
#> 
#> $whoList[[2]]$count
#> [1] 61
#> 
#> $whoList[[2]]$orderId
#> [1] 0
#> 
#> $whoList[[2]]$isCurrent
#> [1] FALSE
#> 
#> $whoList[[2]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;who=Brueghel%2c+Jan%2c+the+Elder%24Jan+Brueghel+the+Elder"
#> 
#> 
#> $whoList[[3]]
#> $whoList[[3]]$name
#> [1] "Sadeler, Marcus$Marcus Sadeler"
#> 
#> $whoList[[3]]$count
#> [1] 29
#> 
#> $whoList[[3]]$orderId
#> [1] 0
#> 
#> $whoList[[3]]$isCurrent
#> [1] FALSE
#> 
#> $whoList[[3]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;who=Sadeler%2c+Marcus%24Marcus+Sadeler"
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
#> $links
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
#> $ids
#>  [1] "207785" "156225" "425550" "436839" "60142"  "54118"  "421538"
#>  [8] "421541" "421542" "421543" "421877" "421892" "414082" "414085"
#> [15] "413260" "425547" "412623" "49591"  "36624"  "54864"  "50397" 
#> [22] "284630" "267055" "468197" "44848"  "284629" "255880" "427562"
#> [29] "452364" "449949" "487410" "467733" "544234" "38968"  "198323"
#> [36] "248153" "247562" "345749" "415290" "415292" "461607" "45522" 
#> [43] "52475"  "64481"  "38424"  "244558" "244297" "255617" "255391"
#> [50] "256949" "247479" "247869" "249227" "253556" "253640" "346681"
#> [57] "317748" "307734" "386624" "431176" "431179" "431181" "427560"
#> [64] "452852" "452809" "452948" "434964" "434966" "459206" "464248"
#> [71] "471283" "550263" "17566"  "63333"  "55068"  "53937"  "193593"
#> [78] "207520" "203757" "255960" "251169" "412628" "415261" "421876"
#> [85] "413175" "417966" "423650" "271708" "427581" "427585"
#> 
#> $paging
#> $paging$first
#> [1] "http://scrapi.org/search/mirror?page=1"
#> 
#> $paging$`next`
#> [1] "http://scrapi.org/search/mirror?page=2"
#> 
#> $paging$last
#> [1] "http://scrapi.org/search/mirror?page=29"
```

Get an object, with a scrapi.org url


```r
out <- scrapi_get("http://scrapi.org/object/427581")
out$primaryArtist
#> $role
#> [1] "Artist"
#> 
#> $name
#> [1] "Daniel Marot the Elder"
#> 
#> $nationality
#> [1] "(French, Paris 1661–1752 The Hague)"
```

or an object id


```r
out <- scrapi_get(427581)
out$primaryArtist
#> $role
#> [1] "Artist"
#> 
#> $name
#> [1] "Daniel Marot the Elder"
#> 
#> $nationality
#> [1] "(French, Paris 1661–1752 The Hague)"
```

## CSTMC data

List changes


```r
cstmc_changes(limit = 1)
#> [[1]]
#> [[1]]$user_id
#> [1] "b50449ea-1dcc-4d52-b620-fc95bf56034b"
#> 
#> [[1]]$timestamp
#> [1] "2014-11-06T18:58:08.001743"
#> 
#> [[1]]$object_id
#> [1] "cc6a523c-cecf-4a95-836b-295a11ce2bce"
#> 
#> [[1]]$revision_id
#> [1] "5d11079e-fc05-4121-9fd5-fe086f5e5f33"
#> 
#> [[1]]$data
#> [[1]]$data$package
#> [[1]]$data$package$maintainer
#> [1] ""
#> 
#> [[1]]$data$package$name
#> [1] "test"
#> 
#> [[1]]$data$package$metadata_modified
#> [1] "2014-11-06T18:55:54.772675"
#> 
#> [[1]]$data$package$author
#> [1] ""
#> 
#> [[1]]$data$package$url
#> [1] ""
#> 
#> [[1]]$data$package$notes
#> [1] ""
#> 
#> [[1]]$data$package$owner_org
#> [1] "fafa260d-e2bf-46cd-9c35-34c1dfa46c57"
#> 
#> [[1]]$data$package$private
#> [1] FALSE
#> 
#> [[1]]$data$package$maintainer_email
#> [1] ""
#> 
#> [[1]]$data$package$author_email
#> [1] ""
#> 
#> [[1]]$data$package$state
#> [1] "deleted"
#> 
#> [[1]]$data$package$version
#> [1] ""
#> 
#> [[1]]$data$package$creator_user_id
#> [1] "b50449ea-1dcc-4d52-b620-fc95bf56034b"
#> 
#> [[1]]$data$package$id
#> [1] "cc6a523c-cecf-4a95-836b-295a11ce2bce"
#> 
#> [[1]]$data$package$title
#> [1] "test"
#> 
#> [[1]]$data$package$revision_id
#> [1] "5d11079e-fc05-4121-9fd5-fe086f5e5f33"
#> 
#> [[1]]$data$package$type
#> [1] "dataset"
#> 
#> [[1]]$data$package$license_id
#> [1] "notspecified"
#> 
#> 
#> 
#> [[1]]$id
#> [1] "59c308c8-68b2-4b92-bc57-129378d31882"
#> 
#> [[1]]$activity_type
#> [1] "deleted package"
```

List datasets


```r
cstmc_datasets(as = "table")
#>  [1] "artifact-data-agriculture"                                  
#>  [2] "artifact-data-aviation"                                     
#>  [3] "artifact-data-bookbinding"                                  
#>  [4] "artifact-data-chemistry"                                    
#>  [5] "artifact-data-communications"                               
#>  [6] "artifact-data-computing-technology"                         
#>  [7] "artifact-data-domestic-technology"                          
#>  [8] "artifact-data-energy-electric"                              
#>  [9] "artifact-data-exploration-and-survey"                       
#> [10] "artifact-data-fisheries"                                    
#> [11] "artifact-data-forestry"                                     
#> [12] "artifact-data-horology"                                     
#> [13] "artifact-data-industrial-technology"                        
#> [14] "artifact-data-lighting-technology"                          
#> [15] "artifact-data-location-canada-agriculture-and-food-museum"  
#> [16] "artifact-data-location-canada-aviation-and-space-museum"    
#> [17] "artifact-data-location-canada-science-and-technology-museum"
#> [18] "artifact-data-marine-transportation"                        
#> [19] "artifact-data-mathematics"                                  
#> [20] "artifact-data-medical-technology"                           
#> [21] "artifact-data-meteorology"                                  
#> [22] "artifact-data-metrology"                                    
#> [23] "artifact-data-mining-and-metallurgy"                        
#> [24] "artifact-data-motorized-ground-transportation"              
#> [25] "artifact-data-non-motorized-ground-transportation"          
#> [26] "artifact-data-on-loan"                                      
#> [27] "artifact-data-photography"                                  
#> [28] "artifact-data-physics"                                      
#> [29] "artifact-data-printing"                                     
#> [30] "artifact-data-railway-transportation"                       
#> [31] "artifact-dataset-fire-fighting"
```

Search for packages


```r
out <- cstmc_package_search(q = '*:*', rows = 2, as='table')
lapply(out$results$resources, function(x) x[,1:3])
#> [[1]]
#>                      resource_group_id cache_last_updated
#> 1 cce39b19-e07c-4c51-941b-242afd3f1c4a                 NA
#> 2 cce39b19-e07c-4c51-941b-242afd3f1c4a                 NA
#> 3 cce39b19-e07c-4c51-941b-242afd3f1c4a                 NA
#> 4 cce39b19-e07c-4c51-941b-242afd3f1c4a                 NA
#>           revision_timestamp
#> 1 2014-10-28T20:14:43.878106
#> 2 2014-11-04T03:04:24.281137
#> 3 2014-11-05T21:46:30.031396
#> 4 2014-11-05T21:48:27.302007
#> 
#> [[2]]
#>                      resource_group_id cache_last_updated
#> 1 02de4923-4b61-4078-9bf7-71cada759cbc                 NA
#> 2 02de4923-4b61-4078-9bf7-71cada759cbc                 NA
#> 3 02de4923-4b61-4078-9bf7-71cada759cbc                 NA
#> 4 02de4923-4b61-4078-9bf7-71cada759cbc                 NA
#>           revision_timestamp
#> 1 2014-10-28T15:25:38.337754
#> 2 2014-11-03T18:08:49.560921
#> 3 2014-11-05T18:44:23.555560
#> 4 2014-11-05T18:45:18.003557
```

## Meta

* Please report any issues or bugs](https://github.com/ropensci/musemeta/issues).
* License: MIT
* Get citation information for `musemeta` in R doing `citation(package = 'musemeta')`

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
