# INPUT:
# 1. iscVersion: the version of the ISC, if NULL then return all versions; if "lastest" return the latest GSSP of the ISC.
# 2. map: if 1 then using leaflet to plot the map; if 2 then using 

# OUTPUT
# 1. Plot all the golden spikes on the map and displays the concept name.

# required pacakge: leaflet, htmltools, htmlwidgets

gssp.map = function (iscVersion = NULL, map = 1){
  
  res = gts.gssp(iscVersion = iscVersion)
  
  # title of the GSSP plot
  if(is.null(iscVersion)) isc = "GSSP"
  else isc = paste("GSSP of ", res[1,1])

  # GSSP names
  concept <- res[,2]
  # take out only the long and lat records from the sparql query results
  longlatdf <-res[,3:4]
  
  if(map == 1){
    tag.map.title <- tags$style(HTML("
  .leaflet-control.map-title { 
    transform: translate(-50%,20%);
    position: fixed !important;
    left: 50%;
    text-align: center;
    padding-left: 10px; 
    padding-right: 10px; 
    background: rgba(255,255,255,0.75);
    font-weight: bold;
    font-size: 28px;
    }
  "))
    
    title <- tags$div(
      tag.map.title, HTML(isc)
    )  
    
    leaflet() %>%
      addTiles() %>%
      addControl(title, position = "bottomleft") %>%
      addMarkers(lng = as.numeric( as.character(longlatdf[,1]) ), lat = as.numeric( as.character(longlatdf[,2])), popup = concept)
  }
  
  if(map == 2){
    wmap <- getMap(resolution = "low")
    plot(wmap, asp = 1, main = isc)
    points(longlatdf[,1], longlatdf[,2], col = "red", cex = .6)
  }
  
  if(is.null(iscVersion)){
    wmap <- getMap(resolution = "low")
    for(i in unique(res[,1])){
      plot(wmap, asp = 1, main = i)
      points(longlatdf[,1], longlatdf[,2], col = "red", cex = .6)
    }
  }
}
