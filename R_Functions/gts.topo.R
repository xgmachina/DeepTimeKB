# INPUT: 
# 1. geoConcept1: geological time concept, eg. Cambrian
# 2. geoConcept2: geological time concept, eg. Jurassic
# 3. region1: region for geoConcept1
# 4. iscVersion1: the version of geoConcept1
# 5. region2: region for geoConcept2 
# 6. iscVersion2: the version of geoConcept1
# 7. prefix: optional, the prefix that need to be added
# 8. graph: optional, the graph user provided

# OUTPUT:
# begin and end time of the geotime and its duration and all other properties.

gts.topo = function(geoConcept1, geoConcept2, 
                    region1 = NULL, iscVersion1 = NULL, 
                    region2 = NULL, iscVersion2 = NULL, 
                    prefix = NULL, graph = NULL){
 
  res1 = gts.range(geoConcept1, region = region1, iscVersion = iscVersion1, prefix = prefix, graph = graph)
  res2 = gts.range(geoConcept2, region = region2, iscVersion = iscVersion2, prefix = prefix, graph = graph)
  
  if(nrow(res1)>1) stop("Please specify region and/or iscVersion of geoConcept1 to make sure gts.range(geoConcept1) has one retured result")
  if(nrow(res2)>1) stop("Please specify region and/or iscVersion of geoConcept2 to make sure gts.range(geoConcept2) has one retured result")
  
  if(res1[1]>res2[1]){
    if(res1[2]>res2[1]) topo="time:intervalBefore"
    if(res1[2]==res2[1]) topo="time:intervalMeets"
    if(res1[2]<res2[1]){
      if(res1[2]>res2[2]) topo="time:intervalOverlaps"
      if(res1[2]==res2[2]) topo="time:intervalFinishedBy"
      if(res1[2]<res2[2]) topo="time:intervalContains"
    }
  }
  if(res1[1]==res2[1]){
    if(res1[2]>res2[2]) topo="time:intervalStarts"
    if(res1[2]==res2[2]) topo="time:intervalEquals"
    if(res1[2]<res2[2]) topo="time:intervalStartedBy"
  }
  if(res1[1]<res2[1]){
    if(res1[1]>res2[2]){
      if(res1[2]>res2[2]) topo="time:intervalDuring"
      if(res1[2]==res2[2]) topo="time:intervalFinishes"
      if(res1[2]<res2[2]) topo="time:intervalOverlappedBy"
    }
    if(res1[1]==res2[2]) topo="time:intervalMetBy"
    if(res1[1]<res2[2]) topo="time:intervalAfter"
  }
  
  cat("#### RESULT ####\n")
  cat(geoConcept1)
  cat("  ")
  cat(topo)
  cat("  ")
  cat(geoConcept2)
  cat("\n")
  return(topo)
}
