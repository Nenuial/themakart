% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sysdata.R
\docType{data}
\name{topo}
\alias{topo}
\title{topo data}
\format{
An object of class \code{tbl_df} (inherits from \code{tbl}, \code{data.frame}) with 8 rows and 11 columns.
}
\source{
\url{https://www.bfs.admin.ch/bfs/fr/home/statistiques/statistique-regions/fonds-cartes/geometries-base.html}
}
\usage{
topo
}
\description{
A dataset containing the topographical geometries
}
\section{Data}{

A data frame with 11 variables:
\describe{
  \item{code}{the geomotry code}
  \item{date}{the date of the geometries}
  \item{geometrylevel}{either gf for full surface or vf for limited to useful surface}
  \item{geometrytype}{the type of gemotry}
  \item{map}{the data in an sf dataframe}
  \item{year}{the year}
  \item{cat_code}{the code of the category}
  \item{category_french}{the category in French}
  \item{geometry_french}{the geometry in French}
  \item{category_german}{the category in German}
  \item{geometry_german}{the geometry in German}
}
}

\keyword{datasets}
