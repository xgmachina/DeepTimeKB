\name{gssp.map}
\alias{gssp.map}
\title{
Plot the locations of the Global Boundary Stratotype Section and Point (GSSP) on the world map
}
\description{
Plot the locations of the Global Boundary Stratotype Section and Point (GSSP) on the world map.
}
\usage{
gssp.map(iscVersion = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{iscVersion}{
[character] Plot the GSSP of the specified version of the Geological Time Scale. The version is a geological time concept, e.g. "isc2018-08". See \code{\link{gts.iscSchemes}} for all ISC versions.
}
}

\seealso{
\code{\link{gts.gssp}}
\code{\link{gts.iscSchemes}}
}

\references{
Ma, X., Ma, C. and Wang, C., 2020. A new structure for representing and tracking version information in a deep time knowledge graph. Computers & Geosciences, p.104620. https://doi.org/10.1016/j.cageo.2020.104620 
}

\examples{
# Plot the GSSP in the latest version of the International Stratigraphic Chart (ISC)
gssp.map(iscVersion = "2018")
}
