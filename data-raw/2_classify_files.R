library(magrittr)

#Define the code table
categories <- tibble::tribble(
    ~code, ~cat_code,                       ~category_french,                                                  ~geometry_french,                       ~category_german,                                         ~geometry_german,
   "suis",    "inst",                "Niveau institutionnel",                                                          "Suisse",         "Institutionelle Gliederungen",                                                "Schweiz",
   "kant",    "inst",                "Niveau institutionnel",                                                         "Cantons",         "Institutionelle Gliederungen",                                                "Kantone",
   "bezk",    "inst",                "Niveau institutionnel",                                                       "Districts",         "Institutionelle Gliederungen",                                                "Bezirke",
   "polg",    "inst",                "Niveau institutionnel",                                                        "Communes",         "Institutionelle Gliederungen",                                              "Gemeinden",
   "voge",    "inst",                "Niveau institutionnel",                                            "Communes (politique)",         "Institutionelle Gliederungen",                                    "Gemeinden (Politik)",
   "rpla",    "rrep", "Espaces de la politique territoriale",                             "Régions d’aménagement du territoire", "Regionen der Raumentwicklungspolitik",                                   "Raumplanungsregionen",
   "bgbr",    "rrep", "Espaces de la politique territoriale",                                             "Régions de montagne", "Regionen der Raumentwicklungspolitik",                                            "Berggebiete",
   "weg1",    "rrep", "Espaces de la politique territoriale",                     "Zones économiques en redéploiement (ZER 01)", "Regionen der Raumentwicklungspolitik",          "Wirtschaftliche Erneuerungsgebiete (WEG 2001)",
   "ase1",    "rrep", "Espaces de la politique territoriale", "Zones d’application en matière d’allégements fiscaux (ZAF 2016)", "Regionen der Raumentwicklungspolitik", "Anwendungsgebiete für Steuererleichterungen (ASE 2016)",
   "greg",    "anal",                    "Regions d'analyse",                                                 "Grandes régions",                      "Analyseregionen",                                          "Grossregionen",
   "sprg",    "anal",                    "Regions d'analyse",                                           "Régions linguistiques",                      "Analyseregionen",                                          "Sprachgebiete",
   "amgr",    "anal",                    "Regions d'analyse",                                         "Grands bassins d'emploi",                      "Analyseregionen",                             "Arbeitsamarktgrossregionen",
   "amre",    "anal",                    "Regions d'analyse",                                                "Bassins d’emploi",                      "Analyseregionen",                                   "Arbeitsmarktregionen",
   "msre",    "anal",                    "Regions d'analyse",                                                      "Régions MS",                      "Analyseregionen",                                            "MS-Regionen",
   "aggl",    "anal",                    "Regions d'analyse",                                                  "Agglomérations",                      "Analyseregionen",                                        "Agglomerationen",
   "metr",    "anal",                    "Regions d'analyse",                                           "Aires métropolitaines",                      "Analyseregionen",                                          "Metropolräume",
   "tour",    "anal",                    "Regions d'analyse",                                            "Régions touristiques",                      "Analyseregionen",                                      "Tourismusregionen",
   "kgml",    "rtyp",             "Typologies territoriales",                "Centres urbains et espace sous influence urbaine",                 "Räumliche Typologien",  "Städtischer Kernraum und städtisch beeinflusster Raum",
   "kgil",    "rtyp",             "Typologies territoriales",                                        "Régions urbaines/rurales",                 "Räumliche Typologien",                         "Städtische / Ländliche Gebiete",
   "rsch",    "rtyp",             "Typologies territoriales",                                       "Espace à caractère urbain",                 "Räumliche Typologien",                         "Raum mit städtischem Charakter",
   "slty",    "rtyp",             "Typologies territoriales",                                          "Typologie urbain-rural",                 "Räumliche Typologien",                                   "Stadt/Land-Typologie",
   "deur",    "rtyp",             "Typologies territoriales",                         "Degré d'urbanisation (DEGURBA eurostat)",                 "Räumliche Typologien",                  "Urbanisierungsgrad (DEGURBA eurostat)",
   "qupg",    "inke",             "Entités infra-communales",                               "Quartiers (17 villes) et communes",             "Infrakommunale Einheiten",                    "Quartiere (17 Städte) und Gemeinden",
   "seen",    "topo",                          "Topographie",                                                            "Lacs",              "Topographische Elemente",                                                   "Seen",
   "flus",    "topo",                          "Topographie",                                                        "Rivières",              "Topographische Elemente",                                                 "Flüsse",
   "stkt",    "topo",                          "Topographie",                                           "Chefs-lieux de canton",              "Topographische Elemente",                         "Standorte der Kantonshauptorte"
  )

