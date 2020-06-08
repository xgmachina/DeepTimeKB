\name{gts.topo}
\title{
Topology of two geological time concept

}
\description{
}
\usage{
gts.topo(geoConcept1, geoConcept2, prefix = NULL, graph = NULL)
}
\arguments{
  \item{geoConcept1}{
[character] Geological time concept, eg. "Cambrian"
}
  \item{geoConcept2}{
[character] Geological time concept, eg. "Jurassic"
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
 \code{\link{gts1}}
}
\examples{
# Adavere Age (local) vs. Jurassic Period (global). Should be Before
gts.topo(geoConcept1 = "Adavere", geoConcept2 = "Jurassic")
# Jurassic Period (global) vs. Panerozoic Eon (global). Should be During
gts.topo(geoConcept1 = "Jurassic", geoConcept2 = "Phanerozoic")  
}

