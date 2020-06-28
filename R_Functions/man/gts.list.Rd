\name{gts.list}
\alias{gts.list}
\title{
Function querying all the geological time concept of a region or international geological time concept.
}
\description{
}
\usage{
gts.list(region, level=NULL)
}
\arguments{
\item{region}{
[character] region of the geologcial time concept. The options are: "International",
                                         "North America", "South China", "North China",
                                         "West Europe", "Britain", "New Zealand",
                                         "Japan", "Baltoscania", "Australia".
}
\item{level}{
[character] The level of the geological time concept, e.g. "Age". [Optional]
}
\item{prefix}{
[character] prefix for SPARQL querying. [Optional]
}
\item{graph}{
[character] GRAPH for SPARQL querying. [Optional]
}
}

\references{
%% ~put references to the literature/web site here ~
}

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
# query the Age level geological time concept for the North America
gts.list(region = "North America", level = "Age")
}