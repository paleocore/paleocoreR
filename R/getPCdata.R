#' function to download data from the paleocore API
#'
#' This function creates a properly formatted URL string and attempts to get the corresponding data from the Paleocore API
#' @param project Name of paleocore project you want data from. Default is "turkana"
#' @param version Which version of the paleocore to use. Default is "v1"
#' @param base_url The base url for the API, with no trailing slash.
#' @param limit Limits the number of records returned.  Default is 20. Use `limit=0` to return all matching records. 
#' @param ... An arbitrary number of filter critera in the following form: genus__contains="Austral"
#' @keywords PaleoCore API paleoanthropology
#' @export
#' @examples
#' getPCdata(tribe__contains="Tragel", limit=0)

getPCdata <- function(project="turkana", version="v1", base_url="http://paleocore.org/API",format="csv", ...) {
  require(httr)
  filter <- paste(
                paste(
                  names(list(...)),
                  list(...),
                  sep="="
                  ),
                collapse="&"
                )
  
  URL_parameters = paste0("?format=csv", "&", filter)
  
  formattedURL <- paste(
                      paste(
                        base_url, 
                        version, 
                        project, 
                        sep="/"
                        ), 
                    URL_parameters, 
                    sep="/"
                    )
  
  attempt <-  GET(url = formattedURL)
    if (attempt$status_code == 401) stop ("You are not authorized to get this data. Have you saved your username and api_key using setPCcredentials()")
    if (attempt$status_code != 200) stop ("There was an error.  Maybe you mispelled something or tried to filter on a field that doesn't exist?")
  return(read.table(text = content(attempt), header=TRUE, sep=","))
}