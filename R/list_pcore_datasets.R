#' function to get available PaleoCore datasets
#'
#' This function gets a listing of the individual data datasets that are accessible using the get_pcore_data() function
#' @param version The version of the API to use, defaults to "v1"
#' @param base_url The base url for the API, with no trailing slash. Defaults to http://paleocore.org
#' @param return_list Boolean. Whether or not to return a list of available datasets, or if not, to simply print them to console.  Default is FALSE.
#' @keywords PaleoCore API paleoanthropology
#' @export
#' @examples
#' list_pcore_datasets("turkana")

list_pcore_datasets <- function(version="v1", base_url="http://paleocore.org", return_list=FALSE) {
  require(httr)
  requestURL <- paste(paste(base_url, "API", version, sep="/"),"format=json", sep="?")
  attempt <- GET(requestURL)
  
  if (attempt$status_code != 200) stop ("There was an error.")
  
  topLevel <- content(attempt, as="parsed") #parse the json
  
  datasets <- invisible(
    lapply(topLevel, FUN=function(dataset){
      #for each of the endpoint datasets exposed, try to get the schema to see if it requires authentication
      requestURL <- paste0(base_url, dataset$schema)
      attempt <- GET(requestURL)
      if(attempt$status_code == 401) return("Requires api_key authentication.")
      if(attempt$status_code == 200) return("Publicly available dataset")
      })
  )
  
  message("The following datasets are available through the PaleoCore API.")
  invisible(
    lapply(names(datasets), FUN= function(datasetName) {
    if(!is.null(datasets[[datasetName]])) print(paste(datasetName, datasets[[datasetName]], sep=": "), quote=FALSE)
    })
  )
  if(return_list) return(datasets)
 }