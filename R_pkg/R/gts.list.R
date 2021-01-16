
#The query is written to list all the geological concept of a region.

#INPUT
# 1. region: region of the geoConcept 
# 2. prefix: optional, the prefix that need to be added
# 3. graph: optional, the graph user provided

#OUTPUT
#1. List all the geological concept of North America.

gts.list = function(region, level=NULL){
  
  if(!is.null(level) & !any(level == c(NULL, "Age", "Epoch", "Period", "Era", "Eon"))){
    stop('level must be NULL, "Age", "Epoch", "Period", "Era" or "Eon", see help page for more detail')
  }
  
  regionScheme = gts.regionalSchemeTable()
  if(!is.null(region) & !any(region == c("International","international",
                                         regionScheme$region))){
    stop('region must be NULL or regions listed in help page')
  }
  
  
  # endpoint need to update accordingly
  endpoint = "http://virtuoso.nkn.uidaho.edu:8890/sparql/"
  
  sparql_prefix = " 
                prefix dc: <http://purl.org/dc/elements/1.1/>
                prefix gts: <http://resource.geosciml.org/ontology/timescale/gts#>
                prefix skos: <http://www.w3.org/2004/02/skos/core#>
                prefix time: <http://www.w3.org/2006/time#>
                prefix ts: <http://resource.geosciml.org/vocabulary/timescale/> 
                prefix isc: <http://resource.geosciml.org/classifier/ics/ischart/> 
        "
  
    scheme = regionScheme[which(regionScheme$region == region),2]
    if (region == "international" | region == "International"){
      scheme = "isc"
    } 
  
  if(scheme == "isc"){
    q = paste0(sparql_prefix, '
            
SELECT DISTINCT str(?label) AS ?geoConcept
WHERE
{
   GRAPH <http://deeptimekb.org/iscallnew>
   { 
     ?concept  a gts:GeochronologicEra ;
              rdfs:label ?label .
     ?concept  dc:description[
                  skos:inScheme ?sch]
     FILTER(regex(STR(?sch), "isc", "i"))
     FILTER(regex(STR(?label), "', level, '", "i"))
   }
}
            ')
  } else {
    q = paste0(sparql_prefix, '
            
SELECT DISTINCT str(?label) AS ?geoConcept
WHERE
{
                
   GRAPH <http://deeptimekb.org/iscallnew>
   { 
      
     ?sch  a skos:ConceptScheme . 
     FILTER(regex(STR(?sch), "', scheme, '", "i"))
     ?concept  a gts:GeochronologicEra ;
               skos:inScheme ?sch ;
               rdfs:label ?label ;
               time:hasBeginning ?basePosition .  
     ?basePosition time:inTemporalPosition ?baseTime .
     ?baseTime time:numericPosition ?baseNum .
     FILTER(regex(STR(?label), "', level, '", "i"))
    }
   
}
ORDER BY ?baseNum
         
            ')
  }

  
  res1 = SPARQL(endpoint, q)$results
  return(t(res1))
}         

