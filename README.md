musemeta
=======



[![Build Status](https://api.travis-ci.org/ropensci/musemeta.png)](https://travis-ci.org/ropensci/musemeta)
[![Build status](https://ci.appveyor.com/api/projects/status/y3tefs9xb6pmql36/branch/master?svg=true)](https://ci.appveyor.com/project/sckott/musemeta/branch/master)

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
#> 
#> [[2]]
#> <Museum metadata> Piece
#>   Date: 19th century
#>   Culture: German
#>   Dimensions: 1 1/4 x 6 1/4in. (3.2 x 15.9cm)
#>   Classification: Textiles-Laces
#>   Credit Line: Gift of Helen E. Ionides, 1963
#>   Accession Number: 63.80.18
#> 
#> [[3]]
#> <Museum metadata> Marion Lenbach (1892 1947), the Artist's Daughter
#>   Artist: Franz von Lenbach (German, Schrobenhausen 1836 1904 Munich)
#>   Date: 1900
#>   Medium: Oil on canvas
#>   Dimensions: 58 7/8 x 41 1/2 in. (149.5 x 105.4 cm)
#>   Classification: Paintings
#>   Credit Line: Bequest of Collis P. Huntington, 1900
#>   Accession Number: 25.110.46
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
#> 
#> $timelineList[[1]]$isCurrent
#> [1] FALSE
#> 
#> $timelineList[[1]]$url
#> [1] "http://www.metmuseum.org/toah/ht/?period=09&region=na"
#> 
#> 
#> 
#> $medium
#> [1] "Brass"
#> 
#> $culture
#> [1] "American"
#> 
#> $dimensions
#> [1] "22 5/8 x 10 3/4 x 20 1/2 in. (57.5 x 27.3 x 52.1 cm)"
#> 
#> $accessionNumber
#> [1] "64.291.2"
#> 
#> $geography
#> [1] "Mid-Atlantic, New York, New York, United States"
#> 
#> $dateText
#> [1] "ca. 1800"
#> 
#> $creditLine
#> [1] "Gift of Gertrude Moira Flanagan, 1964"
#> 
#> $classificationList
#> $classificationList[[1]]
#> [1] "Metal"
#> 
#> 
#> $imageNo
#> [1] 0
#> 
#> $primaryArtistNameOnly
#> [1] "Richard Wittingham"
#> 
#> $primaryArtistSuffix
#> [1] "(active before 1795–ca. 1818)"
#> 
#> $isLoanObject
#> [1] FALSE
#> 
#> $hasDescription
#> [1] FALSE
#> 
#> $currentImage
#> $currentImage$CRDID
#> [1] 123
#> 
#> $currentImage$mediaXrefId
#> [1] 13644
#> 
#> $currentImage$mediaView
#> [1] "group photo"
#> 
#> $currentImage$publicAccess
#> [1] TRUE
#> 
#> $currentImage$description
#> [1] "pair\r\n64.291.1\r\n64.291.2"
#> 
#> $currentImage$imageUrl
#> [1] "http://images.metmuseum.org/CRDImages/ad/web-large/181517.jpg"
#> 
#> $currentImage$imageFileName
#> [1] "181517.jpg"
#> 
#> $currentImage$width
#> [1] 1925
#> 
#> $currentImage$height
#> [1] 1626
#> 
#> $currentImage$webWidth
#> [1] 0
#> 
#> $currentImage$webHeight
#> [1] 0
#> 
#> $currentImage$rank
#> [1] 88
#> 
#> $currentImage$primaryDisplay
#> [1] TRUE
#> 
#> $currentImage$isZoomable
#> [1] TRUE
#> 
#> $currentImage$notDownloadable
#> [1] FALSE
#> 
#> $currentImage$thumbnailOnly
#> [1] FALSE
#> 
#> $currentImage$restrictedSize
#> [1] FALSE
#> 
#> $currentImage$inExhibition
#> [1] FALSE
#> 
#> $currentImage$isOasc
#> [1] TRUE
#> 
#> 
#> $noImageAvailable
#> [1] FALSE
#> 
#> $additionalImages
#> $additionalImages$contentLink
#> $additionalImages$contentLink$caption
#> [1] "group photo"
#> 
#> $additionalImages$contentLink$imageUrl
#> [1] "http://images.metmuseum.org/CRDImages/ad/web-additional/181517.jpg"
#> 
#> $additionalImages$contentLink$webImageUrl
#> [1] "http://images.metmuseum.org/CRDImages/ad/web-large/181517.jpg"
#> 
#> $additionalImages$contentLink$linkUrl
#> [1] "/collection/the-collection-online/search/123?xml=1&img=0"
#> 
#> $additionalImages$contentLink$imageNo
#> [1] 0
#> 
#> 
#> 
#> $isThumbnailOnly
#> [1] FALSE
#> 
#> $audioCount
#> [1] 0
#> 
#> $videoCount
#> [1] 0
#> 
#> $numRelatedPublications
#> [1] 0
#> 
#> $whoList
#> $whoList[[1]]
#> $whoList[[1]]$name
#> [1] "Wittingham, Richard$Richard Wittingham"
#> 
#> $whoList[[1]]$count
#> [1] 2
#> 
#> $whoList[[1]]$orderId
#> [1] 0
#> 
#> $whoList[[1]]$isCurrent
#> [1] FALSE
#> 
#> $whoList[[1]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;who=Wittingham%2c+Richard%24Richard+Wittingham"
#> 
#> 
#> 
#> $whatList
#> $whatList[[1]]
#> $whatList[[1]]$name
#> [1] "Metal"
#> 
#> $whatList[[1]]$count
#> [1] 67336
#> 
#> $whatList[[1]]$orderId
#> [1] 0
#> 
#> $whatList[[1]]$isCurrent
#> [1] FALSE
#> 
#> $whatList[[1]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;what=Metal"
#> 
#> 
#> $whatList[[2]]
#> $whatList[[2]]$name
#> [1] "Copper alloy"
#> 
#> $whatList[[2]]$count
#> [1] 18417
#> 
#> $whatList[[2]]$orderId
#> [1] 0
#> 
#> $whatList[[2]]$isCurrent
#> [1] FALSE
#> 
#> $whatList[[2]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;what=Copper+alloy"
#> 
#> 
#> $whatList[[3]]
#> $whatList[[3]]$name
#> [1] "Brass"
#> 
#> $whatList[[3]]$count
#> [1] 4491
#> 
#> $whatList[[3]]$orderId
#> [1] 0
#> 
#> $whatList[[3]]$isCurrent
#> [1] FALSE
#> 
#> $whatList[[3]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;what=Brass"
#> 
#> 
#> $whatList[[4]]
#> $whatList[[4]]$name
#> [1] "Andirons"
#> 
#> $whatList[[4]]$count
#> [1] 145
#> 
#> $whatList[[4]]$orderId
#> [1] 0
#> 
#> $whatList[[4]]$isCurrent
#> [1] FALSE
#> 
#> $whatList[[4]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;what=Andirons"
#> 
#> 
#> 
#> $whereList
#> $whereList[[1]]
#> $whereList[[1]]$name
#> [1] "North and Central America"
#> 
#> $whereList[[1]]$count
#> [1] 94167
#> 
#> $whereList[[1]]$orderId
#> [1] 0
#> 
#> $whereList[[1]]$isCurrent
#> [1] FALSE
#> 
#> $whereList[[1]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;where=North+and+Central+America"
#> 
#> 
#> $whereList[[2]]
#> $whereList[[2]]$name
#> [1] "United States"
#> 
#> $whereList[[2]]$count
#> [1] 90220
#> 
#> $whereList[[2]]$orderId
#> [1] 0
#> 
#> $whereList[[2]]$isCurrent
#> [1] FALSE
#> 
#> $whereList[[2]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;where=United+States"
#> 
#> 
#> $whereList[[3]]
#> $whereList[[3]]$name
#> [1] "New York"
#> 
#> $whereList[[3]]$count
#> [1] 9992
#> 
#> $whereList[[3]]$orderId
#> [1] 0
#> 
#> $whereList[[3]]$isCurrent
#> [1] FALSE
#> 
#> $whereList[[3]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;where=New+York"
#> 
#> 
#> $whereList[[4]]
#> $whereList[[4]]$name
#> [1] "New York City"
#> 
#> $whereList[[4]]$count
#> [1] 2018
#> 
#> $whereList[[4]]$orderId
#> [1] 0
#> 
#> $whereList[[4]]$isCurrent
#> [1] FALSE
#> 
#> $whereList[[4]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;where=New+York+City"
#> 
#> 
#> 
#> $inTheMuseumList
#> $inTheMuseumList[[1]]
#> $inTheMuseumList[[1]]$id
#> [1] "{856AFB9F-B16F-4C10-B5FA-23195AC62D5D}"
#> 
#> $inTheMuseumList[[1]]$name
#> [1] "American Decorative Arts"
#> 
#> $inTheMuseumList[[1]]$count
#> [1] 11812
#> 
#> $inTheMuseumList[[1]]$orderId
#> [1] 0
#> 
#> $inTheMuseumList[[1]]$isCurrent
#> [1] FALSE
#> 
#> $inTheMuseumList[[1]]$url
#> [1] "/collection/the-collection-online/search?ft=*&amp;deptids=1"
#> 
#> 
#> 
#> $isExhibitionArtWork
#> [1] FALSE
#> 
#> $addedToMyMet
#> [1] FALSE
#> 
#> $CRDID
#> [1] 123
#> 
#> $title
#> [1] "Andiron"
#> 
#> $primaryArtist
#> $primaryArtist$role
#> [1] "Maker"
#> 
#> $primaryArtist$name
#> [1] "Richard Wittingham"
#> 
#> $primaryArtist$nationality
#> [1] "(active before 1795–ca. 1818)"
#> 
#> 
#> $galleryLink
#> [1] "/visit/museum-map/galleries/the-american-wing/774"
#> 
#> $gallery
#> [1] 774
#> 
#> $primaryImageUrl
#> [1] "http://images.metmuseum.org/CRDImages/ad/web-large/181517.jpg"
#> 
#> $primaryImageWidth
#> [1] 600
#> 
#> $primaryImageHeight
#> [1] 506
#> 
#> $url
#> [1] "/collection/the-collection-online/search/123"
#> 
#> $xmlUrl
#> [1] "/collection/the-collection-online/search/123?xml=1"
#> 
#> $informationBoxes
#> $informationBoxes$informationBox
#> $informationBoxes$informationBox[[1]]
#> $informationBoxes$informationBox[[1]]$title
#> [1] "Signatures, Inscriptions, and Markings"
#> 
#> $informationBoxes$informationBox[[1]]$content
#> [1] "<![CDATA[<strong>Marking:</strong> marked on the back of hexagonal cylinder: R. WITTINGHAM N. YORK; marked on underside of iron: 180NBill]]>"
#> 
#> 
#> $informationBoxes$informationBox[[2]]
#> $informationBoxes$informationBox[[2]]$title
#> [1] "Provenance"
#> 
#> $informationBoxes$informationBox[[2]]$content
#> [1] "<![CDATA[Miss Gertrude Moira Flanagan, New York, until 1964]]>"
#> 
#> 
#> 
#> 
#> $enlarge
#> [1] FALSE
#> 
#> $searchPageUrl
#> [1] "/collection/the-collection-online/search"
#> 
#> $hasSearchSet
#> [1] FALSE
#> 
#> $searchBackText
#> [1] "Search the collections"
#> 
#> $searchBackUrl
#> [1] "/collection/the-collection-online/search"
#> 
#> $searchItemNo
#> [1] 0
#> 
#> $searchTotalItems
#> [1] 0
#> 
#> $hasRelatedContent
#> [1] TRUE
#> 
#> $relatedArtworkLinkCount
#> [1] 5
#> 
#> $relatedItemLinkCount
#> [1] 13
#> 
#> $relatedToahLinkCount
#> [1] 1
#> 
#> $relatedTabs
#> $relatedTabs$string
#> $relatedTabs$string[[1]]
#> [1] "Artworks (5)"
#> 
#> $relatedTabs$string[[2]]
#> [1] "Exhibitions & Events (13)"
#> 
#> $relatedTabs$string[[3]]
#> [1] "Timeline of Art History (1)"
#> 
#> 
#> 
#> $relatedItemList
#> $relatedItemList[[1]]
#> $relatedItemList[[1]]$id
#> [1] "4f31be4c-309f-4a01-8a69-45d80d786215"
#> 
#> $relatedItemList[[1]]$templateName
#> [1] "Exhibition"
#> 
#> $relatedItemList[[1]]$title
#> [1] "Sargent"
#> 
#> $relatedItemList[[1]]$subTitle
#> [1] "Portraits of Artists and Friends"
#> 
#> $relatedItemList[[1]]$url
#> [1] "/exhibitions/listings/2015/sargent"
#> 
#> $relatedItemList[[1]]$startDate
#> [1] "From June 30, 2015"
#> 
#> $relatedItemList[[1]]$through
#> [1] "October 4, 2015"
#> 
#> $relatedItemList[[1]]$durationHours
#> [1] 0
#> 
#> $relatedItemList[[1]]$durationMinutes
#> [1] 0
#> 
#> 
#> $relatedItemList[[2]]
#> $relatedItemList[[2]]$id
#> [1] "c5a2e623-5908-4bb5-bd2a-bf0782d10399"
#> 
#> $relatedItemList[[2]]$templateName
#> [1] "Exhibition"
#> 
#> $relatedItemList[[2]]$title
#> [1] "Thomas Hart Benton's<br /><em>America Today</em> Mural Rediscovered"
#> 
#> $relatedItemList[[2]]$url
#> [1] "/exhibitions/listings/2014/thomas-hart-benton"
#> 
#> $relatedItemList[[2]]$startDate
#> [1] "From September 30, 2014"
#> 
#> $relatedItemList[[2]]$through
#> [1] "April 19, 2015"
#> 
#> $relatedItemList[[2]]$durationHours
#> [1] 0
#> 
#> $relatedItemList[[2]]$durationMinutes
#> [1] 0
#> 
#> 
#> $relatedItemList[[3]]
#> $relatedItemList[[3]]$id
#> [1] "3c638b07-a6dd-4831-b9b7-d9897cd0de7d"
#> 
#> $relatedItemList[[3]]$templateName
#> [1] "Exhibition"
#> 
#> $relatedItemList[[3]]$title
#> [1] "Navigating the West"
#> 
#> $relatedItemList[[3]]$subTitle
#> [1] "George Caleb Bingham and the River"
#> 
#> $relatedItemList[[3]]$url
#> [1] "/exhibitions/listings/2015/navigating-the-west"
#> 
#> $relatedItemList[[3]]$startDate
#> [1] "From June 17, 2015"
#> 
#> $relatedItemList[[3]]$through
#> [1] "September 20, 2015"
#> 
#> $relatedItemList[[3]]$durationHours
#> [1] 0
#> 
#> $relatedItemList[[3]]$durationMinutes
#> [1] 0
#> 
#> 
#> $relatedItemList[[4]]
#> $relatedItemList[[4]]$templateName
#> [1] "Event"
#> 
#> $relatedItemList[[4]]$title
#> [1] "American Paintings and Sculpture"
#> 
#> $relatedItemList[[4]]$url
#> [1] "/events/programs/tours/american-paintings-and-sculpture?eid=R120_%7bF3242EF2-7D3B-4BC9-BFFC-FDE81F7A0B5B%7d_20150406120000"
#> 
#> $relatedItemList[[4]]$startDate
#> [1] "April 6, 2015"
#> 
#> $relatedItemList[[4]]$durationHours
#> [1] 1
#> 
#> $relatedItemList[[4]]$durationMinutes
#> [1] 0
#> 
#> 
#> $relatedItemList[[5]]
#> $relatedItemList[[5]]$templateName
#> [1] "Event"
#> 
#> $relatedItemList[[5]]$title
#> [1] "American Paintings and Sculpture"
#> 
#> $relatedItemList[[5]]$url
#> [1] "/events/programs/tours/american-paintings-and-sculpture?eid=R121_%7bF3242EF2-7D3B-4BC9-BFFC-FDE81F7A0B5B%7d_20150407120000"
#> 
#> $relatedItemList[[5]]$startDate
#> [1] "April 7, 2015"
#> 
#> $relatedItemList[[5]]$durationHours
#> [1] 1
#> 
#> $relatedItemList[[5]]$durationMinutes
#> [1] 0
#> 
#> 
#> $relatedItemList[[6]]
#> $relatedItemList[[6]]$templateName
#> [1] "Event"
#> 
#> $relatedItemList[[6]]$title
#> [1] "American Paintings and Sculpture"
#> 
#> $relatedItemList[[6]]$url
#> [1] "/events/programs/tours/american-paintings-and-sculpture?eid=R122_%7bF3242EF2-7D3B-4BC9-BFFC-FDE81F7A0B5B%7d_20150408120000"
#> 
#> $relatedItemList[[6]]$startDate
#> [1] "April 8, 2015"
#> 
#> $relatedItemList[[6]]$durationHours
#> [1] 1
#> 
#> $relatedItemList[[6]]$durationMinutes
#> [1] 0
#> 
#> 
#> $relatedItemList[[7]]
#> $relatedItemList[[7]]$templateName
#> [1] "Event"
#> 
#> $relatedItemList[[7]]$title
#> [1] "American Rooms, American Stories: 1680–1914"
#> 
#> $relatedItemList[[7]]$url
#> [1] "/events/programs/tours/american-rooms-american-stories?eid=R061_%7b9E31413E-9AC9-4869-89AE-ADBF80821067%7d_20150408134500"
#> 
#> $relatedItemList[[7]]$startDate
#> [1] "April 8, 2015"
#> 
#> $relatedItemList[[7]]$durationHours
#> [1] 1
#> 
#> $relatedItemList[[7]]$durationMinutes
#> [1] 0
#> 
#> 
#> $relatedItemList[[8]]
#> $relatedItemList[[8]]$templateName
#> [1] "Event"
#> 
#> $relatedItemList[[8]]$title
#> [1] "Conversation with a Curator—Coffee and Tea Service Attributed to Christian Wiltberger, The American Wing"
#> 
#> $relatedItemList[[8]]$url
#> [1] "/events/programs/talks/conversations-with-curators-and-conservators/coffee-and-tea-service?eid=A001_%7b275774EC-EEA0-4C27-9E57-4BC7582723BF%7d_20150203152442"
#> 
#> $relatedItemList[[8]]$startDate
#> [1] "April 9, 2015"
#> 
#> $relatedItemList[[8]]$durationHours
#> [1] 0
#> 
#> $relatedItemList[[8]]$durationMinutes
#> [1] 30
#> 
#> 
#> $relatedItemList[[9]]
#> $relatedItemList[[9]]$templateName
#> [1] "Event"
#> 
#> $relatedItemList[[9]]$title
#> [1] "American Paintings and Sculpture"
#> 
#> $relatedItemList[[9]]$url
#> [1] "/events/programs/tours/american-paintings-and-sculpture?eid=R123_%7bF3242EF2-7D3B-4BC9-BFFC-FDE81F7A0B5B%7d_20150409120000"
#> 
#> $relatedItemList[[9]]$startDate
#> [1] "April 9, 2015"
#> 
#> $relatedItemList[[9]]$durationHours
#> [1] 1
#> 
#> $relatedItemList[[9]]$durationMinutes
#> [1] 0
#> 
#> 
#> $relatedItemList[[10]]
#> $relatedItemList[[10]]$templateName
#> [1] "Event"
#> 
#> $relatedItemList[[10]]$title
#> [1] "American Rooms, American Stories: 1680–1914"
#> 
#> $relatedItemList[[10]]$url
#> [1] "/events/programs/tours/american-rooms-american-stories?eid=R062_%7b9E31413E-9AC9-4869-89AE-ADBF80821067%7d_20150409134500"
#> 
#> $relatedItemList[[10]]$startDate
#> [1] "April 9, 2015"
#> 
#> $relatedItemList[[10]]$durationHours
#> [1] 1
#> 
#> $relatedItemList[[10]]$durationMinutes
#> [1] 0
#> 
#> 
#> $relatedItemList[[11]]
#> $relatedItemList[[11]]$templateName
#> [1] "Event"
#> 
#> $relatedItemList[[11]]$title
#> [1] "Power and Personality in American Portraits"
#> 
#> $relatedItemList[[11]]$url
#> [1] "/events/programs/talks/gallery-talks/power-and-personality-friday?eid=A001_%7b74D6D92B-E265-4E1A-BA3C-522FEE1F50E1%7d_20150209173441"
#> 
#> $relatedItemList[[11]]$startDate
#> [1] "April 10, 2015"
#> 
#> $relatedItemList[[11]]$durationHours
#> [1] 1
#> 
#> $relatedItemList[[11]]$durationMinutes
#> [1] 0
#> 
#> 
#> $relatedItemList[[12]]
#> $relatedItemList[[12]]$templateName
#> [1] "Event"
#> 
#> $relatedItemList[[12]]$title
#> [1] "American Art"
#> 
#> $relatedItemList[[12]]$url
#> [1] "/events/programs/tours/american-art-weekend?eid=A031_%7b501B6EDB-D4CC-4402-98B8-688E06337497%7d_20141208163017"
#> 
#> $relatedItemList[[12]]$startDate
#> [1] "April 11, 2015"
#> 
#> $relatedItemList[[12]]$durationHours
#> [1] 1
#> 
#> $relatedItemList[[12]]$durationMinutes
#> [1] 0
#> 
#> 
#> $relatedItemList[[13]]
#> $relatedItemList[[13]]$templateName
#> [1] "Event"
#> 
#> $relatedItemList[[13]]$title
#> [1] "American Paintings and Sculpture"
#> 
#> $relatedItemList[[13]]$url
#> [1] "/events/programs/tours/american-paintings-and-sculpture?eid=R124_%7bF3242EF2-7D3B-4BC9-BFFC-FDE81F7A0B5B%7d_20150413120000"
#> 
#> $relatedItemList[[13]]$startDate
#> [1] "April 13, 2015"
#> 
#> $relatedItemList[[13]]$durationHours
#> [1] 1
#> 
#> $relatedItemList[[13]]$durationMinutes
#> [1] 0
#> 
#> 
#> 
#> $relatedToahLinkList
#> $relatedToahLinkList[[1]]
#> $relatedToahLinkList[[1]]$id
#> [1] "Timeline"
#> 
#> $relatedToahLinkList[[1]]$title
#> [1] "The United States, 1600&#8211;1800 A.D."
#> 
#> $relatedToahLinkList[[1]]$url
#> [1] "http://www.metmuseum.org/toah/ht/?period=09&region=na"
#> 
#> 
#> 
#> $relatedArtworkList
#> $relatedArtworkList[[1]]
#> $relatedArtworkList[[1]]$title
#> [1] "Andiron"
#> 
#> $relatedArtworkList[[1]]$teaserText
#> [1] "<a class=\"name\" href=\"/collection/the-collection-online/search/122\">Andiron</a><span class=\"author\">Richard Wittingham</span>"
#> 
#> $relatedArtworkList[[1]]$artist
#> [1] "Richard Wittingham"
#> 
#> $relatedArtworkList[[1]]$location
#> [1] "(active before 1795–ca. 1818)"
#> 
#> $relatedArtworkList[[1]]$date
#> [1] "ca. 1800"
#> 
#> $relatedArtworkList[[1]]$medium
#> [1] "Brass"
#> 
#> $relatedArtworkList[[1]]$accession
#> [1] "64.291.1"
#> 
#> $relatedArtworkList[[1]]$imageUrl
#> [1] "http://images.metmuseum.org/CRDImages/ad/web-gallery/181517.jpg"
#> 
#> $relatedArtworkList[[1]]$imageWidth
#> [1] 0
#> 
#> $relatedArtworkList[[1]]$imageHeight
#> [1] 0
#> 
#> $relatedArtworkList[[1]]$galleryLink
#> [1] "/visit/museum-map/galleries/the-american-wing/774"
#> 
#> $relatedArtworkList[[1]]$gallery
#> [1] 774
#> 
#> $relatedArtworkList[[1]]$artworkUrl
#> [1] "/collection/the-collection-online/search/122"
#> 
#> 
#> $relatedArtworkList[[2]]
#> $relatedArtworkList[[2]]$title
#> [1] "Andiron"
#> 
#> $relatedArtworkList[[2]]$teaserText
#> [1] "<a class=\"name\" href=\"/collection/the-collection-online/search/42\">Andiron</a>"
#> 
#> $relatedArtworkList[[2]]$date
#> [1] "1795–1810"
#> 
#> $relatedArtworkList[[2]]$medium
#> [1] "Brass, iron"
#> 
#> $relatedArtworkList[[2]]$accession
#> [1] "60.58.1"
#> 
#> $relatedArtworkList[[2]]$imageUrl
#> [1] "http://images.metmuseum.org/CRDImages/ad/web-gallery/172134.jpg"
#> 
#> $relatedArtworkList[[2]]$imageWidth
#> [1] 0
#> 
#> $relatedArtworkList[[2]]$imageHeight
#> [1] 0
#> 
#> $relatedArtworkList[[2]]$galleryLink
#> [1] "/visit/museum-map/galleries/the-american-wing/724"
#> 
#> $relatedArtworkList[[2]]$gallery
#> [1] 724
#> 
#> $relatedArtworkList[[2]]$artworkUrl
#> [1] "/collection/the-collection-online/search/42"
#> 
#> 
#> $relatedArtworkList[[3]]
#> $relatedArtworkList[[3]]$title
#> [1] "Andiron"
#> 
#> $relatedArtworkList[[3]]$teaserText
#> [1] "<a class=\"name\" href=\"/collection/the-collection-online/search/43\">Andiron</a>"
#> 
#> $relatedArtworkList[[3]]$date
#> [1] "1795–1810"
#> 
#> $relatedArtworkList[[3]]$medium
#> [1] "Brass, iron"
#> 
#> $relatedArtworkList[[3]]$accession
#> [1] "60.58.2"
#> 
#> $relatedArtworkList[[3]]$imageUrl
#> [1] "http://images.metmuseum.org/CRDImages/ad/web-gallery/172134.jpg"
#> 
#> $relatedArtworkList[[3]]$imageWidth
#> [1] 0
#> 
#> $relatedArtworkList[[3]]$imageHeight
#> [1] 0
#> 
#> $relatedArtworkList[[3]]$galleryLink
#> [1] "/visit/museum-map/galleries/the-american-wing/724"
#> 
#> $relatedArtworkList[[3]]$gallery
#> [1] 724
#> 
#> $relatedArtworkList[[3]]$artworkUrl
#> [1] "/collection/the-collection-online/search/43"
#> 
#> 
#> $relatedArtworkList[[4]]
#> $relatedArtworkList[[4]]$title
#> [1] "Andiron"
#> 
#> $relatedArtworkList[[4]]$teaserText
#> [1] "<a class=\"name\" href=\"/collection/the-collection-online/search/64\">Andiron</a>"
#> 
#> $relatedArtworkList[[4]]$date
#> [1] "1795–1810"
#> 
#> $relatedArtworkList[[4]]$medium
#> [1] "Brass, iron"
#> 
#> $relatedArtworkList[[4]]$accession
#> [1] "23.80.14"
#> 
#> $relatedArtworkList[[4]]$imageUrl
#> [1] "http://images.metmuseum.org/CRDImages/ad/web-gallery/52601.jpg"
#> 
#> $relatedArtworkList[[4]]$imageWidth
#> [1] 0
#> 
#> $relatedArtworkList[[4]]$imageHeight
#> [1] 0
#> 
#> $relatedArtworkList[[4]]$galleryLink
#> [1] "/visit/museum-map/galleries/the-american-wing/728"
#> 
#> $relatedArtworkList[[4]]$gallery
#> [1] 728
#> 
#> $relatedArtworkList[[4]]$artworkUrl
#> [1] "/collection/the-collection-online/search/64"
#> 
#> 
#> $relatedArtworkList[[5]]
#> $relatedArtworkList[[5]]$title
#> [1] "Andiron"
#> 
#> $relatedArtworkList[[5]]$teaserText
#> [1] "<a class=\"name\" href=\"/collection/the-collection-online/search/65\">Andiron</a>"
#> 
#> $relatedArtworkList[[5]]$date
#> [1] "1795–1810"
#> 
#> $relatedArtworkList[[5]]$medium
#> [1] "Brass, iron"
#> 
#> $relatedArtworkList[[5]]$accession
#> [1] "23.80.15"
#> 
#> $relatedArtworkList[[5]]$imageUrl
#> [1] "http://images.metmuseum.org/CRDImages/ad/web-gallery/52601.jpg"
#> 
#> $relatedArtworkList[[5]]$imageWidth
#> [1] 0
#> 
#> $relatedArtworkList[[5]]$imageHeight
#> [1] 0
#> 
#> $relatedArtworkList[[5]]$galleryLink
#> [1] "/visit/museum-map/galleries/the-american-wing/728"
#> 
#> $relatedArtworkList[[5]]$gallery
#> [1] 728
#> 
#> $relatedArtworkList[[5]]$artworkUrl
#> [1] "/collection/the-collection-online/search/65"
#> 
#> 
#> 
#> $showEmbeddedVideo
#> [1] FALSE
#> 
#> $showEmbeddedAudio
#> [1] FALSE
#> 
#> $hasMedia
#> [1] FALSE
```

Search for objects


```r
scrapi_search(query = 'mirror')
#> $links
#>  [1] "http://scrapi.org/object/207785" "http://scrapi.org/object/156225"
#>  [3] "http://scrapi.org/object/452364" "http://scrapi.org/object/436839"
#>  [5] "http://scrapi.org/object/452852" "http://scrapi.org/object/54118" 
#>  [7] "http://scrapi.org/object/60142"  "http://scrapi.org/object/36624" 
#>  [9] "http://scrapi.org/object/54864"  "http://scrapi.org/object/49591" 
#> [11] "http://scrapi.org/object/50397"  "http://scrapi.org/object/267055"
#> [13] "http://scrapi.org/object/313256" "http://scrapi.org/object/468197"
#> [15] "http://scrapi.org/object/425550" "http://scrapi.org/object/284630"
#> [17] "http://scrapi.org/object/44848"  "http://scrapi.org/object/255880"
#> [19] "http://scrapi.org/object/545128" "http://scrapi.org/object/467733"
#> [21] "http://scrapi.org/object/544234" "http://scrapi.org/object/548961"
#> [23] "http://scrapi.org/object/427562" "http://scrapi.org/object/449949"
#> [25] "http://scrapi.org/object/284629" "http://scrapi.org/object/487410"
#> [27] "http://scrapi.org/object/38968"  "http://scrapi.org/object/247562"
#> [29] "http://scrapi.org/object/248153" "http://scrapi.org/object/198323"
#> [31] "http://scrapi.org/object/345749" "http://scrapi.org/object/461607"
#> [33] "http://scrapi.org/object/414085" "http://scrapi.org/object/413260"
#> [35] "http://scrapi.org/object/414082" "http://scrapi.org/object/425547"
#> [37] "http://scrapi.org/object/421541" "http://scrapi.org/object/421542"
#> [39] "http://scrapi.org/object/421543" "http://scrapi.org/object/421538"
#> [41] "http://scrapi.org/object/421892" "http://scrapi.org/object/421877"
#> [43] "http://scrapi.org/object/415290" "http://scrapi.org/object/415292"
#> [45] "http://scrapi.org/object/38424"  "http://scrapi.org/object/45522" 
#> [47] "http://scrapi.org/object/52475"  "http://scrapi.org/object/247479"
#> [49] "http://scrapi.org/object/249227" "http://scrapi.org/object/253556"
#> [51] "http://scrapi.org/object/253640" "http://scrapi.org/object/256949"
#> [53] "http://scrapi.org/object/247869" "http://scrapi.org/object/255391"
#> [55] "http://scrapi.org/object/255617" "http://scrapi.org/object/244297"
#> [57] "http://scrapi.org/object/244558" "http://scrapi.org/object/307734"
#> [59] "http://scrapi.org/object/317748" "http://scrapi.org/object/346681"
#> [61] "http://scrapi.org/object/386624" "http://scrapi.org/object/464248"
#> [63] "http://scrapi.org/object/471283" "http://scrapi.org/object/550263"
#> [65] "http://scrapi.org/object/412623" "http://scrapi.org/object/434964"
#> [67] "http://scrapi.org/object/434966" "http://scrapi.org/object/450492"
#> [69] "http://scrapi.org/object/427560" "http://scrapi.org/object/452809"
#> [71] "http://scrapi.org/object/452948" "http://scrapi.org/object/447774"
#> [73] "http://scrapi.org/object/459206" "http://scrapi.org/object/431176"
#> [75] "http://scrapi.org/object/431181" "http://scrapi.org/object/431179"
#> [77] "http://scrapi.org/object/626692" "http://scrapi.org/object/17566" 
#> [79] "http://scrapi.org/object/63333"  "http://scrapi.org/object/55068" 
#> [81] "http://scrapi.org/object/53937"  "http://scrapi.org/object/251169"
#> [83] "http://scrapi.org/object/255960" "http://scrapi.org/object/207520"
#> [85] "http://scrapi.org/object/193593" "http://scrapi.org/object/203757"
#> [87] "http://scrapi.org/object/423650" "http://scrapi.org/object/427581"
#> [89] "http://scrapi.org/object/427585" "http://scrapi.org/object/456956"
#> 
#> $ids
#>  [1] "207785" "156225" "452364" "436839" "452852" "54118"  "60142" 
#>  [8] "36624"  "54864"  "49591"  "50397"  "267055" "313256" "468197"
#> [15] "425550" "284630" "44848"  "255880" "545128" "467733" "544234"
#> [22] "548961" "427562" "449949" "284629" "487410" "38968"  "247562"
#> [29] "248153" "198323" "345749" "461607" "414085" "413260" "414082"
#> [36] "425547" "421541" "421542" "421543" "421538" "421892" "421877"
#> [43] "415290" "415292" "38424"  "45522"  "52475"  "247479" "249227"
#> [50] "253556" "253640" "256949" "247869" "255391" "255617" "244297"
#> [57] "244558" "307734" "317748" "346681" "386624" "464248" "471283"
#> [64] "550263" "412623" "434964" "434966" "450492" "427560" "452809"
#> [71] "452948" "447774" "459206" "431176" "431181" "431179" "626692"
#> [78] "17566"  "63333"  "55068"  "53937"  "251169" "255960" "207520"
#> [85] "193593" "203757" "423650" "427581" "427585" "456956"
#> 
#> $paging
#> $paging$first
#> [1] "http://scrapi.org/search/mirror?page=1"
#> 
#> $paging$`next`
#> [1] "http://scrapi.org/search/mirror?page=2"
#> 
#> $paging$last
#> [1] "http://scrapi.org/search/mirror?page=30"
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
#> [[1]]$revision_id
#> [1] "12381b05-9e46-4d26-a356-7baed60e8471"
#> 
#> [[1]]$data
#> [[1]]$data$package
#> [[1]]$data$package$maintainer
#> [1] ""
#> 
#> [[1]]$data$package$name
#> [1] "artifact-data-horology"
#> 
#> [[1]]$data$package$metadata_modified
#> [1] "2015-03-30T15:06:55.218176"
#> 
#> [[1]]$data$package$author
#> [1] ""
#> 
#> [[1]]$data$package$url
#> [1] ""
#> 
#> [[1]]$data$package$notes
#> [1] "This dataset includes artifacts in the collection of the Canada Science and Technology Museums Corporation related to horology."
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
#> [1] "active"
#> 
#> [[1]]$data$package$version
#> [1] ""
#> 
#> [[1]]$data$package$creator_user_id
#> [1] "27778230-2e90-4818-9f00-bbf778c8fa09"
#> 
#> [[1]]$data$package$id
#> [1] "f4406699-3e11-4856-be48-b55da98b3c14"
#> 
#> [[1]]$data$package$title
#> [1] "Artifact Data - Horology"
#> 
#> [[1]]$data$package$revision_id
#> [1] "f8fec13c-edc1-4247-9863-abb0d9fd7046"
#> 
#> [[1]]$data$package$type
#> [1] "dataset"
#> 
#> [[1]]$data$package$license_id
#> [1] "ca-ogl-lgo"
#> 
#> 
#> 
#> [[1]]$id
#> [1] "0721e046-abe8-43eb-91e2-412a5e2570cd"
#> 
#> [[1]]$activity_type
#> [1] "changed package"
```

List datasets


```r
cstmc_datasets(as = "table")
#> Error: 'datasets' is not an exported object from 'namespace:ckanr'
```

Search for packages


```r
out <- cstmc_package_search(q = '*:*', rows = 2, as='table')
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
nga(id=33267)
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
#>      accession: 1946.21.11
#>   Exhibition history:
#>      2007: Fabulous Journeys and Faraway Places: Travels on Paper, 1450 - 1700,
#>           National Gallery of Art, Washington, D.C., 2007
#>      2009: Heaven on Earth: Manuscript Illuminations from the National Gallery
#>           of Art, NGA, 2009.
#>   Bibliography:
#>      1975: National Gallery of Art. Medieval and Renaissance Miniatures from the
#>           National Gallery of Art. Washington, 1975.
#>      1982: Fine 1982, 45.
#>      1984: Walker, John. National Gallery of Art, Washington. Rev. ed. New York,
#>           1984: 658, no. 1033, color repro.
#>      1990: Clayton, Virginia Tuttle. Gardens on Paper: Prints and Drawings,
#>           1200-1900. Exh. cat. National Gallery of Art, Washington,
#>           1990: 1.
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
#>           1968; Joseph F. McCrindle Foundation, 2008; gift to NGA,
#>           2009.
#>   Description:
#>      created: 1878/1879
#>      medium: pen and brown ink with graphite on heavy wove paper
#>      dimensions: , sheet: 22 x 30.2 cm (8 11/16 x 11 7/8 in.)  image (6.4 cm of sheet width is folded under): 22 x 23.8 cm (8 11/16 x 9 3/8 in.)
#>      credit: Joseph F. McCrindle Collection
#>      accession: 2009.70.110
#>   Exhibition history:
#>   Bibliography:
#>      2012: Grasselli, Margaret M., and Arthur K. Wheelock, Jr., eds. The
#>           McCrindle Gift: A Distinguished Collection of Drawings and
#>           Watercolors. Exh. cat. National Gallery of Art. Washington,
#>           2012: 169 (color).
#> 
#> [[2]]
#> <NGA metadata>  Bell Hop  Marionette
#>   Artist: Cero, Emile
#>   Inscription: lower right in black ink: EMILE CERO
#>   Provenance: NA
#>   Description:
#>      created: c. 1938
#>      medium: watercolor, graphite, and pen and ink on paper
#>      dimensions: overall: 35.5 x 28 cm (14 x 11 in.)  Original IAD Object: 42" high
#>      credit: Index of American Design
#>      accession: 1943.8.15682
#>   Exhibition history:
#>   Bibliography:
#> 
#> [[3]]
#> <NGA metadata>  Bell in Hand  Tavern Sign
#>   Artist: American 20th Century
#>   Inscription: 
#>   Provenance: NA
#>   Description:
#>      created: 1935/1942
#>      medium: watercolor and graphite on paper
#>      dimensions: overall: 37.7 x 26.5 cm (14 13/16 x 10 7/16 in.)
#>      credit: Index of American Design
#>      accession: 1943.8.16396
#>   Exhibition history:
#>   Bibliography:
#>      1950: Christensen, Erwin O., The Index of American Design, New York: 1950,
#>           p. 67, no. 127.
#>      1970: Hornung, Clarence P., Treasury of American Design. New York, 1970:
#>           83, pl. 265.
```

There is no search functionality yet for this source.

## Getty Museum

Get metadata for a single object


```r
getty(id=140725)
#> Error in readHTMLTable(ob): error in evaluating the argument 'doc' in selecting a method for function 'readHTMLTable': Error in xpathSApply(tmp, "//table[@summary=\"search results data table\"]")[[1]] : 
#>   subscript out of bounds
```

Get metadata for many objects


```r
lapply(c(140725,8197), getty)
#> Error in readHTMLTable(ob): error in evaluating the argument 'doc' in selecting a method for function 'readHTMLTable': Error in xpathSApply(tmp, "//table[@summary=\"search results data table\"]")[[1]] : 
#>   subscript out of bounds
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
#>       Shepherd, his agent' / Chapter I"; further ink and graphite
#>       inscriptions in marginsGift of James Deering, 1927.1623
#>    Description-2: Prints and Drawings Not on Display
#>    Artwork body: 
#>    Exhibition history:
#>    Publication history:
#>      - : Jane Austen, edited by Gerald Brimley Johnson, Persuasion, in Jane
#>           Austen's Novels, Volume X, (London: Dent, 1898), p. 8
#>           (ill).
#>    Ownership history:
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
#>       1898"; inscribed, lower center: "'The unwelcome hints of Mr.
#>       Shepherd, his agent' / Chapter I"; further ink and graphite
#>       inscriptions in marginsGift of James Deering, 1927.1623
#>    Description-2: Prints and Drawings Not on Display
#>    Artwork body: 
#>    Exhibition history:
#>    Publication history:
#>      - : Jane Austen, edited by Gerald Brimley Johnson, Persuasion, in Jane
#>           Austen's Novels, Volume X, (London: Dent, 1898), p. 8
#>           (ill).
#>    Ownership history: 
#> 
#> [[2]]
#> <AIC metadata> 210804
#>    Artist:
#>       Name: William H. Bell , American
#>       Years: 1830 1910
#>    Link: http://www.artic.edu/aic/collections/artwork/210804
#>    Title: The "Vermillion Cliff," a typical plateau edge, as seen from Jacobs
#>       Pool, Arizona. From its top a plateau stretches to the right,
#>       and from its base another to the left. Their difference of
#>       level is 1.500 feet, and the step is too steep for scaling.,
#>       1872
#>    Description: Albumen print, stereo, No. 15 from the series "Geographical
#>       Explorations and Surveys West of the 100th Meridian" 9.3 x 7.5
#>       cm (each image); 10 x 17.7 cm (card)Photography Gallery Fund,
#>       1959.616.13
#>    Description-2: Photography Not on Display
#>    Artwork body: 
#>    Exhibition history:
#>    Publication history:
#>    Ownership history:
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
#>   Dimensions: 
#>   Label: Molded plaques (tsha tshas) are small sacred images, flat or
#>           three-dimensional, shaped out of clay in metal molds. The
#>           images are usually unbaked, and sometimes seeds, paper, or
#>           human ashes were mixed with the clay. Making tsha tshas is
#>           a meritorious act, and monasteries give them away to
#>           pilgrims. Some Tibetans carry tsha tshas inside the amulet
#>           boxes they wear or stuff them into larger images as part of
#>           the consecration of those images. In Bhutan tsha tshas are
#>           found in mani walls (a wall of stones carved with prayers)
#>           or piled up in caves.The practice of making such plaques
#>           began in India, and from there it spread to other countries
#>           in Asia with the introduction of Buddhism. Authentic tsha
#>           tshas are cast from clay. Modern examples , such as those
#>           made for the tourist trade in Tibet, are made of plaster
#>           and cast from ancient (1100-1200) molds and hand colored to
#>           give them the appearance of age.
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
#>   Department: Japanese Art
#>   Dimensions: H. 12 5/8 in x W. 5 3/4 in, H. 32.1 cm x W. 14.6 cm
#>   Label: 40 Suzuki Harunobu, 1725? 1770 Boys sumo wrestling (Sum asobi) c.
#>           1769 Woodblock print (nishiki-e) Hosoban
#> 
#> [[2]]
#> <AAM metadata> Autumn Moon of Matsukaze
#>   Object id: 2005.100.25
#>   Object name: Woodblock print
#>   Date: 1768-1769
#>   Artist: Suzuki HarunobuJapanese, 1724 - 1770
#>   Medium: Ink and colors on paper
#>   Credit line: Gift of the Grabhorn Ukiyo-e Collection
#>   On display?: no
#>   Collection: Prints And Drawings
#>   Department: Japanese Art
#>   Dimensions: H. 12 1/2 in x W. 5 3/4 in, H. 31.7 cm x W. 14.6 cm
#>   Label: 30 Suzuki Harunobu, 1725? 1770 Autumn Moon of Matsukaze (Matsukaze no
#>           sh getsu) From Fashionable Eight Views of Noh Chants (F ry
#>           utai hakkei) 1768 1769 Woodblock print (nishiki-e) Hosoban
#> 
#> [[3]]
#> <AAM metadata> Hunting for fireflies
#>   Object id: 2005.100.29
#>   Object name: Woodblock print
#>   Date: 1767-1768
#>   Artist: Suzuki HarunobuJapanese, 1724 - 1770
#>   Medium: Ink and colors on paper
#>   Credit line: Gift of the Grabhorn Ukiyo-e Collection
#>   On display?: no
#>   Collection: Prints And Drawings
#>   Department: Japanese Art
#>   Dimensions: H. 10 1/2 in x W. 8 in, H. 26.7 cm x W. 20.3 cm
#>   Label: 34 Suzuki Harunobu, 1725? 1770 Hunting for fireflies 1767 1768
#>           Woodblock print (nishiki-e) Ch ban
```

There is no search functionality yet for this source.

## Meta

* Please report any issues or bugs](https://github.com/ropensci/musemeta/issues).
* License: MIT
* Get citation information for `musemeta` in R doing `citation(package = 'musemeta')`

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
