rm(list=ls())

library('mregions')
library('sf')
library('leaflet')
library('leaflet.providers')
library(RColorBrewer)
library(htmlwidgets)


# res <- mr_layers()
# vapply(res, '[[', '', 'Name')

# MRegion Beger et al. -----------------------------------------------------------------
ecoregions_geoJSON <- mr_geojson(key = "Ecoregions:ecoregions", maxFeatures = 250)
# length(ecoregions_geoJSON$features)

ArcBeger <- ecoregions_geoJSON$features[c(1, 12, 16, 18, 41, 44, 45, 49, 59, 61,
                                          69, 72, 87, 91, 118, 119, 133, 134, 139,
                                          140, 152, 153, 155, 157, 174, 180, 190,
                                          192, 193, 195, 196, 197, 203, 204, 209,
                                          210, 215, 219, 225, 229)]

TempBeger <- ecoregions_geoJSON$features[c(4, 7, 13, 19, 23, 30, 34, 35, 40, 43,
                                           50, 51, 53, 57, 63, 64, 68, 70, 71, 73,
                                           74, 75, 76, 79, 84, 86, 93, 96, 98, 110,
                                           114, 116, 123, 124, 128, 135, 136, 137,
                                           138, 143, 145, 146, 147, 148, 149, 150,
                                           151, 154, 158, 159, 167, 170, 171, 176,
                                           183, 200, 202, 206, 207, 211, 213, 216,
                                           218, 223, 224, 226, 230, 232)]
  
SubTBeger <- ecoregions_geoJSON$features[c(2, 6, 8, 17, 31, 33, 36, 54, 78, 92,
                                           107, 112, 126, 144, 156, 160, 175, 178,
                                           179, 188, 194, 208, 222)]

TropBeger <- ecoregions_geoJSON$features[c(3, 5, 9, 10, 11, 14, 15, 20, 21, 22,
                                           24, 25, 26, 27, 28, 29, 32, 37, 38, 39,
                                           42, 46, 47, 48, 52, 55, 56, 58, 60, 62,
                                           65, 66, 67, 77, 80, 81, 82, 83, 85, 88,
                                           89, 90, 94, 95, 97, 99, 100, 101, 102,
                                           103, 104, 105, 106, 108, 109, 111, 113,
                                           115, 117, 120, 121, 122, 125, 127, 129,
                                           130, 131, 132, 141, 142, 161, 162, 163,
                                           164, 165, 166, 168, 169, 172, 173, 177,
                                           181, 182, 184, 185, 186, 187, 189, 198,
                                           199, 201, 205, 212, 214, 217, 220, 221,
                                           227, 228, 231)]

TropSub <- ecoregions_geoJSON$features[191]

leaflet(option=leafletOptions(zoomControl=FALSE)) %>%
  addProviderTiles(provider = "Esri.WorldGrayCanvas",
                   options = providerTileOptions(noWrap = TRUE)) %>%
  #addGraticule(interval = 30, sphere = T) %>%
  addGeoJSON(geojson = ArcBeger, color = "#8DA0CB", fillOpacity = 1)%>%
  addGeoJSON(geojson = TempBeger, color = "#66C2A5", fillOpacity = 1)%>%
  addGeoJSON(geojson = SubTBeger, color = "#FC8D62", fillOpacity = 1)%>%
  addGeoJSON(geojson = TropBeger, color = "#E78AC3", fillOpacity = 1)%>%
  addGeoJSON(geojson = TropSub, color = "#A6D854", fillOpacity = 1) %>%
  addLegend(
    position = "bottomleft",
    colors = c("#8DA0CB", "#66C2A5", "#FC8D62", "#E78AC3", "#A6D854"),
    labels = c("Polar", "Temperate", "Subtropical", "Tropical", "Tropical/Subtropical"),
    title = "Ecoregion",
    inline = TRUE,
    horizontal = TRUE,
    legendOptions = list(
      backgroundColor = "white",
      opacity = 1))


# with grey lon & lat lines
leaflet(option=leafletOptions(zoomControl=FALSE),
        # most common CRS for online maps, uses spherical mercator projection
        leafletCRS(crsClass = "L.CRS.EPSG3857")) %>%
  addProviderTiles(provider = "Esri.WorldGreyCanvas",
                   options = providerTileOptions(noWrap = TRUE)) %>%

  addGeoJSON(geojson = ArcBeger, color = "#8DA0CB", fillOpacity = 1)%>%
  addGeoJSON(geojson = TempBeger, color = "#66C2A5", fillOpacity = 1)%>%
  addGeoJSON(geojson = SubTBeger, color = "#FC8D62", fillOpacity = 1)%>%
  addGeoJSON(geojson = TropBeger, color = "#E78AC3", fillOpacity = 1)%>%
  addGeoJSON(geojson = TropSub, color = "#A6D854", fillOpacity = 1) %>%
  # longitude lines
  addPolylines(lng = c(-150, -150), lat = c(-180, 180), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(-120, -120), lat = c(-180, 180), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(-90, -90), lat = c(-180, 180), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(-60, -60), lat = c(-180, 180), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(-30, -30), lat = c(-180, 180), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(0, 0), lat = c(-180, 180), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(30, 30), lat = c(-180, 180), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(60, 60), lat = c(-180, 180), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(90, 90), lat = c(-180, 180), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(120, 120), lat = c(-180, 180), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(150,150), lat = c(-180, 180), color = "lightgrey", weight = 2) %>%
  # latitude lines
  addPolylines(lng = c(-180, 180), lat = c(-90, -90), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(-180, 180), lat = c(-60, -60), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(-180, 180), lat = c(-30, -30), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(-180, 180), lat = c(0, 0), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(-180, 180), lat = c(30, 30), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(-180, 180), lat = c(60, 60), color = "lightgrey", weight = 2) %>%
  addPolylines(lng = c(-180, 180), lat = c(90, 90), color = "lightgrey", weight = 2) #%>%
  # add legend at bottom of map, horizontally
  # addControl(
  #   html = '<div style="background-color: white; opacity: 1; padding: 10px; border-radius: 5px;">
  #           <table>
  #             <tr>
  #               <td><span style="background-color: #8DA0CB; width: 15px; height: 15px; display: inline-block; margin-right: 5px;"></span>ArcBeger</td>
  #               <td><span style="background-color: #66C2A5; width: 15px; height: 15px; display: inline-block; margin-right: 5px;"></span>TempBeger</td>
  #               <td><span style="background-color: #FC8D62; width: 15px; height: 15px; display: inline-block; margin-right: 5px;"></span>SubTBeger</td>
  #               <td><span style="background-color: #E78AC3; width: 15px; height: 15px; display: inline-block; margin-right: 5px;"></span>TropBeger</td>
  #               <td><span style="background-color: #A6D854; width: 15px; height: 15px; display: inline-block; margin-right: 5px;"></span>TropSub</td>
  #             </tr>
  #           </table>
  #         </div>',
  #   position = "bottomleft")

#does not work
#mapshot(m, file = paste0(getwd(), "/ecoregionsmap.png"),
#        remove_controls = c("homeButton", "layersControl"))


