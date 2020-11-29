#' Get the map data for a given category, geometry and year
#'
#' @param category A string corresponding to the category code
#' @param geometry A string corresponding to the geometry code
#' @param year An integer corresponding to the year of the geometry
#' @param level One of gf (general) or vf (limited surfaces)
#'
#' @return
#' @export
thema_map <- function(category = c("inst", "rrep", "anal", "rtyp", "inke", "topo"),
                      geometry, year, level = c("gf", "vf")) {
  category <- match.arg(category)
  level <- match.arg(level)
  require(sf)

  get(category) %>%
    dplyr::filter(code == geometry, year == year, geometrylevel == level) %>%
    dplyr::pull(map) %>%
    purrr::chuck(1)
}

#' Get topo data
#'
#' @param geometry A string corresponding to the geometry code
#'
#' @return
#' @export
thema_topo <- function(geometry = c("flus", "seen", "stkt")) {
  geometry <- match.arg(geometry)

  topo %>%
    dplyr::filter(code == geometry) %>%
    dplyr::pull(map) %>%
    purrr::chuck(1)
}

#' Get relief data
#'
#' @return
#' @export
thema_relief <- function() {
  relief
}
