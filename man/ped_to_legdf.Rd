% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ped_to_legdf.R
\name{ped_to_legdf}
\alias{ped_to_legdf}
\alias{ped_to_legdf,Pedigree-method}
\title{Create plotting legend data frame from a Pedigree}
\usage{
\S4method{ped_to_legdf}{Pedigree}(
  obj,
  boxh = 1,
  boxw = 1,
  cex = 1,
  adjx = 0,
  adjy = 0,
  lwd = par("lwd"),
  precision = 4
)
}
\arguments{
\item{obj}{A Pedigree object}

\item{boxh}{Height of the polygons elements}

\item{boxw}{Width of the polygons elements}

\item{cex}{Character expansion of the text}

\item{adjx}{default=0.  Controls the horizontal text adjustment of
the labels in the legend.}

\item{adjy}{default=0.  Controls the vertical text adjustment
of the labels in the legend.}

\item{lwd}{default=par("lwd").  Controls the bordering line width of the
elements in the legend.}

\item{precision}{The number of significatif numbers to round the
numbers to.}
}
\value{
A list containing the legend data frame and the user coordinates.
}
\description{
Convert a Pedigree to a legend data frame for it to
be plotted afterwards with \code{\link[=plot_fromdf]{plot_fromdf()}}.
}
\details{
The data frame contains the following columns:
\itemize{
\item \code{x0}, \code{y0}, \code{x1}, \code{y1}: coordinates of the elements
\item \code{type}: type of the elements
\item \code{fill}: fill color of the elements
\item \code{border}: border color of the elements
\item \code{angle}: angle of the shading of the elements
\item \code{density}: density of the shading of the elements
\item \code{cex}: size of the elements
\item \code{label}: label of the elements
\item \code{tips}: tips of the elements (used for the tooltips)
\item \code{adjx}: horizontal text adjustment of the labels
\item \code{adjy}: vertical text adjustment of the labels
}

All those columns are used by
\code{\link[=plot_fromdf]{plot_fromdf()}} to plot the graph.
}
\examples{
data("sampleped")
pedi <- Pedigree(sampleped)
leg_df <- ped_to_legdf(pedi)
summary(leg_df$df)
plot_fromdf(leg_df$df, usr = c(-1,15,0,7))
}
\keyword{Pedigree-plot}
\keyword{internal,}
