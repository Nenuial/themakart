#' inst data
#'
#' A dataset containing the institutional geometries
#'
#' @section Data:
#' A data frame with 11 variables:
#' \describe{
#'   \item{code}{the geomotry code}
#'   \item{date}{the date of the geometries}
#'   \item{geometrylevel}{either gf for full surface or vf for limited to useful surface}
#'   \item{geometrytype}{the type of gemotry}
#'   \item{map}{the data in an sf dataframe}
#'   \item{year}{the year}
#'   \item{cat_code}{the code of the category}
#'   \item{category_french}{the category in French}
#'   \item{geometry_french}{the geometry in French}
#'   \item{category_german}{the category in German}
#'   \item{geometry_german}{the geometry in German}
#' }
#' @source \url{https://www.bfs.admin.ch/bfs/fr/home/statistiques/statistique-regions/fonds-cartes/geometries-base.html}
"inst"

#' rrep data
#'
#' A dataset containing the regional research geometries
#'
#' @inheritSection inst Data
#' @inherit inst source
"rrep"

#' anal data
#'
#' A dataset containing the regional analytics geometries
#'
#' @inheritSection inst Data
#' @inherit inst source
"anal"

#' rtyp data
#'
#' A dataset containing the regional typology geometries
#'
#' @inheritSection inst Data
#' @inherit inst source
"rtyp"

#' inke data
#'
#' A dataset containing the infra-communal geometries
#'
#' @inheritSection inst Data
#' @inherit inst source
"inke"

#' topo data
#'
#' A dataset containing the topographical geometries
#'
#' @inheritSection inst Data
#' @inherit inst source
"topo"

#' relief data
#'
#' A dataset containing a simplified topographical relief of Switzerland
#'
#' @section Data:
#' A data frame with 3 variables:
#' \describe{
#'   \item{value}{the altitude}
#'   \item{x}{the longitude}
#'   \item{y}{the latitude}
"relief"
