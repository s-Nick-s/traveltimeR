% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/supported_locations.R
\name{supported_locations}
\alias{supported_locations}
\title{Supported Locations}
\usage{
supported_locations(locations)
}
\arguments{
\item{locations}{One or more objects created by \code{\link{make_location}}}
}
\value{
API response parsed as list and as a raw json
}
\description{
Find out what points are supported by the api.
The returned map name for a point can be used to determine what features are supported.
See also the \code{\link{map_info}}.
}
\details{
See \url{https://traveltime.com/docs/api/reference/supported-locations} for details
}
\examples{
\dontrun{
locationsDF <- data.frame(
  id = c('Kaunas', 'London', 'Bangkok', 'Lisbon'),
  lat = c(54.900008, 51.506756, 13.761866, 38.721869),
  lng = c(23.957734, -0.128050, 100.544818, -9.138549)
)
locations <- apply(locationsDF, 1, function(x)
  make_location(id = x['id'], coords = list(lat = as.numeric(x["lat"]),
                                            lng = as.numeric(x["lng"]))))
supported_locations(unlist(locations, recursive = F))
}
}
