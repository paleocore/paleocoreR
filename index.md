Using the Paleocore R API Interface
========================================================

This demo shows the functionality of the PaleoCore API using the Turkana dataset as an example. 

## Preliminaries
The PaleocoreR package is not yet on CRAN, so you cannot install it using the normal R package installation method.  Instead you can use a function called `install_github()` from the `devtools` package to install the package from the [paleocoreR github page](http://paleocore.github.com/paleocoreR), as shown below.


```r
library(devtools)
install_github("paleocore/paleocoreR")
library(paleocoreR)

# also load the ggplot2 package for graphing.  If this package is not
# installed already you can try install.packages('ggplot2')
library(ggplot2)
```

## First, we can check which datasets are available


```r
list_pcore_datasets()
```

```
## Loading required package: httr
## The following datasets are available through the PaleoCore API.
```

```
## [1] drp_occurrence: Requires api_key authentication.
## [1] drp_taxonomy: Requires api_key authentication.
## [1] turkana: Publicly available dataset
```


## Authentication

Some datasets require authentication (turkana does not).  You can store your PaleoCore username and api_key for authentication using the convenience function `set_pcore_credentials()`.  If you have a paleocore login account, you can obtain your api_key at [http://paleocore.org/apikey](http://paleocore.org/apikey). If you need to create a login account please [contact the paleocore administrators](http://paleocore.org/about). 


```r
set_pcore_credentials(username = "proconsul", api_key = "s93jsp9823jd83mw2md922d93kd73f23kdf23ld7")
```


## See which fields can be filtered on in the Turkana dataset


```r
list_pcore_filters(dataset = "turkana")
```

```
## The following fields from the turkana dataset can be passed as query filters using get_pcore_data().
```

```
##  [1] "age"                   "age_estimate"         
##  [3] "age_max"               "age_min"              
##  [5] "body_element"          "body_element_code"    
##  [7] "body_size"             "class_field"          
##  [9] "collecting_area"       "color"                
## [11] "date_entered"          "excavation"           
## [13] "family"                "family_code"          
## [15] "formation"             "genus"                
## [17] "genus_code"            "genus_qualifier"      
## [19] "identifier"            "level"                
## [21] "locality"              "matrix"               
## [23] "member"                "order"                
## [25] "part_description"      "publication_author"   
## [27] "remarks"               "sex"                  
## [29] "side"                  "signed"               
## [31] "species"               "species_qualifier"    
## [33] "specimen_number"       "square_number"        
## [35] "storage_location"      "stratigraphic_code"   
## [37] "stratigraphic_unit"    "study_area"           
## [39] "subfamily"             "surface"              
## [41] "tribe"                 "tribe_code"           
## [43] "weathering"            "year_found"           
## [45] "year_identified"       "year_published"       
## [47] "year_published_suffix"
```

```
## Example usage:
## age='somevalue'
## age__exact='somevalue'
## age__contains='somevalue'
## age__lt='somevalue'
## age__gt='somevalue'
## age__startswith='somevalue'
## age__endswith='somevalue'
```



## Getting data using `get_pcore_data()`

The workhorse function of the `paleocoreR` package is called `get_pcore_data()`.  Here we will download all of the bovid records from the turkana dataset.  

```r
bovids <- get_pcore_data(dataset = "turkana", family = "Bovidae", limit = 0)
```

```
## Loading required package: jsonlite
## Loading required package: plyr
```

```r
str(bovids)
```

```
## 'data.frame':	3836 obs. of  35 variables:
##  $ body_element         : Factor w/ 75 levels "Horn core","Cranium",..: 1 2 1 3 1 1 3 4 1 1 ...
##  $ body_element_code    : Factor w/ 44 levels "27","28","30",..: 1 2 1 3 1 1 3 4 1 1 ...
##  $ class_field          : Factor w/ 1 level "Mammalia": 1 1 1 1 1 1 1 1 1 1 ...
##  $ collecting_area      : Factor w/ 48 levels " 100.0"," 105.0",..: 1 2 2 2 2 2 NA NA NA NA ...
##  $ family               : Factor w/ 1 level "Bovidae": 1 1 1 1 1 1 1 1 1 1 ...
##  $ family_code          : num  63 63 63 63 63 63 63 63 63 63 ...
##  $ field_number         : Factor w/ 2413 levels "75-497","72-52",..: 1 2 3 3 3 3 4 5 6 7 ...
##  $ formation            : Factor w/ 9 levels "Galana Boi","Kanapoi",..: 1 1 1 1 1 1 1 1 2 2 ...
##  $ genus                : Factor w/ 28 levels "Gazella","Tragelaphus",..: 1 2 1 1 1 1 1 NA 2 2 ...
##  $ id                   : num  1984 3912 3924 3925 3926 ...
##  $ locality             : Factor w/ 55 levels "Koobi Fora Ridge",..: 1 2 2 2 2 2 3 3 NA NA ...
##  $ museum               : Factor w/ 1 level "KNM": 1 1 1 1 1 1 1 1 1 1 ...
##  $ order                : Factor w/ 1 level "Artiodactyla": 1 1 1 1 1 1 1 1 1 1 ...
##  $ part_description     : Factor w/ 567 levels "proximal fragment with frontlet",..: 1 2 1 3 4 1 5 6 7 8 ...
##  $ publication_author   : Factor w/ 3 levels "J. Harris","J. Harris, F. Brown, M. Leakey",..: 1 1 1 1 1 1 2 2 3 3 ...
##  $ resource_uri         : Factor w/ 3836 levels "/API/v1/turkana/1984/",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ side                 : Factor w/ 5 levels "Rt.","Lt.","U",..: 1 NA 2 2 2 2 1 2 1 1 ...
##  $ species              : Factor w/ 50 levels "praethomsoni",..: 1 2 1 1 1 1 NA NA 3 3 ...
##  $ specimen_number      : num  4803 1461 1628 1628 1631 ...
##  $ specimen_prefix      : Factor w/ 4 levels "ER","WT","KP",..: 1 1 1 1 1 1 2 2 3 3 ...
##  $ study_area           : Factor w/ 4 levels "East Turkana",..: 1 1 1 1 1 1 2 2 3 3 ...
##  $ tribe                : Factor w/ 13 levels "Antilopini","Tragelaphini",..: 1 2 1 1 1 1 1 3 2 2 ...
##  $ tribe_code           : Factor w/ 11 levels "3","12","2","1",..: 1 2 1 1 1 1 1 3 2 2 ...
##  $ year_found           : Factor w/ 30 levels "1975","1972",..: 1 2 2 2 2 2 3 3 4 5 ...
##  $ year_published       : num  1991 1991 1991 1991 1991 ...
##  $ year_published_suffix: Factor w/ 1 level "a": 1 1 1 1 1 1 NA NA NA NA ...
##  $ record_number        : Factor w/ 34 levels "1","2","8","11",..: NA NA 1 2 NA NA NA NA NA NA ...
##  $ specimen_suffix      : Factor w/ 154 levels "A","B","I","C",..: NA NA 1 2 NA NA NA NA NA NA ...
##  $ area_modifier        : Factor w/ 64 levels "NK1","B"," 2.0",..: NA NA NA NA NA NA 1 1 NA NA ...
##  $ species_qualifier    : Factor w/ 3 levels "indet.","cf.",..: NA NA NA NA NA NA 1 NA NA NA ...
##  $ genus_qualifier      : Factor w/ 3 levels "indet.","?","cf.": NA NA NA NA NA NA NA 1 NA NA ...
##  $ member               : Factor w/ 32 levels "Lacustrine sequence",..: NA NA NA NA NA NA NA NA 1 2 ...
##  $ stratigraphic_unit   : Factor w/ 63 levels "just below Kanapoi Tuff",..: NA NA NA NA NA NA NA NA 1 2 ...
##  $ level                : Factor w/ 7 levels "Upper","Lower",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ square_number        : Factor w/ 6 levels " 209.0","1971?",..: NA NA NA NA NA NA NA NA NA NA ...
```


## Plot bovids by tribe

```r
qplot(data = bovids, x = tribe)
```

![plot of chunk plotbytribe](figure/plotbytribe.png) 



