##Simple script to test the layers
library(leaflet)
map <- leaflet() %>% 
     setView(-85, 27, zoom=6) %>% 
     addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
              options = providerTileOptions(noWrap = TRUE)) %>%
     addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
              options = providerTileOptions(noWrap = TRUE)) %>%
     addTiles("http://portal.gulfcouncil.org/arcgis/rest/services/CMPEFH/MapServer/tile/{z}/{y}/{x}") %>%
     addTiles("http://portal.gulfcouncil.org/arcgis/rest/services/ReefEFH/MapServer/tile/{z}/{y}/{x}") %>%
     
     addTiles("http://portal.gulfcouncil.org/arcgis/rest/services/RedDrumEFH/MapServer/tile/{z}/{y}/{x}") %>% 
     addTiles("http://portal.gulfcouncil.org/arcgis/rest/services/Lobster/MapServer/tile/{z}/{y}/{x}") %>% 
     addTiles("http://portal.gulfcouncil.org/arcgis/rest/services/ShrimpEFH2/MapServer/tile/{z}/{y}/{x}") %>% 
     addTiles("http://portal.gulfcouncil.org/arcgis/rest/services/CoralEFH/MapServer/tile/{z}/{y}/{x}")
map

##HABITAT TYPE
map <- leaflet() %>% 
     setView(-85, 27, zoom=6) %>% 
     addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
              options = providerTileOptions(noWrap = TRUE)) %>%
     addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
              options = providerTileOptions(noWrap = TRUE)) %>%
addTiles("http://portal.gulfcouncil.org/arcgis/rest/services/mangrove2/MapServer/tile/{z}/{y}/{x}") %>% 
     addTiles("http://portal.gulfcouncil.org/arcgis/rest/services/seagrass/MapServer/tile/{z}/{y}/{x}")
map