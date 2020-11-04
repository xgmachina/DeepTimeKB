\name{gts.topo}
\alias{gts.topo}
\title{
Topology of two geological time concept
}
\description{Topology of two geological time concept.
}
\usage{
gts.topo(geoConcept1, geoConcept2, 
          region1 = NULL, iscVersion1 = NULL, 
          region2 = NULL, iscVersion2 = NULL, 
          prefix = NULL, graph = NULL)
}
\arguments{
  \item{geoConcept1}{
[character] Geological time concept, eg. "Cambrian"
}
  \item{geoConcept2}{
[character] Geological time concept, eg. "Jurassic"
}
  \item{region1}{
[character] Region of geoConcept1, eg. "International". The options are: "International",
                                         "North America", "South China", "North China",
                                         "West Europe", "Britain", "New Zealand",
                                         "Japan", "Baltoscania", "Australia".
}
  \item{iscVersion1}{
[character] Geological time concept, eg. "isc2018-08". See gts.iscSchemes() for all ISC versions.
}
  \item{region2}{
[character] Region of geoConcept1, eg. "International". The options are: "International",
                                         "North America", "South China", "North China",
                                         "West Europe", "Britain", "New Zealand",
                                         "Japan", "Baltoscania", "Australia".
}
  \item{iscVersion2}{
[character] Geological time concept, eg. "isc2018-08". See gts.iscSchemes() for all ISC versions.
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
Topology of two geological time concept. All possible topology in time is refered to: https://www.w3.org/TR/owl-time/#topology
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
 \code{\link{gts.iscSchemes}}
 \code{\link{gts.listRegion}}
 \code{\link{gts.range}}
}
\examples{
gts.topo("Harju", "Wordian", region2 = "North America")

gts.topo("Jurassic", "Harju", iscVersion1 = "2012")

}

