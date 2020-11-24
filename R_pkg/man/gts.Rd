\name{gts}
\alias{gts}
\title{
Get all the properties of one geological time concept in the database
}
\description{Get all the properties of one geological time concept in the database.
}
\usage{
gts(geoConcept, prefix = NULL, graph = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{geoConcept}{
[character] Geological time concept, eg. "Cambrian"
}
  \item{prefix}{
[character] prefix for SPARQL querying. [Optional, default is NULL]
}
  \item{graph}{
[character] GRAPH for SPARQL querying. [Optional, default is NULL]
}
}

\references{
Ma, X., Ma, C. and Wang, C., 2020. A new structure for representing and tracking version information in a deep time knowledge graph. Computers & Geosciences, p.104620. https://doi.org/10.1016/j.cageo.2020.104620 
}


\examples{
gts("Jurassic")
}

