#' simple function to set your paleocore api_key and username as global variables
#'
#' This is a convenience function to store your paleocore username and api_key
#' @param username Your paleocore username.  Contact an administator to get one
#' @param api_key Your api_key.  If you already have a username, you can get an API key at http://paleocore.org/apikey
#' @keywords PaleoCore API paleoanthropology
#' @export
#' @examples
#' set_pcore_credentials("wabarr","asdfk3823kd34983kasdkf013knd83m")

set_pcore_credentials <- function(username, api_key){
  assign("username", username, envir = .GlobalEnv)
  assign("api_key", api_key, envir = .GlobalEnv)
}