#' Get the years available for a given geometry
#'
#' @param category A string corresponding to the category code
#' @param geometry A string corresponding to the geometry code
#'
#' @return A vector of years
#' @export
thema_year <- function(category = c("inst", "rrep", "anal", "rtyp", "inke", "topo"), geometry) {
  category <- match.arg(category)

  get(category) %>%
    dplyr::filter(code == geometry) %>%
    dplyr::arrange(year) %>%
    dplyr::pull(year) %>%
    unique()
}

#' Get the available codes for a given category
#'
#' @param category A string corresponding to the category code
#'
#' @return A datafram with code as well as French and German descriptions
#' @export
thema_geom <- function(category = c("inst", "rrep", "anal", "rtyp", "inke", "topo")) {
  category <- match.arg(category)

  get(category) %>%
    dplyr::arrange(code) %>%
    dplyr::select(code, geometry_french, geometry_german) %>%
    dplyr::distinct()
}
