\name{gts.hierarchy}
\alias{gts.hierarchy}
\title{
Get the broader and narrower concept of one geological time concept in database
}
\description{Get the broader and narrower concept of one geological time concept in database
}
\usage{
gts.hierarchy(geoConcept, region = NULL, iscVersion = NULL, prefix = NULL, graph = NULL)
}
\arguments{
  \item{geoConcept}{
[character] Geological time concept, e.g. "Cambrian"
}
  \item{region}{
[character] Region of the geologcial time concept. The options are: "International",
                                         "North America", "South China", "North China",
                                         "West Europe", "Britain", "New Zealand",
                                         "Japan", "Baltoscania", "Australia". [If no input is provided, this is treated                                           as all regions, including the global one.]
}
  \item{iscVersion}{
[character] Version of the geological time concept, e.g. "isc2018-08". See \code{\link{gts.iscSchemes}} for all ISC versions.
}
  \item{prefix}{
[character] Prefix for SPARQL querying. [Optional, default is NULL]
}
  \item{graph}{
[character] GRAPH for SPARQL querying. [Optional, default is NULL]
}
}

\references{
}


\examples{
gts.hierarchy("Jurassic")
gts.hierarchy("Harju") 
gts.hierarchy("Wordian") # not narrowerConcept
gts.hierarchy("Precambrian") # no broaderCocnept

}

