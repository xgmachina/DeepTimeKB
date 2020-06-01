# INPUT: 
# 1. geotime1: geological time concept, eg. Cambrian
# 2. level1: the level of the geological time concept, eg. Period
# 3. geotime2: geological time concept, eg. Jurassic
# 4. level2: the level of the geological time concept, eg. Period
# 5. prefix: optional, the prefix that need to be added
# 6. graph: optional, the graph user provided

# OUTPUT:
# begin and end time of the geotime and its duration and all other properties.

gts.topo.global = function(geotime1, level1, geotime2, level2, prefix = NULL, graph = NULL){
  
  
  # set up end point
  endpoint = "http://virtuoso.nkn.uidaho.edu:8890/sparql/"
  
  # attach SPARQL querry prefix. Note: the graph for our study should be updated
  sparql_prefix = "
    prefix tssc: <http://deeptimekb.org/tssc#> 
    prefix tsnc: <http://deeptimekb.org/tsnc#> 
    prefix tswe: <http://deeptimekb.org/tswe#> 
    prefix tsbr: <http://deeptimekb.org/tsbr#>
    prefix tsba: <http://deeptimekb.org/tsba#> 
    prefix tsjp: <http://deeptimekb.org/tsjp#> 
    prefix tsau: <http://deeptimekb.org/tsau#>                   
    prefix tsnc: <http://deeptimekb.org/tsnc#> 
    prefix dc: <http://purl.org/dc/elements/1.1/> 
    prefix dcterms: <http://purl.org/dc/terms/> 
    prefix foaf: <http://xmlns.com/foaf/0.1/> 
    prefix geo: <http://www.opengis.net/ont/geosparql#> 
    prefix gts: <http://resource.geosciml.org/ontology/timescale/gts#> 
    prefix isc: <http://resource.geosciml.org/classifier/ics/ischart/> 
    prefix owl: <http://www.w3.org/2002/07/owl#> 
    prefix rank: <http://resource.geosciml.org/ontology/timescale/rank/> 
    prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
    prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
    prefix samfl: <http://def.seegrid.csiro.au/ontology/om/sam-lite#> 
    prefix sf: <http://www.opengis.net/ont/sf#> 
    prefix skos: <http://www.w3.org/2004/02/skos/core#> 
    prefix sosa: <http://www.w3.org/ns/sosa/> 
    prefix thors: <http://resource.geosciml.org/ontology/timescale/thors#> 
    prefix time: <http://www.w3.org/2006/time#> 
    prefix ts: <http://resource.geosciml.org/vocabulary/timescale/> 
    prefix vann: <http://purl.org/vocab/vann/> 
    prefix void: <http://rdfs.org/ns/void#> 
    prefix xkos: <http://rdf-vocabulary.ddialliance.org/xkos#> 
    prefix xsd: <http://www.w3.org/2001/XMLSchema#>
    
  "
  if (!is.null(prefix)){
    sparql_prefix = paste(prefix, sparql_prefix, sep = "/n")
  }
  
  # run the query
  q1 = paste0(sparql_prefix, '
       SELECT   ?begTimeValue ?endTimeValue
       WHERE
       {
       GRAPH <http://deeptimekb.org/iscallnew>
       {
       ?s rdfs:label "', geotime1, " ", level1, '"@en;
       time:hasBeginning ?beg ;
       time:hasEnd ?end .
       ?beg time:inTemporalPosition ?begTime .
       ?end time:inTemporalPosition ?endTime .
       ?begTime time:numericPosition ?begTimeValue .
       ?endTime time:numericPosition ?endTimeValue .
       }
       }')
  res1 = SPARQL(endpoint, q1)$results
  
  # run the query
  q2 = paste0(sparql_prefix, '
       SELECT   ?begTimeValue ?endTimeValue
       WHERE
       {
       GRAPH <http://deeptimekb.org/iscallnew>
       {
       ?s rdfs:label "', geotime2, " ", level2, '"@en;
       time:hasBeginning ?beg ;
       time:hasEnd ?end .
       ?beg time:inTemporalPosition ?begTime .
       ?end time:inTemporalPosition ?endTime .
       ?begTime time:numericPosition ?begTimeValue .
       ?endTime time:numericPosition ?endTimeValue .
       }
       }')
  res2 = SPARQL(endpoint, q2)$results
  
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
  cat(geotime1)
  cat("  ")
  cat(topo)
  cat("  ")
  cat(geotime2)
  cat("\n")
  return(topo)
}
