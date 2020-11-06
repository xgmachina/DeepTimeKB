\name{gts.within}
\alias{gts.within}
\title{
Function querying all geological time concepts within a time interval
}
\description{Function querying all geological time concepts within a time interval.
}
\usage{
gts.within(geotime1, geotime2, prefix=NULL, graph=NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{geotime1}{
[numeric] Geological time in million years BP (Ma), e.g. 50.
}
  \item{geotime2}{
[numeric] Geological time in million years BP (Ma), e.g. 100.
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
gts.within(50,100)
}

