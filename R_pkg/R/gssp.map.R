# INPUT:
# 1. iscVersion: the version of the ISC, if NULL then return all versions; if "lastest" return the latest GSSP of the ISC.


# OUTPUT
# 1. Plot all the golden spikes on the map and displays the concept name.

gssp.map = function (iscVersion = NULL){
  
  # get the gssp
  res = gts.gssp(iscVersion = iscVersion) 
  
  # title of the GSSP plot
  if(is.null(iscVersion)) {
    isc = "GSSP"
  } else {
    isc = paste("GSSP of ", res[1,1])
  }
  
  # GSSP names
  concept <- res[,2]
  # take out only the long and lat records from the sparql query results
  longlatdf <-res[,3:4]
  
  
  wmap <- getMap(resolution = "low")
  plot(wmap, asp = 1, main = isc)
  points(longlatdf[,1], longlatdf[,2], col = "red", cex = .6)
  
  if(is.null(iscVersion)){
    wmap <- getMap(resolution = "low")
    for(i in unique(res[,1])){
      plot(wmap, asp = 1, main = i)
      points(longlatdf[,1], longlatdf[,2], col = "red", cex = .6)
    }
  }
}
