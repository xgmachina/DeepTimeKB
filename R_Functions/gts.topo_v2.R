# INPUT: 
# 1. geoConcept1: geological time concept, eg. Cambrian
# 2. geoConcept2: geological time concept, eg. Jurassic
# 3. prefix: optional, the prefix that need to be added
# 4. graph: optional, the graph user provided

# OUTPUT:
# begin and end time of the geotime and its duration and all other properties.

gts.topo = function(geoConcept1, geoConcept2, prefix = NULL, graph = NULL){
  
  
  # set up end point
  endpoint = "http://virtuoso.nkn.uidaho.edu:8890/sparql/"
  
  # attach SPARQL querry prefix. Note: the graph for our study should be updated
  sparql_prefix = " 
                prefix dc: <http://purl.org/dc/elements/1.1/>
                prefix gts: <http://resource.geosciml.org/ontology/timescale/gts#>
                prefix skos: <http://www.w3.org/2004/02/skos/core#>
                prefix time: <http://www.w3.org/2006/time#>
                prefix ts: <http://resource.geosciml.org/vocabulary/timescale/> 
                prefix isc: <http://resource.geosciml.org/classifier/ics/ischart/> 
        "
  
  if (!is.null(prefix)){
    sparql_prefix = paste(prefix, sparql_prefix, sep = "/n")
  }
  
  # run the query
  q1 = paste0(
    sparql_prefix, 
    '
                   SELECT   ?begTimeValue ?endTimeValue
                   WHERE
                   {
                     GRAPH <http://deeptimekb.org/iscallnew> 
                     {
                             {
                             ?tconcept  a gts:GeochronologicEra ;  
                                             rdfs:label ?label .
                             FILTER (lang(?label) = "en")
                             FILTER strstarts(?label, "', geoConcept1, '").
                             ?tconcept time:hasBeginning ?beg ;
                             time:hasEnd ?end .
                             ?beg time:inTemporalPosition ?begTime .
                             ?end time:inTemporalPosition ?endTime .
                             ?begTime time:numericPosition ?begTimeValue .
                             ?endTime time:numericPosition ?endTimeValue .
                             }
                       UNION
                             {
                             ?tconcept a gts:GeochronologicEra ;  
                                       rdfs:label ?label .
                             FILTER (lang(?label) = "en")
                             FILTER strstarts(?label, "', geoConcept1, '").
                             ?tconcept dc:description
                             [time:hasBeginning ?beg ;
                              time:hasEnd ?end ;
                              skos:inScheme  ts:isc2012-08].
                              ?beg time:inTemporalPosition ?begTime .
                              ?end time:inTemporalPosition ?endTime .
                              ?begTime dc:description
                              [time:numericPosition ?begTimeValue ;
                              skos:inScheme  ts:isc2012-08].
                              ?endTime dc:description
                              [time:numericPosition ?endTimeValue ;
                              skos:inScheme  ts:isc2012-08].
                             }
                     }
                   }
                  '
  )
  res1 = SPARQL(endpoint, q1)$results
  
  # run the query
  q2 = paste0(
    sparql_prefix, 
    '
                   SELECT   ?begTimeValue ?endTimeValue
                   WHERE
                   {
                     GRAPH <http://deeptimekb.org/iscallnew> 
                     {
                             {
                             ?tconcept  a gts:GeochronologicEra ;  
                                             rdfs:label ?label .
                             FILTER (lang(?label) = "en")
                             FILTER strstarts(?label, "', geoConcept2, '").
                             ?tconcept time:hasBeginning ?beg ;
                             time:hasEnd ?end .
                             ?beg time:inTemporalPosition ?begTime .
                             ?end time:inTemporalPosition ?endTime .
                             ?begTime time:numericPosition ?begTimeValue .
                             ?endTime time:numericPosition ?endTimeValue .
                             }
                       UNION
                             {
                             ?tconcept a gts:GeochronologicEra ;  
                                       rdfs:label ?label .
                             FILTER (lang(?label) = "en")
                             FILTER strstarts(?label, "', geoConcept2, '").
                             ?tconcept dc:description
                             [time:hasBeginning ?beg ;
                              time:hasEnd ?end ;
                              skos:inScheme  ts:isc2012-08].
                              ?beg time:inTemporalPosition ?begTime .
                              ?end time:inTemporalPosition ?endTime .
                              ?begTime dc:description
                              [time:numericPosition ?begTimeValue ;
                              skos:inScheme  ts:isc2012-08].
                              ?endTime dc:description
                              [time:numericPosition ?endTimeValue ;
                              skos:inScheme  ts:isc2012-08].
                             }
                     }
                   }
                  '
  )
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
  cat(geoConcept1)
  cat("  ")
  cat(topo)
  cat("  ")
  cat(geoConcept2)
  cat("\n")
  return(topo)
}
