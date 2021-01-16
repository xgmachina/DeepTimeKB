\name{gts.topo}
\alias{gts.topo}
\title{
Topology of two geological time concepts
}
\description{Topology of two geological time concepts.
}
\usage{
gts.topo(geoConcept1, geoConcept2, 
          region1 = NULL, iscVersion1 = NULL, 
          region2 = NULL, iscVersion2 = NULL, 
          prefix = NULL, graph = NULL)
}
\arguments{
  \item{geoConcept1}{
[character] Geological time concept, e.g. "Cambrian".
}
  \item{geoConcept2}{
[character] Geological time concept, e.g. "Jurassic".
}
  \item{region1}{
[character] Region of geoConcept1, eg. "International". The options are: "International",
                                         "West Europe", "Tethyan", "N-E Siberia",     
                                         "South China", "Russia Platform", "New Zealand",
                                         "North China", "North America","Kazakhstan",
                                         "Japan", "Iberian-Morocco", "California", "Britain"
                                         , "Boreal", "Baltoscania" ,"East Avalonian",
                                         "Australia" .
}
  \item{iscVersion1}{
[character] Geological time concept, e.g. "isc2018-08". See gts.iscSchemes() for all ISC versions.
}
  \item{region2}{
[character] Region of geoConcept1, e.g. "International". The options are: "International",
                                         "West Europe", "Tethyan", "N-E Siberia",     
                                         "South China", "Russia Platform", "New Zealand",
                                         "North China", "North America","Kazakhstan",
                                         "Japan", "Iberian-Morocco", "California", "Britain"
                                         , "Boreal", "Baltoscania" ,"East Avalonian",
                                         "Australia" .
}
  \item{iscVersion2}{
[character] Geological time concept, e.g. "isc2018-08". See gts.iscSchemes() for all ISC versions.
}
  \item{prefix}{
[character] Prefix for SPARQL querying. [Optional, default is NULL]
}
  \item{graph}{
[character] GRAPH for SPARQL querying. [Optional, default is NULL]
}
}

\value{
Topology of two geological time concepts. All possible topologies in time are referred to here: https://www.w3.org/TR/owl-time/#topology
}

\references{
Ma, X., Ma, C. and Wang, C., 2020. A new structure for representing and tracking version information in a deep time knowledge graph. Computers & Geosciences, p.104620. https://doi.org/10.1016/j.cageo.2020.104620 
}


\seealso{
 \code{\link{gts.iscSchemes}}
 \code{\link{gts.listRegion}}
 \code{\link{gts.range}}
}
\examples{
gts.topo("Harju", "Wordian", region2 = "North America")

gts.topo("Jurassic", "Harju", iscVersion1 = "2012")

}

