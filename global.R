# global.R
## Developed to display Gulf of Mexico EFH
## Data source: http://sero.nmfs.noaa.gov/
## mxd's for map services here: X:\Data_John\shiny\git\EFHHabitatMap\mxd
#

library(shiny)
library(shinydashboard)
library(sp)
library(leaflet)
library(mapview)
library(dplyr)
library(sf)
library(htmltools)
library(leaflet.extras)
library(shinyBS)
library(rgdal)
#EXTENT <- extent(c(-100.42, -69.59, 20.82, 32.57))
enableBookmarking(store = "url")

df <- read.csv("df.csv", stringsAsFactors = FALSE) ##beware strings as factor =FALSE critical here

############################ Mouse Coordinates ######################
############## mouse coordinates
addMouseCoordinates2 <- function (map, style = c("detailed", "basic"), epsg = NULL, proj4string = NULL, 
                                  native.crs = FALSE) 
{
  style <- style[1]
  if (inherits(map, "mapview")) 
    map <- mapview2leaflet(map)
  stopifnot(inherits(map, "leaflet"))
  if (style == "detailed" && !native.crs) {
    txt_detailed <- paste0("\n      ' x: ' + L.CRS.EPSG3857.project(e.latlng).x.toFixed(0) +\n      ' | y: ' + L.CRS.EPSG3857.project(e.latlng).y.toFixed(0) +\n      ' | epsg: 3857 ' +\n      ' | proj4: +proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs ' +\n      ' | lon: ' + (e.latlng.lng).toFixed(5) +\n      ' | lat: ' + (e.latlng.lat).toFixed(5) +\n      ' | zoom: ' + map.getZoom() + ' '")
  }
  else {
    txt_detailed <- paste0("\n      ' x: ' + (e.latlng.lng).toFixed(2) +\n      ' | y: ' + (e.latlng.lat).toFixed(2) +\n      ' | epsg: ", 
                           epsg, " ' +\n      ' | proj4: ", proj4string, " ' +\n       + map.getZoom() + ' '")
  }
  txt_basic <- paste0("\n    ' Longitude: ' + (e.latlng.lng).toFixed(2) +\n    ' | Latitude: ' + (e.latlng.lat).toFixed(1) +\n      + ' '")
  txt <- switch(style, detailed = txt_detailed, basic = txt_basic)
  map <- htmlwidgets::onRender(map, paste0("\nfunction(el, x, data) {\n\n  // get the leaflet map\n  var map = this; //HTMLWidgets.find('#' + el.id);\n\n  // we need a new div element because we have to handle\n  // the mouseover output separately\n  // debugger;\n  function addElement () {\n    // generate new div Element\n    var newDiv = $(document.createElement('div'));\n    // append at end of leaflet htmlwidget container\n    $(el).append(newDiv);\n    //provide ID and style\n    newDiv.addClass('lnlt');\n    newDiv.css({\n      'position': 'relative',\n      'bottomleft':  '10px',\n      'background-color': 'rgba(255, 255, 255, 1)',\n      'box-shadow': '0 0 50px #bbb',\n      'background-clip': 'padding-box',\n      'margin': '10',\n      'padding-left': '5px',\n      'color': '#333',\n      'font': '14px/1.5 \"Helvetica Neue\", Arial, Helvetica, sans-serif',\n    });\n    return newDiv;\n  }\n\n  // check for already existing lnlt class to not duplicate\n  var lnlt = $(el).find('.lnlt');\n  if(!lnlt.length) {\n    lnlt = addElement();\n\n    // grab the special div we generated in the beginning\n    // and put the mousmove output there\n    map.on('mousemove', function (e) {\n      lnlt.text(", 
                                           txt, ");\n    })\n  };\n}\n"))
  map
}

########################## Load data for point in polygon ###########
load("EFH.RData")
EFHout <- data.frame(FMP=c("Coastal Migratory Pelagics",
                           "Coral",
                           "Red drum",
                           "Reef fish",
                           "Shrimp",
                           "Spiny lobster"))#, EFH=rep(" " ,6), Lat=rep(" ",6), Long=rep(" ",6))


######### Create an sp object descrbing extent

coords <- matrix(c(-99, 32,
                   -99, 23,
                   -80, 23,
                   -80, 32,
                   -99, 32), 
                 ncol = 2, byrow = TRUE)
P1 <- Polygon(coords)
Ps1 <- SpatialPolygons(list(Polygons(list(P1), ID = "a")),
                       proj4string=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
Ps2SF <- st_as_sfc(Ps1)

##### 