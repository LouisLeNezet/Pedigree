% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/app_utils.R
\name{get_title}
\alias{get_title}
\title{Get the title of the family information table}
\usage{
get_title(
  family_sel,
  subfamily_sel,
  family_var,
  mod,
  inf_selected,
  kin_max,
  keep_parents,
  nb_rows,
  short_title = FALSE
)
}
\arguments{
\item{family_sel}{the selected family}

\item{subfamily_sel}{the selected subfamily}

\item{family_var}{the selected family variable}

\item{mod}{the selected affected modality}

\item{inf_selected}{the selected informative individuals}

\item{kin_max}{the maximum kinship}

\item{keep_parents}{the keep parents option}

\item{nb_rows}{the number of individuals}

\item{short_title}{a boolean to generate a short title}
}
\value{
a string with the title
}
\description{
This function generates the title of the family information table
depending on the selected family and subfamily and other parameters.
}
\examples{
get_title(1, 1, "health", "A", "All", 3, TRUE, 10, FALSE)
get_title(1, 1, "health", "A", "All", 3, TRUE, 10, TRUE)
get_title(1, 1, "health", "A", "All", 3, FALSE, 10, FALSE)
}
\keyword{internal}
