# INPUT: 
# 1. geoConcept: geological time concept, eg. Cambrian
# 2. prefix: optional, the prefix that need to be added
# 3. graph: optional, the graph user provided

# OUTPUT:
# begin and end time of the geotime and its duration.

gts.range = function(geoConcept, region = NULL, iscVersion = NULL, prefix = NULL, graph = NULL){
  

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
                   SELECT   DISTINCT ?schemeID str(?label) AS ?geoConcpet ?begTimeValue ?endTimeValue 
                   WHERE
                   {', graph, '
                     {
                             {
                             ?tconcept  a gts:GeochronologicEra ;  
                                             rdfs:label ?label ;
                                             skos:inScheme ?schemeID.
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
                              skos:inScheme  ?schemeID].
                              ?beg time:inTemporalPosition ?begTime .
                              ?end time:inTemporalPosition ?endTime .
                              ?begTime dc:description
                              [time:numericPosition ?begTimeValue ;
                              skos:inScheme  ?schemeID].
                              ?endTime dc:description
                              [time:numericPosition ?endTimeValue ;
                              skos:inScheme ?schemeID].
                             }
                     }
                   }
                   ORDER BY DESC (?schemeID) 
                  '
    )
  }else{
  q = paste0(
              sparql_prefix, 
                  '
                   SELECT   DISTINCT ?schemeID str(?label) AS ?geoConcpet ?begTimeValue ?endTimeValue 
                   WHERE
                   {
                     GRAPH <http://deeptimekb.org/iscallnew> 
                     {
                            {       
                             ?tconcept  a gts:GeochronologicEra ;  
                                             rdfs:label ?label ; 
                                             skos:inScheme ?schemeID.
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
                              skos:inScheme  ?schemeID].
                              ?beg time:inTemporalPosition ?begTime .
                              ?end time:inTemporalPosition ?endTime .
                              ?begTime dc:description
                              [time:numericPosition ?begTimeValue ;
                              skos:inScheme  ?schemeID].
                              ?endTime dc:description
                              [time:numericPosition ?endTimeValue ;
                              skos:inScheme ?schemeID].
                             }
                     }
                   }
                   ORDER BY DESC (?schemeID) 
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
  
  # calculate the duration
  res$duration = abs(res[[3]]-res[[4]])
  res$schemeID = substr(res$schemeID, 52, nchar(res$schemeID)-1)
  
  regionScheme = gts.regionalSchemeTable()
  # deal with region
  if(!is.null(region) & !any(region == c("International","international",
                                         regionScheme$region))){
    stop('region must be NULL or regions listed in help page')
  }
  if(!is.null(region)){
    scheme = regionScheme[which(regionScheme$region == region),2]
    if (region == "international" | region == "International"){
      scheme = "isc"
    } 
    res = res[grepl(scheme, res$schemeID, fixed = T),]
  }
  
  # deal with international geological time scale version
  if(!is.null(iscVersion)){
    res = res[grepl(iscVersion, res$schemeID, fixed = T),]
  }
  
  # if(!is.null(region) & !is.null(iscVersion)){
  #   if(region != "international" & region != "International"){
  #     warning("Only International Geological Time Scale has versions. See help page for more detail.")
  #   }
  # }
  if(nrow(res)==0){
    warning("No result returned! Possible reason could be no such concept in this region or iscVersion")
  }
  
  return(res)
}
