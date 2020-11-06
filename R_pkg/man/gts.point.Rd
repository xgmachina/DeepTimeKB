\name{gts.point}
\alias{gts.point}
\title{
Function querying all the geological time concepts that include the specified time point
}
\description{Function querying all the geological time concepts that include the specified time point.
}
\usage{
gts.point(time, prefix = NULL, graph = NULL)
}
\arguments{
  \item{time}{
[numeric] Geological time in million years BP (Ma), eg. 200
}
\item{prefix}{
[character] Prefix for SPARQL querying. [Optional]
}
\item{graph}{
[character] GRAPH for SPARQL querying. [Optional]
}
}

\references{
Ma, X., Ma, C. and Wang, C., 2020. A new structure for representing and tracking version information in a deep time knowledge graph. Computers & Geosciences, p.104620. https://doi.org/10.1016/j.cageo.2020.104620 
}

\examples{
gts.point(200)
}
