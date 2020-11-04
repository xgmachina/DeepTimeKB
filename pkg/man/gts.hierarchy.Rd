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
[character] Geological time concept, eg. "Cambrian"
}
  \item{region}{
[character] region of the geologcial time concept. The options are: "International",
                                         "North America", "South China", "North China",
                                         "West Europe", "Britain", "New Zealand",
                                         "Japan", "Baltoscania", "Australia". [If no input of this,                                               treat it as all regions including the global one]
}
  \item{iscVersion}{
[character] Geological time concept, eg. "isc2018-08". See gts.iscSchemes() for all ISC versions.
}
  \item{prefix}{
[character] prefix for SPARQL querying. [Optional, default is NULL]
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

