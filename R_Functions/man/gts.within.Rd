\name{gts.within}
\alias{gts.within}
\title{
Function querying all geological time concepts within a time interval
}
\description{Function querying all geological time concepts within a time interval
}
\usage{
gts.within(geotime1, geotime2, prefix=NULL, graph=NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{geotime1}{
[numeric] Geological time in million years BP (Ma), eg. 50
}
  \item{geotime2}{
[numeric] Geological time in million years BP (Ma), eg. 100
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
gts.within(50,100)
}

