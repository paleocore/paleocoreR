#' function to download data from the paleocore API
#'
#' This function creates a properly formatted URL string and attempts to get the corresponding data from the Paleocore API
#' @param dataset Name of paleocore dataset you want data from. Default is "turkana"
#' @param version Which version of the paleocore to use. Default is "v1"
#' @param base_url The base url for the API, with no trailing slash. Defaults to http://paleocore.org
#' @param full_related Whether to include full information from related resources or simply return the URI of related resources.  Default is FALSE.
#' @param limit Limits the number of records returned.  Default is 20. Use `limit=0` to return all matching records. 
#' @param ... An arbitrary number of filter critera in the following form: genus__contains="Austral"
#' @keywords PaleoCore API paleoanthropology
#' @export
#' @examples
#' get_pcore_data(tribe__contains="Tragel", limit=0)

get_pcore_data <- function(dataset="turkana", version="v1", base_url="http://paleocore.org", full_related = FALSE, limit=20, ...) {
  require(httr)
  require(jsonlite)
  require(plyr)
  
  if(full_related) dataset <- paste0(dataset, "_full_related")
  if(limit == 0) message("You are requesting the whole dataset (limit = 0).  This could take a while!")
  #format the filters as GET parameters
  filter <- paste(
                paste(
                  names(list(...)),
                  list(...),
                  sep="="
                  ),
                collapse="&"
                )
  
  URL_parameters = paste0("?format=json", "&", "limit=", limit, "&", filter)
  
  formattedURL <- paste(
                      paste(base_url, "API", version, dataset, sep="/"), 
                      URL_parameters, 
                      sep="/"
                      )
  
  attempt <-  GET(url = formattedURL)
  if (attempt$status_code == 401) {
    #if unauthorized, try it with username and api_key
    if(any(!exists('username'), !exists('api_key'))) stop("You need to set your username and api_key using set_pcore_credentials(). You can get an api_key at http://paleocore.org/apikey.")
    attempt <-  GET(url = sprintf("%s&username=%s&api_key=%s", formattedURL, username, api_key))
  }
  
    if (attempt$status_code == 401) stop (sprintf("User %s with api_key=%s is not authorized to get this data.", username, api_key))
    if (attempt$status_code != 200) stop ("There was an error.  Maybe you mispelled something or tried to filter on a field that doesn't exist?")
  
  theDATA <- content(attempt, as="parsed")
  
  flattened <- lapply(theDATA$objects, FUN = function(object) {
              flat <- as.data.frame(rbind(unlist(object)))
              return(flat)
            })
  result <- rbind.fill(flattened)
  result <- lapply(result, FUN=function(col){
    if (suppressWarnings(all(!is.na(as.numeric(as.character(col)))))) {
      as.numeric(as.character(col))
    } else {
      col
    }
  })
  return(as.data.frame(result))
}
