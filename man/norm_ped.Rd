% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/norm_data.R
\name{norm_ped}
\alias{norm_ped}
\title{Normalise a Ped object dataframe}
\usage{
norm_ped(
  ped_df,
  na_strings = c("NA", ""),
  missid = NA_character_,
  try_num = FALSE,
  cols_used_del = FALSE,
  date_pattern = "\%Y-\%m-\%d"
)
}
\arguments{
\item{ped_df}{A data.frame with the individuals informations.
The minimum columns required are:
\itemize{
\item \code{id} individual identifiers
\item \code{dadid} biological fathers identifiers
\item \code{momid} biological mothers identifiers
\item \code{sex} of the individual
}

The \code{famid} column, if provided, will be merged to
the \emph{ids} field separated by an underscore using the
\code{\link[=upd_famid]{upd_famid()}} function.

The following columns are also recognize and will be transformed with the
\code{\link[=vect_to_binary]{vect_to_binary()}} function:
\itemize{
\item \code{deceased} status -> is the individual dead
\item \code{avail} status -> is the individual available
\item \code{evaluated} status -> has the individual a documented evaluation
\item \code{consultand} status -> is the individual the consultand
\item \code{proband} status -> is the individual the proband
\item \code{carrier} status -> is the individual a carrier
\item \code{asymptomatic} status -> is the individual asymptomatic
\item \code{adopted} status -> is the individual adopted
}

The values recognized for those columns are \code{1} or \code{0},
\code{TRUE} or \code{FALSE}.

The \code{fertility} column will be transformed to a factor using the
\code{\link[=fertility_to_factor]{fertility_to_factor()}} function.
\code{infertile_choice_na}, \code{infertile}, \code{fertile}

The \code{miscarriage} column will be transformed to a using the
\code{\link[=miscarriage_to_factor]{miscarriage_to_factor()}} function.
\code{SAB}, \code{TOP}, \code{ECT}, \code{FALSE}

The \code{dateofbirth} and \code{dateofdeath} columns will be transformed to
a date object using the \code{\link[=char_to_date]{char_to_date()}} function.}

\item{na_strings}{Vector of strings to be considered as NA values.}

\item{missid}{A character vector with the missing values identifiers.
All the id, dadid and momid corresponding to those values will be set
to \code{NA_character_}.}

\item{try_num}{Boolean defining if the function should try to convert
all the columns to numeric.}

\item{cols_used_del}{Boolean defining if the columns that will be used
should be deleted.}

\item{date_pattern}{The pattern of the date}
}
\value{
A dataframe with different variable correctly standardized
and with the errors identified in the \code{error} column
}
\description{
Normalise dataframe for a Ped object
}
\details{
Normalise a dataframe and check for columns correspondance
to be able to use it as an input to create a Ped object.
Multiple test are done and errors are checked.

Will be considered available any individual with no 'NA' values in the
\code{available} column.
Duplicated \code{id} will nullify the relationship of the individual.
All individuals with errors will be remove from the dataframe and will
be transfered to the error dataframe.

A number of checks are done to ensure the dataframe is correct:
\subsection{On identifiers:}{
\itemize{
\item All ids (id, dadid, momid, famid) are not empty (\verb{!= ""})
\item All \code{id} are unique (no duplicated)
\item All \code{dadid} and \code{momid} are unique in the id column
(no duplicated)
\item id is not the same as dadid or momid
\item Either have both parents or none
}
}

\subsection{On sex:}{
\itemize{
\item All sex code are either \code{male}, \code{female},
or \code{unknown}.
\item No parents are infertile or aborted
\item All fathers are male
\item All mothers are female
}
}
}
\examples{
df <- data.frame(
    id = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
    dadid = c("A", 0, 1, 3, 0, 4, 1, 0, 6, 6),
    momid = c(0, 0, 2, 2, 0, 5, 2, 0, 8, 8),
    famid = c(1, 1, 1, 1, 1, 1, 1, 2, 2, 2),
    sex = c(1, 2, "m", "man", "f", "male", "m", 3, NA, "f"),
    fertility = c(
      "TRUE", "FALSE", TRUE, FALSE, 1,
      0, "fertile", "infertile", 1, "TRUE"
    ),
    miscarriage = c("TOB", "SAB", NA, FALSE, "ECT", "other", 1, 0, 1, 0),
    deceased = c("TRUE", "FALSE", TRUE, FALSE, 1, 0, 1, 0, 1, 0),
    avail = c("A", "1", 0, NA, 1, 0, 1, 0, 1, 0),
    evalutated = c(
        "TRUE", "FALSE", TRUE, FALSE, 1, 0, NA, "NA", "other", "0"
    ),
    consultand = c(
        "TRUE", "FALSE", TRUE, FALSE, 1, 0, NA, "NA", "other", "0"
    ),
    proband = c("TRUE", "FALSE", TRUE, FALSE, 1, 0, NA, "NA", "other", "0"),
    carrier = c("TRUE", "FALSE", TRUE, FALSE, 1, 0, NA, "NA", "other", "0"),
    asymptomatic = c(
        "TRUE", "FALSE", TRUE, FALSE, 1, 0, NA, "NA", "other", "0"
    ),
    adopted = c("TRUE", "FALSE", TRUE, FALSE, 1, 0, NA, "NA", "other", "0"),
    dateofbirth = c(
         "1978-01-01", "1980-01-01", "1982-01-01", "1984-01-01",
         "1986-01-01", "1988-01-01", "1990-01-01", "1992-01-01",
         "1994-01-01", "1996-01-01"
    ),
    dateofdeath = c(
        "2000-01-01", "2002-01-01", "2004-01-01", NA, "date-not-recognize",
        "NA", "", NA, "2008/01/01", NA
    )
)
tryCatch(
    norm_ped(df),
    error = function(e) print(e)
)

}
\seealso{
\code{\link[=Ped]{Ped()}}
\linkS4class{Ped}
\code{\link[=Pedigree]{Pedigree()}}
}
