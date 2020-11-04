# INPUT: 
# 1. geoConcept: geological time concept, eg. Cambrian
# 2. prefix: optional, the prefix that need to be added
# 3. graph: optional, the graph user provided

# OUTPUT:
# the level of the geoConcept

gts.level = function(geoConcept, region = NULL, iscVersion = NULL, prefix = NULL, graph = NULL){
  # get gts.range of the geoConcept. The result's first two columns are schemeID and geoConcept with level
  r1 = gts.range(geoConcept = geoConcept, region = region, iscVersion = iscVersion, prefix = prefix, graph = graph)
  
  # get schemeID and geoConcept with level
  r1 = r1[,1:2]
  r1$level = sub(".* ", "", r1[,2])
  r1$geoConcpet = geoConcept
  
  return(r1)
}