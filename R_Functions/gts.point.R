

#The goal is to find all the broader and broaderTransitive concepts.
#i.e. concepts at higher levels, such as Epoch, Period, Era, and Eon.  

library(SPARQL)
gts.point = function(T_beg){
  
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


  
  q = paste(sparql_prefix, "
       SELECT DISTINCT ?All
WHERE
{
        	GRAPH <http://deeptimekb.org/iscallnew>
   {

{ 
SELECT DISTINCT ?tconcept  
WHERE
{
        	?tconcept skos:prefLabel ?label ;
          	dc:description 
          	[  
        	        	time:hasBeginning ?baseboundary ;
        	        	skos:inScheme ts:isc2012-08
          	] ;
          	rdf:type gts:Age.
       
 
    	
           
	?baseboundary time:inTemporalPosition ?basetime .
                
                 
	?basetime dc:description
                                	     	[
                                	         	time:numericPosition ?baseNum;
                                	         	skos:inScheme ts:isc2012-08
                                	     	]  .

      
      FILTER (?baseNum >=", T_beg, ") .

}
ORDER BY ?baseNum
LIMIT 1
}

{ #This block is to include the Age-level concept in the resulting list 
  ?tconcept rdfs:label ?labelAgeC . 
  ?All rdfs:label ?labelAgeC .
}
UNION
{ # This and the next block are to find the broader and broaderTransitive concepts
?tconcept
dc:description
      [
         skos:broaderTransitive ?All ;
         skos:inScheme  ts:isc2012-08
      ]
}
UNION 
{
?tconcept
dc:description
      [
         skos:broader  ?All ;
         skos:inScheme  ts:isc2012-08
      ]

}
  
      ?All 
      dc:description 
      [  
        time:hasBeginning ?baseboundary1 ;
        time:hasEnd ?topboundary1 ;
        skos:inScheme ts:isc2012-08
        ] .
      
      ?baseboundary1 time:inTemporalPosition ?basetime1 .
      ?topboundary1 time:inTemporalPosition ?toptime1 .
      
      ?basetime1 dc:description
      [
        time:numericPosition ?baseNum1;
        skos:inScheme ts:isc2012-08
        ]  .
      
      ?toptime1 dc:description
      [
        time:numericPosition ?topNum1;
        skos:inScheme ts:isc2012-08
        ]  .
      
      BIND (?baseNum1 - ?topNum1 AS ?numLength1)
      
    }
}

ORDER BY ?numLength1

")
  
  res = SPARQL(endpoint, q)$results
  return(res)
}



