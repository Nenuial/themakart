library(magrittr)
library(raster)

raster("inst/extdata/SWISS_RELIEF/relief_resampled.tif") %>%
  raster::projectRaster(crs = "+proj=somerc +lat_0=46.95240555555556 +lon_0=7.439583333333333 +k_0=1 +x_0=2600000 +y_0=1200000 +ellps=bessel +towgs84=674.374,15.056,405.346,0,0,0,0 +units=m +no_defs") %>%
  as("SpatialPixelsDataFrame") %>%
  as.data.frame() %>%
  dplyr::rename(value = `relief_resampled`) -> relief
