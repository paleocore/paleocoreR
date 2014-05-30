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
getPCdata(family__exact="Murid", limit=0)
```
see `?getPCdata` for additional information.

### Establishing your PaleoCore credentials

Some of the datasets exposed by the API require authentication using an api key. You need to get your api key and username from a paleocore administrator. Once you have it, you can store this during an R session using the `setPCcredentials()` function.

see `?setPCcredentials` for additional information

### Figuring out which fields you can filter on
The API is flexible, in that you can pass query filters to request particular subsets of the data.  The `getFilters()` function is a convenient way to see which fields are available for filtering, and to see examples of their usage.

