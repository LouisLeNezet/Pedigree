% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_fct.R
\name{find_ray_intersections}
\alias{find_ray_intersections}
\title{Find intersections of a ray with a segment}
\usage{
find_ray_intersections(x0, y0, x1, y1, theta)
}
\arguments{
\item{x0}{x-coordinate of the segment's starting point}

\item{y0}{y-coordinate of the segment's starting point}

\item{x1}{x-coordinate of the segment's ending point}

\item{y1}{y-coordinate of the segment's ending point}

\item{theta}{Angle of the ray from the origin (in radians)}
}
\value{
A vector of the x and y coordinates of the intersection
point, or NA if no intersection occurs.
}
\description{
Given the coordinates of a segment and the angle of a ray
from the origin, this function computes the intersection
point of the ray with the segment.
}
\examples{
Pedixplorer:::find_ray_intersections(0, 0, 1, 1, pi / 4)
}
\keyword{internal}
