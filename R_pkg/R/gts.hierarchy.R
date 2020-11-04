# INPUT: 
# 1. geoConcept: geological time concept, eg. Cambrian
# 2. prefix: optional, the prefix that need to be added
# 3. graph: optional, the graph user provided

# OUTPUT:
# The broader and narrower concept of the geoConcept

gts.hierarchy = function(geoConcept, prefix = NULL, graph = NULL){
  
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
  
  # get the level of the geoConcept
  level = gts.level(geoConcept)
  
  # when the geoConcept does not have narrowerConcept
  if (level[1,3] == "Age"){
    q = paste0(
      sparql_prefix, 
      '
                  SELECT  ?schemeID str(?blabel) AS ?broaderConcept str(?clabel) AS ?inputConcept
                  WHERE
                  {
                                  
                     ', graph, '
                     {
                     {
                      ?inputConcept  a gts:GeochronologicEra ;
                                  rdfs:label ?clabel . 
                      FILTER strstarts(?clabel, "', geoConcept, '") 
                   
                      ?inputConcept dc:description  
                        [   
                        skos:broader ?broaderConcept ;
                        skos:inScheme ?schemeID
                        ] .

                      ?broaderConcept rdfs:label ?blabel .
                     }  
                     UNION 
                     {
                     ?inputConcept  a gts:GeochronologicEra ;
                                  rdfs:label ?clabel . 
                      FILTER strstarts(?clabel, "', geoConcept, '") 
                
                      ?inputConcept  
                        skos:broader ?broaderConcept ;
                        skos:inScheme ?schemeID .
                      ?broaderConcept rdfs:label ?blabel .

                     }
                    }
                  }
                  ORDER BY ?schemeID
          '
    )
  } else if(level[1,3] == "Supereon" | geoConcept == "Phanerozoic"){  # when the geoConcept does not have broaderConcept
    q = paste0(
      sparql_prefix, 
      '
                  SELECT  ?schemeID str(?clabel) AS ?inputConcept str(?nlabel) AS ?narrowerConcept
                  WHERE
                  {
                                  
                     ', graph, '
                     {
                     {
                      ?inputConcept  a gts:GeochronologicEra ;
                                  rdfs:label ?clabel . 
                      FILTER strstarts(?clabel, "', geoConcept, '") 
                   
                      ?inputConcept dc:description  
                        [   
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
                      ?narrowerConcept rdfs:label ?nlabel .
                     }  
                     UNION 
                     {
                     ?inputConcept  a gts:GeochronologicEra ;
                                  rdfs:label ?clabel . 
                      FILTER strstarts(?clabel, "', geoConcept, '") 
                   
                      ?inputConcept  
                        skos:inScheme ?schemeID .
                        
                      ?narrowerConcept skos:broader ?inputConcept ; 
                           time:hasBeginning ?basePosition . 

                      ?basePosition time:inTemporalPosition ?baseTime .
                  
                      ?baseTime time:numericPosition ?baseNum .
                      ?narrowerConcept rdfs:label ?nlabel .
                     }
                    }
                  }
                  ORDER BY ?schemeID ?baseNum
                  limit 1000
          '
    )
  } else {   # when the geoConcept have both broaderConcept and narrowerConcept
    q = paste0(
      sparql_prefix, 
      '
                  SELECT  ?schemeID str(?blabel) AS ?broaderConcept str(?clabel) AS ?inputConcept str(?nlabel) AS ?narrowerConcept
                  WHERE
                  {
                                  
                     ', graph, '
                     {
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
                      ?broaderConcept rdfs:label ?blabel .
                      ?narrowerConcept rdfs:label ?nlabel .
                     }  
                     UNION 
                     {
                     ?inputConcept  a gts:GeochronologicEra ;
                                  rdfs:label ?clabel . 
                      FILTER strstarts(?clabel, "', geoConcept, '") 
                   
                      ?inputConcept  
                        skos:broader ?broaderConcept ;
                        skos:inScheme ?schemeID .
                        
                      ?narrowerConcept skos:broader ?inputConcept ; 
                           time:hasBeginning ?basePosition . 

                      ?basePosition time:inTemporalPosition ?baseTime .
                  
                      ?baseTime time:numericPosition ?baseNum .
                      ?broaderConcept rdfs:label ?blabel .
                      ?narrowerConcept rdfs:label ?nlabel .
                     }
                      
                    }
                     
                  }
                  ORDER BY ?schemeID ?baseNum
                  limit 1000
          '
    )
  }   
  
  # run the query
  res = SPARQL(endpoint, q)$results
  
  # select only the name of the schemeID
  res[,1] = sub(".*/", "", res[,1])
  res[,1] = substr(res[,1], 1, nchar(res[,1])-1)
  
  # add the missing column as "not exist"
  if (level[1,3] == "Age"){
    res$narrowerConcept = "not exist"
  }
  if (level[1,3] == "Supereon" | geoConcept == "Phanerozoic"){
    res$broaderConcept  = "not exist"
    res = subset(res, select = c(1,4,2,3))
  }
  
  return(res)
}