\name{gts.list}
\alias{gts.list}
\title{
Function querying the geological time concept of a region or the international geological time concept
}
\description{Function querying the geological time concept of a region or the international geological time concept.
}
\usage{
gts.list(region, level=NULL)
}
\arguments{
\item{region}{
[character] Region of the geologcial time concept. The options are: "International",
                                         "North America", "South China", "North China",
                                         "West Europe", "Britain", "New Zealand",
                                         "Japan", "Baltoscania", "Australia".
}
\item{level}{
[character] The level of the geological time concept, e.g. "Age". [Optional]
}
}

\references{
Ma, X., Ma, C. and Wang, C., 2020. A new structure for representing and tracking version information in a deep time knowledge graph. Computers & Geosciences, p.104620. https://doi.org/10.1016/j.cageo.2020.104620 
}

\examples{
# query the Age level geological time concept for North America
gts.list(region = "North America", level = "Age")
}