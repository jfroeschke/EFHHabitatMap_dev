## Download EFH from NMFS SERO

## Set working directory: may need to update for different user
setwd("X:/Data_John/shiny/git/EFHHabitatMap/zips")
WD <- getwd()
## Get URL's
redDrum <- "http://sero.nmfs.noaa.gov/maps_gis_data/habitat_conservation/efh_gom/geodata/red_drum_efh_gom.zip"
download.file(redDrum, WD)
