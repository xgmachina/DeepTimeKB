# INPUT: 
# 1. geoConcept: geological time concept, eg. Cambrian
# 2. prefix: optional, the prefix that need to be added
# 3. graph: optional, the graph user provided

# OUTPUT:
# begin and end time of the geotime and its duration.

gts.listRegion = function(prefix = NULL, graph = NULL){
  
  
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
  
  # the query code
  q = paste0(
    sparql_prefix, 
    '
                   SELECT DISTINCT ?schURI str(?lbl) AS ?region
                   WHERE
                   {
                     GRAPH <http://deeptimekb.org/iscallnew> 
                     {
                        ?schURI a skos:ConceptScheme ;
                                rdfs:label ?lbl .
                        #FILTER regex(?lbl, "International", "i")
                     }      
                   }
                   ORDER BY DESC (?schURI)
                  '
  )
  
  # run the query  
  res = SPARQL(endpoint, q)$results
  res[,2] = sub(".*in ", "", res[,2])
  return(res)
}