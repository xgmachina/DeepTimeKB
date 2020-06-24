# INPUT: 
# 1. time: geological time, e.g. 50, the unit is Ma.
# 2. prefix: optional, the prefix that need to be added
# 3. graph: optional, the graph user provided

# OUTPUT:
# All the geoConcept that contain the input time.

gts.point = function(time, prefix = NULL, graph = NULL){
  
  if(is.null(graph)){
    graph = "GRAPH <http://deeptimekb.org/iscallnew>"
  }
  
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

  
  q = paste(sparql_prefix, 
            '
              SELECT ?schemeID str(?label) AS ?geoConcept  ?begTimeNum ?endTimeNum (?begTimeNum - ?endTimeNum) AS ?duration
              WHERE
              {
                ', graph, '
                 {
                 {
                 ?geoConcept rdfs:label ?label ;
                    dc:description
                    [
                    time:hasBeginning ?beg ;
                    time:hasEnd ?end 
                    ] .
                 ?beg time:inTemporalPosition ?begTime .
                 ?end time:inTemporalPosition ?endTime .
              
                 ?begTime dc:description
                    [
                    time:numericPosition ?begTimeNum ;
                    skos:inScheme ?schemeID 
                    ] .
                 ?endTime dc:description
                    [
                    time:numericPosition ?endTimeNum ;
                    skos:inScheme ?schemeID 
                    ] .
                  FILTER (?endTimeNum <= ', time, ')
                  FILTER (?begTimeNum >= ', time, ')
                  }
                  UNION
                  {
                   ?geoConcept  rdfs:label ?label ;
                                time:hasBeginning ?beg ;
                                time:hasEnd ?end ;
                                skos:inScheme ?schemeID .
                   ?beg time:inTemporalPosition ?begTime .
                   ?end time:inTemporalPosition ?endTime .
                   ?begTime time:numericPosition ?begTimeNum .
                   ?endTime time:numericPosition ?endTimeNum .
                   FILTER (?endTimeNum <= ', time, ')
                   FILTER (?begTimeNum >= ', time, ')
                  }
                  }
              }
              
              
              ORDER BY ?schemeID (?begTimeNum-?endTimeNum)
            '
)
  # run the query
  res = SPARQL(endpoint, q)$results
  
  # select only the name of the schemeID
  res[,1] = sub(".*/", "", res[,1])
  res[,1] = substr(res[,1], 1, nchar(res[,1])-1)
  
  return(res)
}



