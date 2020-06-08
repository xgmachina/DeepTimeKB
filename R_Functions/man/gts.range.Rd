\name{gts.range}
\title{
Function querying all geological time concepts within a time interval
}
\description{
}
\usage{
gts.range(geotime1, geotime2, prefix=NULL, graph=NULL)
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
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
All geological time concepts between geotime1 and geotime2.
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

\seealso{
 \code{\link{}}
}
\examples{
gts.range(50,100)
}

