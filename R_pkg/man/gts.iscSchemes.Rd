\name{gts.iscSchemes}
\alias{gts.iscSchemes}
\title{
List all versions of the ISC
}
\description{List all versions of the ISC.
}
\usage{
gts.iscSchemes(id = "all", prefix = NULL, graph = NULL, URI = TRUE)
}
\arguments{
  \item{id}{
[character] "all" or "latest". If "all", return all the isc schemes in the database; if "latest", return the latest ISC scheme in the database.
}
  \item{prefix}{
[character] Prefix for SPARQL querying. [Optional, default is NULL]
}
  \item{graph}{
[character] GRAPH for SPARQL querying. [Optional, default is NULL]
}
  \item{URI}{
[character] Show result as URI or not. [TRUE (default) or FALSE]
}
}

\references{
Ma, X., Ma, C. and Wang, C., 2020. A new structure for representing and tracking version information in a deep time knowledge graph. Computers & Geosciences, p.104620. https://doi.org/10.1016/j.cageo.2020.104620 
}

\examples{
gts.iscSchemes("all")
gts.iscSchemes("latest")
gts.iscSchemes("latest", URI=FALSE)
gts.iscSchemes("all", URI=FALSE)
}

