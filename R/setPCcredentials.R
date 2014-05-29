#' simple function to set your paleocore api_key and username as global variables
#'
#' This is a convenience function to store your paleocore username and api_key
#' @param username Your paleocore username.  Contact an administator to get one
#' @param api_key Your api_key.  Contact an administator to get one
#' @keywords PaleoCore API paleoanthropology
#' @export
#' @examples
#' setPCcredentials("wabarr","asdfk3823kd34983kasdkf013knd83m")

setPCcredentials <- function(username, api_key){
  assign("username", username, envir = .GlobalEnv)
  assign("api_key", api_key, envir = .GlobalEnv)
}