cat_codes <- categories$cat_code %>%
   unique()

#Define the names the ID and name columns can take
id_names <- c("ID0", "Primary_ID", "Primary.ID", "BEZIRKSNUM", "BEZIRKSNR", "GDENR", "ID_AMGR", "ID_AMRE", "VOGENR")
name_names <- c("ID1", "Secondary_", "NAME", "NAME2", "GDENAME", "NAME_AMGR", "NAME_AMRE", "VOGENAME")

# Function to get the parameters
read_metadata <- function(path) {
  stringr::str_match(path, r"((?:K|k)4_?(\w{4})_?(\w{8})(\w{2})(?:_ch(\d{4})(\D{4})?)?\.shp)") %>%
      tibble::as_tibble(.name_repair = "unique") %>%
      dplyr::rename(filename = 1,
                    code = 2,
                    date = 3,
                    geometrylevel = 4,
                    year = 5,
                    geometrytype = 6) %>%
      dplyr::mutate(path = path) %>%
      dplyr::select( -filename, -year)
}

read_sf <- function(path) {
   temp <- sf::read_sf(path) %>%
      sf::st_transform(crs = sf::st_crs(2056)) %>%
      dplyr::mutate_if(is.character, iconv, to = 'UTF-8')

   column_names <- colnames(temp)

   temp %>%
      dplyr::select(id = column_names[column_names %in% id_names],
                    name = column_names[column_names %in% name_names]) %>%
      dplyr::mutate(id = as.integer(id))
}

# Find all shapefiles
files <- fs::dir_ls(path = here::here("inst/extdata/"), type = "file", recurse = TRUE)
shapefiles <-  files[stringr::str_detect(files, r"{\.shp$}")]

# Read in the metadata and the shapefiles as sf data
shapefiles %>%
   purrr::map_df(read_metadata) %>%
   dplyr::mutate(map = purrr::map(.x = path, .f = read_sf)) -> map_table

# Clean up the map_table
map_table %>%
   dplyr::select(-path) %>%
   dplyr::mutate(date = ifelse(date == "yyyymmdd", NA_character_, date)) %>%
   dplyr::mutate(date = lubridate::ymd(date)) %>%
   dplyr::mutate(year = lubridate::year(date)) %>%
   dplyr::mutate(geometrylevel = ifelse(stringr::str_detect(geometrylevel, r"(\d{2})"),
                                        NA_character_, geometrylevel)) %>%
   dplyr::mutate(geometrylevel = ifelse(geometrylevel == "kk", NA_character_, geometrylevel)) %>%
   dplyr::mutate(geometrytype = ifelse(code == "flus", "Line", geometrytype)) %>%
   dplyr::mutate(geometrytype = ifelse(code == "voge", "Poly", geometrytype)) %>%
   dplyr::filter(code == "stkt" | geometrytype != "Pnts") %>%
   tidyr::replace_na(list("geometrylevel" = "gf")) %>%
   dplyr::left_join(categories, by = "code") -> clean_map_table

assign_data <- function(category) {
   clean_map_table %>%
      dplyr::filter(cat_code == category) %>%
      assign(category, ., envir = .GlobalEnv)
}

cat_codes %>%
   purrr::walk(assign_data)
