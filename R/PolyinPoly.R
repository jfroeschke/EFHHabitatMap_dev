## Jfroeschke 09-26-2017

###logic flow
# 0) Load the EFH data as sf objects via RData file
# 1) Create polygon from coordinates (matrix)
# 2) Convert to sp object (Polygon --> SpatialPolygons)
# 3) Assign projection: proj4string=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
# 4) Convert to sf object using st_as_sfc (problem assiging projection this way
# 5) Test for intersection using st_intersection
# 6) Polygons to test for intersection are the EFH files (sf objects)
# 7) Convert oject from intersection test to data.frame, if > 0 rows then intersection is true
# 8) Apply output of 7 to dataframe for table in reactive
##############Shiny APP
# 1s) Will need to create polygon in the reative from the output of the draw tool
# 2s-8s) same as above but in reactive.  

## Code below illustrates example for true and false intersection


## 0) Load EFH Data
setwd("X:/Data_John/shiny/git/EFHHabitatMap")
load("EFH.RData")

## load required libraries
library(sf)
library(tidyverse)
library(leaflet)
library(sp)

## 1) Positive sample first: Create polygon in sample
## This is just a box that overlaps coral EFH that I'm using as a demo
## Note: there are 5 coordinate pairs for a rectangle, first and last are the same
## This is required to close the polygon
## Polygons with holes are possible but not included here
coords <- matrix(c(-83.35, 27,
                  -83.35, 19.74557,
                  -78.83157, 19.74557,
                  -78.83157, 27,
                  -83.35, 27), 
                ncol = 2, byrow = TRUE)

## 2-3) Convert to Spatial Polygons object and assign projection
## Critical that projection matches objects to be tested against
## This is worth testing before doing this.  
P1 <- Polygon(coords)
Ps1 <- SpatialPolygons(list(Polygons(list(P1), ID = "a")),
                      proj4string=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
#plot(Ps1, axes = TRUE) # Could use to check the resulting plot

## 4) Convert to sf object
## This is the wonky part of the code: I was unable to assign a projection to 
## sf polygon object, could be state of package development or operator error
## At any rate, this seems to work by convert the sp object to an sf object
## In theory sp objects could be used but this will die at some point and the sf
# objects are much smaller/faster in interactive use).

Ps2SF <- st_as_sfc(Ps1)

## 5-6) Test for intersection:
IntersectionOut <-  st_intersection(Ps2SF, Coral)

## 7) Convert IntersectionOut object to dataframe for simple testing
df <- as.data.frame(IntersectionOut)

## 8) ## export this result to output in shiny
dfNROW <- nrow(df) ##if nrow > 0 then positive intersection
dfNROW
## 5-8 will iterate over each EFH layer

### Bonus plot basemap, Coral EFH and Polygon
leaflet() %>%
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
           options = providerTileOptions(noWrap = TRUE)) %>%
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
           options = providerTileOptions(noWrap = TRUE)) %>%
  addPolygons(data=Coral, color="red") %>% 
  addPolygons(data=Ps2SF, color='green') 
###############End True Example

############## Begin False Example
## 0) Load EFH Data
setwd("X:/Data_John/shiny/git/EFHHabitatMap")
load("EFH.RData")

## load required libraries
library(sf)
library(tidyverse)
library(leaflet)
library(sp)

## 1) Positive sample first: Create polygon in sample
## This is just a box that overlaps coral EFH that I'm using as a demo
## Note: there are 5 coordinate pairs for a rectangle, first and last are the same
## This is required to close the polygon
## Polygons with holes are possible but not included here
coords <- matrix(c(-83.35, 21,
                   -83.35, 19.74557,
                   -78.83157, 19.74557,
                   -78.83157, 21,
                   -83.35, 21), 
                 ncol = 2, byrow = TRUE)

## 2-3) Convert to Spatial Polygons object and assign projection
## Critical that projection matches objects to be tested against
## This is worth testing before doing this.  
P1 <- Polygon(coords)
Ps1 <- SpatialPolygons(list(Polygons(list(P1), ID = "a")),
                       proj4string=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
#plot(Ps1, axes = TRUE) # Could use to check the resulting plot

## 4) Convert to sf object
## This is the wonky part of the code: I was unable to assign a projection to 
## sf polygon object, could be state of package development or operator error
## At any rate, this seems to work by convert the sp object to an sf object
## In theory sp objects could be used but this will die at some point and the sf
# objects are much smaller/faster in interactive use).

Ps2SF <- st_as_sfc(Ps1)

## 5-6) Test for intersection:
IntersectionOut <-  st_intersection(Ps2SF, Coral)

## 7) Convert IntersectionOut object to dataframe for simple testing
df <- as.data.frame(IntersectionOut)

## 8) ## export this result to output in shiny
dfNROW <- nrow(df) ##if nrow > 0 then positive intersection
dfNROW
## 5-8 will iterate over each EFH layer

### Bonus plot basemap, Coral EFH and Polygon
leaflet() %>%
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
           options = providerTileOptions(noWrap = TRUE)) %>%
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
           options = providerTileOptions(noWrap = TRUE)) %>%
  addPolygons(data=Coral, color="red") %>% 
  addPolygons(data=Ps2SF, color='yellow') 
###############End False Example

