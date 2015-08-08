musemeta
=======



[![Build Status](https://api.travis-ci.org/ropensci/musemeta.png)](https://travis-ci.org/ropensci/musemeta)
[![Build status](https://ci.appveyor.com/api/projects/status/y3tefs9xb6pmql36/branch/master?svg=true)](https://ci.appveyor.com/project/sckott/musemeta/branch/master)
[![codecov.io](https://codecov.io/github/ropensci/musemeta/coverage.svg?branch=master)](https://codecov.io/github/ropensci/musemeta?branch=master)

**R client for museum metadata**

Currently `musemeta` can get data from:

* [The Metropolitan Museum of Art](http://www.metmuseum.org/) via
    * scraping the MET website (see function `met()`)
    * http://scrapi.org/ (see functions `scrapi_()`)
* The [Canadian Science & Technology Museum Corporation](http://techno-science.ca/en/index.php) (CSTMC) (see functions `cstmc_()`)
* The [National Gallery of Art](http://www.nga.gov/content/ngaweb.html) (NGA) (see function `nga()`)
* The [Getty Museum](http://www.getty.edu/) (see function `getty()`)
* The [Art Institute of Chicago](http://www.artic.edu/) (see function `aic()`)
* The [Asian Art Museum of San Francisco](http://www.asianart.org/) (see function `aam()`)

Other sources of museum metadata will be added...check back later & see [issues](https://github.com/ropensci/musemeta/issues).

## Install

Get `ckanr` first, not on CRAN yet (I'll get `ckanr` up to CRAN before this is on CRAN)


```r
devtools::install_github("ropensci/ckanr")
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
met(559490)
#> <Museum metadata> Siphon nozzle
#>   Period: New Kingdom, Ramesside
#>   Dynasty: Dynasty 19 20
#>   Date: ca. 1295 1070 B.C.
#>   Geography: From Egypt, Memphite Region, Lisht North, Cemetery, MMA excavations, 1913 14
#>   Medium: Bronze
#>   Dimensions: l. 5.4 cm (2 1/8 in)
#>   Credit Line: Rogers Fund and Edward S. Harkness Gift, 1922
#>   Accession Number: 22.1.962
```

Or index to name of object, or values in the description


```r
met(559490)$name
#> [1] "Siphon nozzle"
```


```r
met(559490)$values[1:2]
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
#> [1] "Dynasty 19 20"
```

A different object


```r
met(246562)
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
lapply(c(479283, 228901, 436876), met)
#> [[1]]
#> <Museum metadata> Papyri Fragments
#>   Date: 7th century
#>   Geography: Made in Thebes, Byzantine Egypt
#>   Culture: Coptic
#>   Medium: Papyrus and ink
#>   Dimensions: Framed: 11 1/4 x 15 in. (28.5 x 38.1 cm)
#>   Classification: Papyrus
#>   Credit Line: Rogers Fund, 1914
#>   Accession Number: 14.1.616
...
```

### Using the scrapi API

> Note: the `/random` endpoint is down.

This is again, for The Metropolitan Museum of Art only

Get a specific object


```r
scrapi_info(123, fields = c('title', 'primaryArtistNameOnly', 'medium'))
#> $timelineList
#> $timelineList[[1]]
#> $timelineList[[1]]$name
#> [1] "The United States, 1600-1800 A.D."
#> 
#> $timelineList[[1]]$count
#> [1] 0
#> 
#> $timelineList[[1]]$orderId
#> [1] 0
...
```

Search for objects


```r
scrapi_search(query = 'mirror')
#> $links
#>  [1] "http://scrapi.org/object/207785" "http://scrapi.org/object/50444" 
#>  [3] "http://scrapi.org/object/313256" "http://scrapi.org/object/467733"
#>  [5] "http://scrapi.org/object/267055" "http://scrapi.org/object/49591" 
#>  [7] "http://scrapi.org/object/156225" "http://scrapi.org/object/545128"
#>  [9] "http://scrapi.org/object/452364" "http://scrapi.org/object/460423"
#> [11] "http://scrapi.org/object/244558" "http://scrapi.org/object/452852"
#> [13] "http://scrapi.org/object/248153" "http://scrapi.org/object/54118" 
#> [15] "http://scrapi.org/object/60142"  "http://scrapi.org/object/436839"
#> [17] "http://scrapi.org/object/3977"   "http://scrapi.org/object/255391"
...
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
#> [1] "27778230-2e90-4818-9f00-bbf778c8fa09"
#> 
#> [[1]]$timestamp
#> [1] "2015-03-30T15:06:55.500589"
#> 
#> [[1]]$object_id
#> [1] "f4406699-3e11-4856-be48-b55da98b3c14"
#> 
...
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
...
```

Search for packages


```r
out <- cstmc_package_search(q = '*:*', rows = 2, as = 'table')
lapply(out$results$resources, function(x) x[,1:3])
#> [[1]]
#>                      resource_group_id cache_last_updated
#> 1 4cff3cdf-7174-46f1-b2cf-da84a2478583                 NA
#> 2 4cff3cdf-7174-46f1-b2cf-da84a2478583                 NA
#> 3 4cff3cdf-7174-46f1-b2cf-da84a2478583                 NA
#> 4 4cff3cdf-7174-46f1-b2cf-da84a2478583                 NA
#>           revision_timestamp
#> 1 2015-03-30T15:06:55.217106
#> 2 2014-11-04T02:23:51.866763
#> 3 2014-11-05T19:05:31.328801
#> 4 2014-11-05T19:09:35.883635
#> 
#> [[2]]
#>                      resource_group_id cache_last_updated
#> 1 9d1467e6-4e87-4ebf-bd73-35326fd46491                 NA
#> 2 9d1467e6-4e87-4ebf-bd73-35326fd46491                 NA
#> 3 9d1467e6-4e87-4ebf-bd73-35326fd46491                 NA
#> 4 9d1467e6-4e87-4ebf-bd73-35326fd46491                 NA
#>           revision_timestamp
#> 1 2015-01-09T23:33:13.972143
#> 2 2014-10-31T22:37:58.762911
#> 3 2014-11-05T18:23:00.789562
#> 4 2014-11-05T18:25:16.764967
```

## National Gallery of Art (NGA)

Get metadata for a single object


```r
nga(id = 33267)
#> <NGA metadata> Paradise with Christ in the Lap of Abraham
#>   Artist: German 13th Century
#>   Inscription: on verso late thirteenth-century copy of a letter from Pope Gregory
#>           IX to Elizabeth of Thuringia
#>   Provenance: R. Forrer (Lugt Supp.941a)
#>   Description:
#>      created: c. 1239
#>      medium: tempera and gold leaf on vellum, NGA Miniatures 1975, no. 33
#>      dimensions: overall: 22.4 x 15.7 cm (8 13/16 x 6 3/16 in.)
#>      credit: Rosenwald Collection
...
```

Get metadata for many objects


```r
lapply(c(143679,27773,28487), nga)
#> [[1]]
#> <NGA metadata>  Barrington bore it all with exemplary patience 
#>   Artist: Du Maurier, George
#>   Inscription: by artist, lower right in pen and brown ink: Barrington bore it all
#>           with exemplary patience / P.7 Par VI / Mlle de Mersac /
#>           [Not deciphered]; by later hand, upper right on flap in
#>           graphite: [Not deciphered] (cut off) / Reduce [to?] 6 1/4;
#>           by later hand, lower center verso in pen and blue ink: [Not
#>           deciphered] (effaced)
#>   Provenance: (Fry Gallery, London); Joseph F. McCrindle [1923-2008], New York,
...
```

There is no search functionality yet for this source.

## Getty Museum

Get metadata for a single object


```r
getty(id = 140725)
#> <Getty metadata> A Young Herdsman Leaning on his "Houlette"
#>   Artist: Herman Saftleven the Younger [Dutch, 1609 - 1685]
#>   Provenance
#>      : Gustav Nebehay [Vienna, Austria]
#>      - 1941: Franz W. Koenigs [Haarlem, Netherlands], by inheritance to his heirs.
#>      - 2001: Private Collection (sold, Sotheby's New York, January 23, 2001, lot 20, to Bob Haboldt.)
#>      2001: Bob P. Haboldt, sold to the J. Paul Getty Museum, 2001.
#>   Description:
#>      Artist/Maker(s): Herman Saftleven the Younger [Dutch, 1609 - 1685]
#>      Date: about 1650
...
```

Get metadata for many objects


```r
lapply(c(140725,8197), getty)
#> [[1]]
#> <Getty metadata> A Young Herdsman Leaning on his "Houlette"
#>   Artist: Herman Saftleven the Younger [Dutch, 1609 - 1685]
#>   Provenance
#>      : Gustav Nebehay [Vienna, Austria]
#>      - 1941: Franz W. Koenigs [Haarlem, Netherlands], by inheritance to his heirs.
#>      - 2001: Private Collection (sold, Sotheby's New York, January 23, 2001, lot 20, to Bob Haboldt.)
#>      2001: Bob P. Haboldt, sold to the J. Paul Getty Museum, 2001.
#>   Description:
#>      Artist/Maker(s): Herman Saftleven the Younger [Dutch, 1609 - 1685]
...
```

There is no search functionality yet for this source.

## Art Institute of Chicago

Get metadata for a single object


```r
aic(41033)
#> <AIC metadata> 41033
#>    Artist:
#>       Name: Charles Edmund Brock English
#>       Years: 1870-1938
#>    Link: http://www.artic.edu/aic/collections/artwork/41033
#>    Title: "'The unwelcome hints of Mr. Shepherd, his Agent,' Chapter I"
#>       frontispiece for Jane Austen's Persuasion, 1898
#>    Description: Pen and black ink with brush and watercolor, on ivory wove card 298 x
#>       222 mm Signed lower right, in pen and black ink: "C.E.Brock .
#>       1898"; inscribed, lower center: "'The unwelcome hints of Mr.
...
```

Get metadata for many objects


```r
lapply(c(41033,210804), aic)
#> [[1]]
#> <AIC metadata> 41033
#>    Artist:
#>       Name: Charles Edmund Brock English
#>       Years: 1870-1938
#>    Link: http://www.artic.edu/aic/collections/artwork/41033
#>    Title: "'The unwelcome hints of Mr. Shepherd, his Agent,' Chapter I"
#>       frontispiece for Jane Austen's Persuasion, 1898
#>    Description: Pen and black ink with brush and watercolor, on ivory wove card 298 x
#>       222 mm Signed lower right, in pen and black ink: "C.E.Brock .
...
```

There is no search functionality yet for this source.

## Asian Art Museum of San Francisco

Get metadata for a single object


```r
aam(11462)
#> <AAM metadata> Molded plaque (tsha tsha)
#>   Object id: 1992.96
#>   Object name: Votive plaque
#>   Date: approx. 1992
#>   Artist: 
#>   Medium: Plaster mixed with resin and pigment
#>   Credit line: Gift of Robert Tevis
#>   On display?: yes
#>   Collection: Decorative Arts
#>   Department: Himalayan Art
...
```

Get metadata for many objects


```r
lapply(c(17150,17140,17144), aam)
#> [[1]]
#> <AAM metadata> Boys sumo wrestling
#>   Object id: 2005.100.35
#>   Object name: Woodblock print
#>   Date: approx. 1769
#>   Artist: Suzuki HarunobuJapanese, 1724 - 1770
#>   Medium: Ink and colors on paper
#>   Credit line: Gift of the Grabhorn Ukiyo-e Collection
#>   On display?: no
#>   Collection: Prints And Drawings
...
```

There is no search functionality yet for this source.

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/musemeta/issues).
* License: MIT
* Get citation information for `musemeta` in R doing `citation(package = 'musemeta')`

[![ro_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
