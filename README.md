paleocoreR
==========

R package for interacting with the Paleocore API

### To use this package
```
require(devtools)
require(httr)
install_github("paleocore/paleocoreR")
library(paleocoreR)
```

### Getting data from PaleoCore

The main function is `getPCdata()`.  For example, to get all records matching "Muridae" in the family name do the following

```
getPCdata(family__contains="Murid", limit=0)
```
Note that this would also return any records where the family contains the text "Murid". For an exact match on "Muridae", you could try the following.

```
getPCdata(family__exact="Muridae", limit=0)
```
see `?getPCdata` for additional information.

### Establishing your PaleoCore credentials

Some of the datasets exposed by the API require authentication using an api key. If you have a paleocore login, you can get your api_key at [http://paleocore.org/apikey](http://paleocore.org/apikey). Once you have it, you can store this during an R session using the `setPCcredentials()` function. If you need to establish a login account, you can [contact the paleocore administrators](http://paleocore.org/about). 

see `?setPCcredentials` for additional information

### Figuring out which fields you can filter on
The API is flexible, in that you can pass query filters to request particular subsets of the data.  The `getFilters()` function is a convenient way to see which fields are available for filtering, and to see examples of their usage. For example:

```
getFilters("turkana")
```

Yeilds the following results:

```
Loading required package: httr
Loading required package: rjson
The following fields from the turkana project can be passed as query filters using getPCdata().
 [1] "age"                   "age_estimate"          "age_max"               "age_min"               "body_element"          "body_element_code"    
 [7] "body_size"             "class_field"           "collecting_area"       "color"                 "date_entered"          "excavation"           
[13] "family"                "family_code"           "formation"             "genus"                 "genus_code"            "genus_qualifier"      
[19] "identifier"            "level"                 "locality"              "matrix"                "member"                "order"                
[25] "part_description"      "publication_author"    "remarks"               "sex"                   "side"                  "signed"               
[31] "species"               "species_qualifier"     "specimen_number"       "square_number"         "storage_location"      "stratigraphic_code"   
[37] "stratigraphic_unit"    "study_area"            "subfamily"             "surface"               "tribe"                 "tribe_code"           
[43] "weathering"            "year_found"            "year_identified"       "year_published"        "year_published_suffix"
Example usage:
age='somevalue'
age__exact='somevalue'
age__contains='somevalue'
age__startswith='somevalue'
age__endswith='somevalue'
```
