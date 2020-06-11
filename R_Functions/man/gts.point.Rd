\name{gts.point}
\alias{gts.point}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function querying  all the broader and broaderTransitive concepts.i.e. concepts at higher levels, such as Epoch, Period, Era, and Eon.
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
gts.point(T_beg)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{T_beg}{
[numeric] Geological time in million years BP (Ma), eg. 200
}
\item{prefix}{
[character] prefix for SPARQL querying. [Optional]
}
\item{graph}{
[character] GRAPH for SPARQL querying. [Optional]
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
All the concepts at higher levels, such as Epoch, Period, Era, and Eon.
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

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
gts.point(200)
}
