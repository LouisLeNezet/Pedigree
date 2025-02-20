% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllValidity.R
\name{is_valid_hints}
\alias{is_valid_hints}
\title{Check if a Hints object is valid}
\usage{
is_valid_hints(object)
}
\arguments{
\item{object}{A Hints object.}
}
\value{
A character vector with the errors or \code{TRUE} if no errors.
}
\description{
Check if horder and spouse slots are valid:
\itemize{
\item horder is named numeric vector
\item spouse is a data.frame
\itemize{
\item Has the three \code{idr}, \code{idl}, \code{anchor} columns
\item \code{idr} and \code{idl} are different and doesn't contains \code{NA}
\item \code{idr} and \code{idl} couple are unique
\item \code{anchor} column only have \code{right}, \code{left}
or \code{either} values
}
\item all ids in spouse needs to be in the names of the horder vector
}
}
\keyword{internal}
