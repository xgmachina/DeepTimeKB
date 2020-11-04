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
                                         "North America", "South China", "North China",
                                         "West Europe", "Britain", "New Zealand",
                                         "Japan", "Baltoscania", "Australia".
}
  \item{iscVersion1}{
[character] Geological time concept, e.g. "isc2018-08". See gts.iscSchemes() for all ISC versions.
}
  \item{region2}{
[character] Region of geoConcept1, e.g. "International". The options are: "International",
                                         "North America", "South China", "North China",
                                         "West Europe", "Britain", "New Zealand",
                                         "Japan", "Baltoscania", "Australia".
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
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Topology of two geological time concepts. All possible topologies in time are referred to here: https://www.w3.org/TR/owl-time/#topology
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
