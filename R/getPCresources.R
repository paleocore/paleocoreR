#' function to get available PaleoCore resources
#'
#' This function gets a listing of the individual data resources that are accessible using the getPCdata() function
#' @param version The version of the API to use, defaults to "v1"
#' @param base_url The base url for the API, with no trailing slash. Defaults to http://paleocore.org
#' @keywords PaleoCore API paleoanthropology
#' @export
#' @examples
#' getFilters("turkana")

getPCresources <- function(version="v1", base_url="http://paleocore.org") {
  require(httr)
  requestURL <- paste(paste(base_url, "API", version, sep="/"),"format=json", sep="?")
  attempt <- GET(requestURL)
  
  if (attempt$status_code != 200) stop ("There was an error.")
  
  topLevel <- content(attempt, as="parsed") #parse the json
  
  resources <- invisible(
    lapply(topLevel, FUN=function(resource){
      #for each of the endpoint resources exposed, try to get the schema to see if it requires authentication
      requestURL <- paste0(base_url, resource$schema)
      attempt <- GET(requestURL)
      if(attempt$status_code == 401) return("Requires api_key authentication.")
      if(attempt$status_code == 200) return("Publicly available resource")
      })
  )
  
  message("The following resources are available through the PaleoCore API.")
  invisible(
    lapply(names(resources), FUN= function(resourceName) {
    if(!is.null(resources[[resourceName]])) print(paste(resourceName, resources[[resourceName]], sep=": "), quote=FALSE)
    })
  )
 }