\name{gts.gssp}
\alias{gts.gssp}
\title{
Query the GSSP data
}
\description{
Query the GSSP data
}
\usage{
gts.gssp(iscVersion = NULL, prefix = NULL, graph = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{iscVersion}{
[character] Plot the GSSP of which version of the Geological Time Scale. The version of geological time concept, eg. "isc2018-08". See gts.iscSchemes() for all ISC versions. 
}
 \item{prefix}{
[character] prefix for SPARQL querying. [Optional]
}
  \item{graph}{
[character] GRAPH for SPARQL querying. [Optional]
}
}

\seealso{
\code{\link{gssp.map}}
\code{\link{gts.iscSchemes}}
}
\examples{
# Query the GSSP from the latest version of the ISC in the database
gssp.map(iscVersion = "latest")
}