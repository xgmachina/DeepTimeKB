\name{gts.level}
\alias{gts.level}
\title{
Get the level of the geological time concept
}
\description{Get the level of the geological time concept.
}
\usage{
gts.level(geoConcept, region = NULL, iscVersion = NULL, prefix = NULL, graph = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{geoConcept}{
[character] Geological time concept, e.g. "Cambrian"
}
  \item{region}{
[character] region of the geologcial time concept. The options are: "International",
                                         "West Europe", "Tethyan", "N-E Siberia",     
                                         "South China", "Russia Platform", "New Zealand",
                                         "North China", "North America","Kazakhstan",
                                         "Japan", "Iberian-Morocco", "California", "Britain"
                                         , "Boreal", "Baltoscania" ,"East Avalonian",
                                         "Australia" .
                                         [If no input is provided, this is treated                                           as all regions, including the global one.]
}
  \item{iscVersion}{
[character] ersion of the geological time concept, e.g. "isc2018-08". See \code{\link{gts.iscSchemes}} for all ISC versions.
}
  \item{prefix}{
[character] Prefix for SPARQL querying. [Optional, default is NULL]
}
  \item{graph}{
[character] GRAPH for SPARQL querying. [Optional, default is NULL]
}
}

\references{
Ma, X., Ma, C. and Wang, C., 2020. A new structure for representing and tracking version information in a deep time knowledge graph. Computers & Geosciences, p.104620. https://doi.org/10.1016/j.cageo.2020.104620 
}


\examples{
gts.level("Jurassic")
}

