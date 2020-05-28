# INPUT: 
# 1. geotime: geological time concept, eg. Cambrian
# 2. level: the level of the geological time concept, eg. Period
# 3. prefix: optional, the prefix that need to be added
# 4. graph: optional, the graph user provided

# OUTPUT:
# begin and end time of the geotime and its duration.

gts1 = function(geotime, level, prefix = NULL, graph = NULL){
  
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
  q = paste0(sparql_prefix, '
       SELECT   ?begTimeValue ?endTimeValue
       WHERE
       {
       GRAPH <http://deeptimekb.org/tswebrbajpau> 
       {
       ?s rdfs:label "', geotime, " ", level, '"@en;
       time:hasBeginning ?beg ;
       time:hasEnd ?end .
       ?beg time:inTemporalPosition ?begTime .
       ?end time:inTemporalPosition ?endTime .
       ?begTime time:numericPosition ?begTimeValue .
       ?endTime time:numericPosition ?endTimeValue .
       }
       }')
  res = SPARQL(endpoint, q)$results
  
  # display the SPARQL query
  cat("*****************************************\n")
  cat("#### Running the following query #####\n")
  cat("*****************************************\n")
  cat(q)
  cat("\n*****************************************\n")
  
  # calculate the druation
  res$duration = abs(res[[1]]-res[[2]])
  
  cat("#### RESULT ####\n")
  return(res)
}
