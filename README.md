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
The package currently only has one  function `getPCdata()`.  For example, to get all records matching "Muridae" in the family name do the following

```
getPCdata(family__contains="Murid", limit=0)
#note: function currently uses http://localhost:8000 as the base URL
```

see `?getPCdata` for additional information.
