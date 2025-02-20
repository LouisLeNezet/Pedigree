% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{is_parent}
\alias{is_parent}
\alias{is_parent,character_OR_integer-method}
\alias{is_parent,Ped-method}
\title{Are individuals parents}
\usage{
\S4method{is_parent}{character_OR_integer}(obj, dadid, momid, missid = NA_character_)

\S4method{is_parent}{Ped}(obj, missid = NA_character_)
}
\arguments{
\item{obj}{A vector of each subjects identifiers or a Ped object}

\item{dadid}{A vector containing for each subject, the identifiers of the
biologicals fathers.}

\item{momid}{A vector containing for each subject, the identifiers of the
biologicals mothers.}

\item{missid}{A character vector with the missing values identifiers.
All the id, dadid and momid corresponding to those values will be set
to \code{NA_character_}.}
}
\value{
A vector of boolean of the same size as \strong{obj}
with TRUE if the individual is a parent and FALSE otherwise
}
\description{
Check which individuals are parents.
}
\examples{

is_parent(c("1", "2", "3", "4"), c("3", "3", NA, NA), c("4", "4", NA, NA))

data(sampleped)
pedi <- Pedigree(sampleped)
is_parent(ped(pedi))
}
