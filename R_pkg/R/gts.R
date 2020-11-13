# INPUT: 
# 1. geoConcept: geological time concept, eg. Cambrian
# 2. prefix: optional, the prefix that need to be added
# 3. graph: optional, the graph user provided

# OUTPUT:
# all properties in the graph

gts = function(geoConcept, prefix = NULL, graph = NULL){
  
  
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
                  SELECT  DISTINCT ?s AS ?geoConcept ?p AS ?property ?o AS ?value
                  WHERE
                      {
                                    
                       ', graph, '
                        {   
                        {
                            ?s rdfs:label ?label.
                            ?s ?p ?o
                        FILTER (lang(?label) = "en")
                        FILTER strstarts(?label, "', geoConcept, '")
                        
                        }
                        
                        UNION
                           {  ?s 
                                  rdfs:label ?label.
                               ?s   dc:description[
                        ?p ?o
                        ]
                        FILTER (lang(?label) = "en")
                        FILTER strstarts(?label, "', geoConcept, '")
                        
                        }
                        }
                    } 
                  '
    )
  }else{
    q = paste0(
      sparql_prefix, 
      '
                  SELECT  DISTINCT ?s AS ?geoConcept ?p AS ?property ?o AS ?value
                  WHERE
                      {
                                    
                       GRAPH <http://deeptimekb.org/iscallnew>
                        {   
                        {
                            ?s rdfs:label ?label.
                            ?s ?p ?o
                        FILTER (lang(?label) = "en")
                        FILTER strstarts(?label, "', geoConcept, '")
                        
                        }
                        
                        UNION
                           {  ?s 
                                  rdfs:label ?label.
                               ?s   dc:description[
                        ?p ?o
                        ]
                        FILTER (lang(?label) = "en")
                        FILTER strstarts(?label, "', geoConcept, '")
                        
                        }
                        }
                    } 
                  '
    )
  }
  res = SPARQL(endpoint, q)$results
  
  return(res)
}