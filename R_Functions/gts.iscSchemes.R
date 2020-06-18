# INPUT: 
# 1. id: all or latest
# 2. prefix: optional, the prefix that need to be added
# 3. graph: optional, the graph user provided
# This function is built up on gts.listRegion

# OUTPUT:
# If id is all, return all isc scheme IDs. If id is latest, return the latest isc Scheme ID

gts.iscSchemes = function(id, prefix = NULL, graph = NULL, URI = TRUE){
  
  # find all regions and version
  res = gts.listRegion(prefix = prefix, graph = graph)
  
  # filter out isc
  res = res[grepl("isc", res[,1], fixed=T),1]
  if(id == "latest") res = res[1]
  
  if(URI == FALSE) res = substr(res, 52, 61)
  
  return(res)
}