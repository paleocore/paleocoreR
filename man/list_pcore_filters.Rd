% Generated by roxygen2 (4.0.0): do not edit by hand
\name{list_pcore_filters}
\alias{list_pcore_filters}
\title{function to get filter field options for a particular API dataset}
\usage{
list_pcore_filters(dataset, version = "v1",
  base_url = "http://paleocore.org", return_list = FALSE)
}
\arguments{
\item{dataset}{The name of the paleocore dataset to get information on}

\item{version}{The version of the API to use, defaults to "v1"}

\item{base_url}{The base url for the API, with no trailing slash. Defaults to http://paleocore.org/}

\item{return_list}{Boolean. Whether or not to return a list of available filters, or if not, to simply print them to console.  Default is FALSE.}
}
\description{
This function gets a listing of the fields that are available for filtering when using the get_pcore_data() function
}
\examples{
list_pcore_filters("turkana")
}
\keyword{API}
\keyword{PaleoCore}
\keyword{paleoanthropology}

