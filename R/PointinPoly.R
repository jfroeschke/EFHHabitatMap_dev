##load shapes using sf:
library(sf)
library(leaflet)

##Test the ability to import all shapefiles

CMP <- st_read("X:/Data_John/shiny/git/EFHHabitatMap/shps/CoastalMigratoryPelagics/CoastalMigratatoryPelagicEFHWGS.shp")
Coral <- st_read("X:/Data_John/shiny/git/EFHHabitatMap/shps/Coral/CoralEFHWGS2Dissolve.shp")
RedDrum <- st_read("X:/Data_John/shiny/git/EFHHabitatMap/shps/RedDrum/RedDrumWGS.shp")
ReefFish <- st_read("X:/Data_John/shiny/git/EFHHabitatMap/shps/ReefFish/ReefFishEFHWGS.shp")
Shrimp <- st_read("X:/Data_John/shiny/git/EFHHabitatMap/shps/Shrimp/ShrimpEFHWGSDissolve.shp")
SpinyLobster <- st_read("X:/Data_John/shiny/git/EFHHabitatMap/shps/SpinyLobster/SpinyLobsterEFHWGSDissolve.shp")
setwd("X:/Data_John/shiny/git/EFHHabitatMap")
save.image("EFH.RData")

setwd("X:/Data_John/shiny/git/EFHHabitatMap")
load("EFH.RData")

##Below will be used as the skeleton of a reative in server.R


## Test for point in and point out
point <- c(-82.55, 27.80)
pointout <- c(-90.25, 26)
x <- st_point(point)
xout <- st_point(pointout)
x2 <- st_intersects(x, SpinyLobster, sparse=FALSE)
x3 <- st_intersects(x, ReefFish, sparse=FALSE)

x2out <- st_intersects(xout, , sparse=FALSE)

y<- x2out[x2out==TRUE]


########

leaflet() %>%
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
           options = providerTileOptions(noWrap = TRUE)) %>%
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
           options = providerTileOptions(noWrap = TRUE)) %>%
  
  addTiles("http://portal.gulfcouncil.org/arcgis/rest/services/ReefEFH/MapServer/tile/{z}/{y}/{x}")
  
  #setView(-81.41, 26.15, zoom = 8) %>% 
  addPolygons(data=CMP, stroke=FALSE, smoothFactor=0.2, fillOpacity=1.0,
              color="yellow") 

%>% 
  addPolygons(data=lobsout, stroke=FALSE, smoothFactor=0.2, fillOpacity=1.0,
              color="red")