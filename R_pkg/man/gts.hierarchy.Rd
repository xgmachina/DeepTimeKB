\name{gts.hierarchy}
\alias{gts.hierarchy}
\title{
Get the broader and narrower concept of one geological time concept in database
}
\description{Get the broader and narrower concept of one geological time concept in database
}
\usage{
gts.hierarchy(geoConcept, prefix = NULL, graph = NULL)
}
\arguments{
  \item{geoConcept}{
[character] Geological time concept, e.g. "Cambrian"
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
gts.hierarchy("Jurassic")
gts.hierarchy("Harju") 
gts.hierarchy("Wordian") # not narrowerConcept
gts.hierarchy("Precambrian") # no broaderCocnept

}

