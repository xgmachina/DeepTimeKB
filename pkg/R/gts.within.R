# INPUT: 
# 1. geotime1: time in geology, e.g. 50 Ma
# 2. geotime2: time in geology, e.g. 100 Ma
# 3. prefix: optional, the prefix that need to be added
# 4. graph: optional, the graph user provided

# OUTPUT:
# all the geoConcepts that is between geotime1 and geotime2.

gts.within = function(geotime1, geotime2, prefix=NULL, graph=NULL){
        
        # set up an endpoint
        endpoint = "http://virtuoso.nkn.uidaho.edu:8890/sparql/"
        
        # SPARQL prefix
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
        
        # sort the two input geotimes and find the old one as the begging time and the younger one as the end time.
        if(geotime1 > geotime2){
                T_beg = geotime1
                T_end = geotime2
                
        }else{
                T_beg = geotime2
                T_end = geotime1
        }

        # select the geotime that is between geotime1 and geotime2
        
        if(!is.null(graph)){
                q = paste(sparql_prefix, '
                       SELECT DISTINCT ?schemeID str(?label) AS ?geoConcept
                       WHERE
                       {', graph, '
                       {
                                {
                                ?tconcept  a gts:GeochronologicEra ;  
                                               rdfs:label ?label ;
                                time:hasBeginning ?beg ;
                                time:hasEnd ?end ;
                                skos:inScheme  ?schemeID .
                                ?beg time:inTemporalPosition ?begTime .
                                ?end time:inTemporalPosition ?endTime .
                                ?begTime time:numericPosition ?begTimeValue .
                                FILTER(?begTimeValue <=', T_beg, ') .
                                ?endTime time:numericPosition ?endTimeValue .
                                FILTER(?endTimeValue >=', T_end, ') .
                                }
                        UNION
                                {
                                ?tconcept a gts:GeochronologicEra ;  
                                       rdfs:label ?label .
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
                                skos:inScheme  ?schemeID].
                                FILTER(?begTimeValue <=', T_beg, ') .
                                FILTER(?endTimeValue >=', T_end, ') .
                                }
                
                       }
                       }')
        }else{
                q = paste(sparql_prefix, '
                       SELECT DISTINCT ?schemeID str(?label) AS ?geoConcept
                       WHERE
                       {
                       GRAPH <http://deeptimekb.org/iscallnew> 
                       {
                                {
                                ?tconcept  a gts:GeochronologicEra ;  
                                               rdfs:label ?label ;
                                time:hasBeginning ?beg ;
                                time:hasEnd ?end ;
                                skos:inScheme  ?schemeID .
                                ?beg time:inTemporalPosition ?begTime .
                                ?end time:inTemporalPosition ?endTime .
                                ?begTime time:numericPosition ?begTimeValue .
                                FILTER(?begTimeValue <=', T_beg, ') .
                                ?endTime time:numericPosition ?endTimeValue .
                                FILTER(?endTimeValue >=', T_end, ') .
                                }
                        UNION
                                {
                                ?tconcept a gts:GeochronologicEra ;  
                                       rdfs:label ?label .
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
                                skos:inScheme  ?schemeID].
                                FILTER(?begTimeValue <=', T_beg, ') .
                                FILTER(?endTimeValue >=', T_end, ') .
                                }
                
                       }
                       }
                          ORDER BY ?schemeID')    
        }
       
        res = SPARQL(endpoint, q)$results
        res$schemeID = substr(res$schemeID, 52, nchar(res$schemeID)-1)
        return(res)
}
