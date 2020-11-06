\name{gts.gssp}
\alias{gts.gssp}
\title{
Query the GSSP data
}
\description{
Query the GSSP data.
}
\usage{
gts.gssp(iscVersion = NULL, prefix = NULL, graph = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{iscVersion}{
[character] Plot the GSSP of the specified version of the Geological Time Scale. The version is a geological time concept, e.g. "isc2018-08". See \code{\link{gts.iscSchemes}} for all ISC versions.
}
 \item{prefix}{
[character] Prefix for SPARQL querying. [Optional]
}
  \item{graph}{
[character] GRAPH for SPARQL querying. [Optional]
}
}

\seealso{
\code{\link{gssp.map}}
\code{\link{gts.iscSchemes}}
}

\references{
Ma, X., Ma, C. and Wang, C., 2020. A new structure for representing and tracking version information in a deep time knowledge graph. Computers & Geosciences, p.104620. https://doi.org/10.1016/j.cageo.2020.104620 
}

\examples{
# Query the GSSP from the latest version of the ISC in the database
gssp.map(iscVersion = "latest")
}