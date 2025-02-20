% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{vect_to_binary}
\alias{vect_to_binary}
\title{Vector variable to binary vector}
\usage{
vect_to_binary(vect, logical = FALSE, default = NA)
}
\arguments{
\item{vect}{A character, factor, logical or numeric vector corresponding to
a binary variable (i.e. \code{0} or \code{1}).
The following values are recognized:
\itemize{
\item character() or factor() : "TRUE", "FALSE", "0", "1", "NA" will be
respectively transformed to \code{1}, \code{0}, \code{0}, \code{1}, \code{NA}.
Spaces and case are ignored.
All other values will be transformed to NA.
\item numeric() : \code{0} and \code{1} are kept, all other values
are transformed to NA.
\item logical() : \code{TRUE} and \code{FALSE} are tansformed to
\code{1} and\code{0}.
}}

\item{logical}{Boolean defining if the output should be a logical vector
instead of a numeric vector
(i.e. \code{0} and \code{1} becomes
\code{FALSE} and `TRUE).}

\item{default}{The default value to use for the values that are not
recognized. By default, \code{NA} is used, but it can be \code{0} or \code{1}.}
}
\value{
numeric binary vector of the same size as \strong{vect}
with \code{0} and \code{1}
}
\description{
Transform a vector to a binary vector.
All values that are not \code{0}, \code{1}, \code{TRUE},
\code{FALSE}, or \code{NA} are transformed to \code{NA}.
}
\examples{
vect_to_binary(
    c(0, 1, 2, 3.6, "TRUE", "FALSE", "0", "1", "NA", "B", TRUE, FALSE, NA)
)
}
\keyword{internal}
