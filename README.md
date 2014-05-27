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
getPCdata(family__contains="Murid", limit=0, base_url="http://localhost:8000/API")
```

see `?getPCdata` for additional information.
