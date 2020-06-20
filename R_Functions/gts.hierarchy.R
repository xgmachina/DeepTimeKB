# INPUT: 
# 1. geoConcept: geological time concept, eg. Cambrian
# 2. prefix: optional, the prefix that need to be added
# 3. graph: optional, the graph user provided

# OUTPUT:
# all properties in the graph

gts.hierarchy = function(geoConcept, region = NULL, iscVersion = NULL, prefix = NULL, graph = NULL){
  
  
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
 SELECT  ?schemeID  ?broaderConcept ?inputConcept ?narrowerConcept
                  WHERE
                  {
                                  
                  ', graph, '
                     { 
                      ?inputConcept  a gts:GeochronologicEra ;
                                  rdfs:label ?clabel . 
                      FILTER strstarts(?clabel, "', geoConcept, '") 
                   
                      ?inputConcept dc:description  
                        [   
                        skos:broader ?broaderConcept ;
                        skos:narrower ?narrowerConcept ;
                        skos:inScheme ?schemeID
                        ] .
                  
                      ?narrowerConcept dc:description  
                        [   
                           time:hasBeginning ?basePosition ; 
                           skos:inScheme ?schemeID
                        ] .
                  
                       ?basePosition time:inTemporalPosition ?baseTime .
                  
                       ?baseTime dc:description  
                        [   
                           time:numericPosition ?baseNum ; 
                           skos:inScheme ?schemeID
                        ] .
                      }
                     
                  }
                  ORDER BY ?schemeID 
                  '
    )
  }else{
    q = paste0(
      sparql_prefix, 
      '
                  SELECT  ?schemeID ?broaderConcept ?inputConcept ?narrowerConcept
                  WHERE
                  {
                                  
                     GRAPH <http://deeptimekb.org/iscallnew>
                     { 
                      ?inputConcept  a gts:GeochronologicEra ;
                                  rdfs:label ?clabel . 
                      FILTER strstarts(?clabel, "', geoConcept, '") 
                   
                      ?inputConcept dc:description  
                        [   
                        skos:broader ?broaderConcept ;
                        skos:narrower ?narrowerConcept ;
                        skos:inScheme ?schemeID
                        ] .
                  
                      ?narrowerConcept dc:description  
                        [   
                           time:hasBeginning ?basePosition ; 
                           skos:inScheme ?schemeID
                        ] .
                  
                       ?basePosition time:inTemporalPosition ?baseTime .
                  
                       ?baseTime dc:description  
                        [   
                           time:numericPosition ?baseNum ; 
                           skos:inScheme ?schemeID
                        ] .
                      }
                     
                  }
                  ORDER BY ?schemeID 
          '
    )
  }
  res = SPARQL(endpoint, q)$results
  res[,1] = sub(".*/", "", res[,1])
  res[,1] = substr(res[,1], 1, nchar(res[,1])-1)
  res[,2] = sub(".*/", "", res[,2])
  res[,2] = substr(res[,2], 1, nchar(res[,2])-1)
  res[,3] = sub(".*/", "", res[,3])
  res[,3] = substr(res[,3], 1, nchar(res[,3])-1)
  res[,4] = sub(".*/", "", res[,4])
  res[,4] = substr(res[,4], 1, nchar(res[,4])-1)
  
  
  return(res)
}