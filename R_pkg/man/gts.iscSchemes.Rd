\name{gts.iscSchemes}
\alias{gts.iscSchemes}
\title{
Function querying start time, end time and duration of a specific geological time concept
}
\description{Function querying start time, end time, and duration of a specific geological time concept.
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

\examples{
gts.iscSchemes("all")
gts.iscSchemes("latest")
gts.iscSchemes("latest", URI=FALSE)
gts.iscSchemes("all", URI=FALSE)
}

