% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{relped}
\alias{relped}
\title{Relped data}
\format{
The dataframe is composed of 4 columns:
\itemize{
\item \code{id1} : the first individual identifier,
\item \code{id2} : the second individual identifier,
\item \code{code} : the relationship between the two individuals,
\item \code{famid} : the family identifier.
The relationship codes are:
\item \code{1} for Monozygotic twin
\item \code{2} for Dizygotic twin
\item \code{3} for Twin of unknown zygosity
\item \code{4} for Spouse relationship
}
}
\usage{
data("relped")
}
\description{
Small set of related individuals for testing purposes.
}
\details{
This is a small fictive data set of relation that accompanies
the sampleped data set.
The aim was to create a data set with a variety of relationships.
There is 8 relations with 4 different types of relationships.
}
\examples{
data("relped")
data("sampleped")
pedi <- Pedigree(sampleped, relped)
summary(pedi)
if (interactive()) { plot(pedi) }
}
\keyword{datasets}
