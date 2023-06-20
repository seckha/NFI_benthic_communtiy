rm(list=ls())

library('mregions')
library('sf')
library('leaflet')
library('leaflet.providers')
library(RColorBrewer)


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

MapLon <- c(-175, -175, -175, -175, -175, -175, -175, -175, -175)
MapLat <- c(-80, -60, -40, -20, 0, 20, 40, 60, 80)
CoorLat <- c("80\u00B0S", "60\u00B0S", "40\u00B0S", "20\u00B0S", "0\u00B0", "20\u00B0N", "40\u00B0N", "60\u00B0N", "80\u00B0N")

EqLon <- c(-180, 180)
EqLat <- c(0, 0)

#LabelLon <- c(64.4)
#LabelLat <- c(-22.19)
#Location <- c("Iceland")
LocDat <- read.csv(file = 'MapDataLongLat.csv')
head(LocDat)

LocPop <- c(LocDat$ecoregion, LocDat$country, LocDat$location)

#vectorLabel <- data.frame(Location, LabelLon, LabelLat)

brewer.pal(n=5, "Set2")

?addGeoJSON

leaflet(option=leafletOptions(zoomControl=FALSE)) %>%
# Can't figure out how this line of code actually work, if you use other format of maps it would cause all the
# regions to shift all over the place, so leave it suppressed for now.
  # leaflet(option=leafletOptions(zoomControl=FALSE, crs = leafletCRS(crsClass = "L.CRS.EPSG4326"))) %>%
  #addGraticule(interval = 20, sphere = FALSE) %>% # black longitude and latitude lines
  #addPolylines(lng = EqLon, lat = EqLat, color = "#C70039") %>% # equator line
  # This line of code would change the style of the map (aesthetically)
  # addProviderTiles("Thunderforest.SpinalMap") %>%
  addProviderTiles(provider = "Esri.WorldGrayCanvas",
                   options = providerTileOptions(noWrap = TRUE)) %>%
  addGeoJSON(geojson = ArcBeger, color = "#8DA0CB", fillOpacity = 1)%>%
  addGeoJSON(geojson = TempBeger, color = "#66C2A5", fillOpacity = 1)%>% # #3368FF
  addGeoJSON(geojson = SubTBeger, color = "#FC8D62", fillOpacity = 1)%>%
  addGeoJSON(geojson = TropBeger, color = "#E78AC3", fillOpacity = 1)%>%
  addGeoJSON(geojson = TropSub, color = "#A6D854", fillOpacity = 1) #%>%
  #addLabelOnlyMarkers(lng = MapLon, lat = MapLat, label = CoorLat,
  #                    labelOptions = labelOptions(noHide = T, direction = 'top', textOnly = T))%>%
  # Suppress this following line if you don't want the bubbles, also remove the %>% from the previous line
  #addMarkers(data = LocDat, LocDat$long, LocDat$lat, popup = paste("Ecoregion: ", LocDat$ecoregion, "<br>",
  #                                                                  "Country: ", LocDat$country, "<br>",
  #                                                                  "Location: ", LocDat$location, "<br>",
  #                                                                 "Longitude: ", LocDat$longDir, "<br>",
  #                                                                 "Latitude: ", LocDat$latDir, "<br>"))





leaflet(option=leafletOptions(zoomControl=FALSE)) %>%
  addProviderTiles(provider = "Esri.WorldGrayCanvas",
                   options = providerTileOptions(noWrap = TRUE)) %>%
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

leaflet(option=leafletOptions(zoomControl=FALSE)) %>%
  addProviderTiles(provider = "Esri.WorldGrayCanvas",
                   options = providerTileOptions(noWrap = TRUE)) %>%
  addGeoJSON(geojson = ArcBeger, color = "#8DA0CB", fillOpacity = 1)%>%
  addGeoJSON(geojson = TempBeger, color = "#66C2A5", fillOpacity = 1)%>%
  addGeoJSON(geojson = SubTBeger, color = "#FC8D62", fillOpacity = 1)%>%
  addGeoJSON(geojson = TropBeger, color = "#E78AC3", fillOpacity = 1)%>%
  addGeoJSON(geojson = TropSub, color = "#A6D854", fillOpacity = 1) %>%
  addControl(
    html = '<div style="background-color: white; opacity: 1; padding: 10px; border-radius: 5px;">
            <table>
              <tr>
                <td><span style="background-color: #8DA0CB; width: 15px; height: 15px; display: inline-block; margin-right: 5px;"></span>ArcBeger</td>
                <td><span style="background-color: #66C2A5; width: 15px; height: 15px; display: inline-block; margin-right: 5px;"></span>TempBeger</td>
                <td><span style="background-color: #FC8D62; width: 15px; height: 15px; display: inline-block; margin-right: 5px;"></span>SubTBeger</td>
                <td><span style="background-color: #E78AC3; width: 15px; height: 15px; display: inline-block; margin-right: 5px;"></span>TropBeger</td>
                <td><span style="background-color: #A6D854; width: 15px; height: 15px; display: inline-block; margin-right: 5px;"></span>TropSub</td>
              </tr>
            </table>
          </div>',
    position = "bottomleft"
  )
)


