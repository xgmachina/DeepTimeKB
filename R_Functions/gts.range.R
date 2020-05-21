gts.range = function(geotime1, geotime2, endpoint=, graph=){
        
        # endpoint need to update accordingly
        endpoint = "http://virtuoso.nkn.uidaho.edu:8890/sparql/"
        
        sparql_prefix = " prefix tssc: <http://deeptimekb.org/tssc#> 
                  prefix tsnc: <http://deeptimekb.org/tsnc#> 
                  prefix dc: <http://purl.org/dc/elements/1.1/> 
                  prefix dcterms: <http://purl.org/dc/terms/> 
                  prefix foaf: <http://xmlns.com/foaf/0.1/> 
                  prefix geo: <http://www.opengis.net/ont/geosparql#> 
                  prefix gts: <http://resource.geosciml.org/ontology/timescale/gts#> 
                  prefix isc: <http://resource.geosciml.org/classifier/ics/ischart/> 
                  prefix owl: <http://www.w3.org/2002/07/owl#> 
                  prefix rank: <http://resource.geosciml.org/ontology/timescale/rank/> 
                  prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
                  prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
                  prefix samfl: <http://def.seegrid.csiro.au/ontology/om/sam-lite#> 
                  prefix sf: <http://www.opengis.net/ont/sf#> 
                  prefix skos: <http://www.w3.org/2004/02/skos/core#> 
                  prefix sosa: <http://www.w3.org/ns/sosa/> 
                  prefix thors: <http://resource.geosciml.org/ontology/timescale/thors#> 
                  prefix time: <http://www.w3.org/2006/time#> 
                  prefix ts: <http://resource.geosciml.org/vocabulary/timescale/> 
                  prefix vann: <http://purl.org/vocab/vann/> 
                  prefix void: <http://rdfs.org/ns/void#> 
                  prefix xkos: <http://rdf-vocabulary.ddialliance.org/xkos#> 
                  prefix xsd: <http://www.w3.org/2001/XMLSchema#> 
                "
        if(geotime1 > geotime2){
                T_beg = geotime1
                T_end = geotime2
                
        }else{
                T_beg = geotime2
                T_end = geotime1
        }

        q = paste(sparql_prefix, "
       SELECT   ?aa
       WHERE
       {
       GRAPH <http://deeptimekb.org/tswebrbajpau> 
       {
       ?s rdfs:label ?aa ;
       time:hasBeginning ?beg ;
       time:hasEnd ?end .
       ?beg time:inTemporalPosition ?begTime .
       ?end time:inTemporalPosition ?endTime .
       ?begTime time:numericPosition ?begTimeValue .
       FILTER(?begTimeValue <", T_beg, ") .
       ?endTime time:numericPosition ?endTimeValue .
       FILTER(?endTimeValue >", T_end, ") .
       }
       }")
        
        res = SPARQL(endpoint, q)$results
        return(res)
}