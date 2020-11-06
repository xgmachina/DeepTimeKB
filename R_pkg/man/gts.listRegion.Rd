\name{gts.listRegion}
\alias{gts.listRegion}
\title{
Function querying the geological time concept of a region or the international geological time concept
}
\description{Function querying the geological time concept of a region or the international geological time concept.
}
\usage{
gts.listRegion(prefix = NULL, graph = NULL)
}
\arguments{
\item{prefix}{
[character] prefix for SPARQL querying. [Optional]
}
\item{graph}{
[character] GRAPH for SPARQL querying. [Optional]
}
}

\references{
Ma, X., Ma, C. and Wang, C., 2020. A new structure for representing and tracking version information in a deep time knowledge graph. Computers & Geosciences, p.104620. https://doi.org/10.1016/j.cageo.2020.104620 
}

\examples{
gts.listRegion()
}