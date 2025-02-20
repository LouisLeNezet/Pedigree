% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/app_ped_avaf_infos.R
\name{family_infos_table}
\alias{family_infos_table}
\title{Affection and availability information table}
\usage{
family_infos_table(pedi, col_val = NA)
}
\arguments{
\item{pedi}{A pedigree object.}

\item{col_val}{The column name in the \code{fill} slot
of the pedigree object to use for the table.}
}
\value{
A cross table dataframe with the affection and availability
information.
}
\description{
This function creates a table with the affection and availability
information for all individuals in a pedigree object.
}
\examples{
data(sampleped)
pedi <- Pedigree(sampleped)
pedi <- generate_colors(pedi, "num_child_tot", threshold = 2)
Pedixplorer:::family_infos_table(pedi, "num_child_tot")
Pedixplorer:::family_infos_table(pedi, "affection")
}
\keyword{ped_avaf_infos}
