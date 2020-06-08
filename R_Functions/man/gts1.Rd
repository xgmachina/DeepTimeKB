\name{gts1}
\title{
Function querying start time, end time and duration of a specific geological time concept
}
\description{
}
\usage{
gts1(geoConcept, prefix = NULL, graph = NULL)
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
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Beginning and end time of the geoConcept and its duration.
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
 \code{\link{gts.topo}}
}
\examples{
# Local concept in North America
gts1("Roadian") 
# Global concept
gts1("Jurassic") 

}

