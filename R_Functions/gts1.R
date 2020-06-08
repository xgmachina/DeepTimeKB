# INPUT: 
# 1. geoConcept: geological time concept, eg. Cambrian
# 2. prefix: optional, the prefix that need to be added
# 3. graph: optional, the graph user provided

# OUTPUT:
# begin and end time of the geotime and its duration.

gts1 = function(geoConcept, prefix = NULL, graph = NULL){
  
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
  if(!is.null(graph)){
    q = paste0(
      sparql_prefix, 
      '
                   SELECT   DISTINCT ?begTimeValue ?endTimeValue
                   WHERE
                   {', graph, '
                     {
                             {
                             ?tconcept  a gts:GeochronologicEra ;  
                                             rdfs:label ?label .
                             FILTER (lang(?label) = "en")
                             FILTER strstarts(?label, "', geoConcept, '").
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
                             FILTER strstarts(?label, "', geoConcept, '").
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
  }else{
  q = paste0(
              sparql_prefix, 
                  '
                   SELECT   DISTINCT ?begTimeValue ?endTimeValue
                   WHERE
                   {
                     GRAPH <http://deeptimekb.org/iscallnew> 
                     {
                             {
                             ?tconcept  a gts:GeochronologicEra ;  
                                             rdfs:label ?label .
                             FILTER (lang(?label) = "en")
                             FILTER strstarts(?label, "', geoConcept, '").
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
                             FILTER strstarts(?label, "', geoConcept, '").
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
  }
  res = SPARQL(endpoint, q)$results
  
  # display the SPARQL query
  #cat("*****************************************\n")
  #cat("#### Running the following query #####\n")
  #cat("*****************************************\n")
  #cat(q)
  #cat("\n*****************************************\n")
  
  # calculate the druation
  res$duration = abs(res[[1]]-res[[2]])
  
  #cat("#### RESULT ####\n")
  return(res)
}
