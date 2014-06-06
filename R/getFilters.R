#' function to get filter field options for a particular API resource
#'
#' This function gets a listing of the fields that are available for filtering when using the getPCdata() function
#' @param project The name of the paleocore project to get information on
#' @param version The version of the API to use, defaults to "v1"
#' @param base_url The base url for the API, with no trailing slash. Defaults to http://paleocore.org/
#' @keywords PaleoCore API paleoanthropology
#' @export
#' @examples
#' getFilters("turkana")

getFilters <- function(project, version="v1", base_url="http://paleocore.org") {
  require(httr)
  requestURL <- paste(paste(base_url, "API", version, project, "schema/", sep="/"),"format=json", sep="?")
  attempt <- GET(requestURL)
  
  if (attempt$status_code == 401) {
    #if unauthorized, try it with username and api_key
    if(any(!exists('username'), !exists('api_key'))) stop("You need to set your username and api_key using setPCcredentials(). You can get an apikey at http://paleocore.org/apikey")
    attempt <-  GET(url = sprintf("%s&username=%s&api_key=%s", requestURL, username, api_key))
  }
  
  if (attempt$status_code == 401) stop (sprintf("User %s with api_key=%s is not authorized to get this data.", username, api_key))
  if (attempt$status_code != 200) stop ("There was an error.  Maybe you requested a project that doesn't exist?")
  
  schema <- content(attempt, as="parsed")
  
  message(sprintf("The following fields from the %s project can be passed as query filters using getPCdata().", project))
  print(names(schema$filtering))
  message("Example usage:")
  examples<-paste0(names(schema$filtering)[1], c("", "__exact","__contains", "__lt","__gt", "__startswith", "__endswith"), "=", "'somevalue'")
  invisible(lapply(examples, FUN=message))#invisible() stops lapply from printing the list being iterated over to the console

}