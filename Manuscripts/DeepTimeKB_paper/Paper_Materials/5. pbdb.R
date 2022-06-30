# load library
library(SPARQL)
library(paleobioDB)

#### 1. Query the boudaries of Otaian Age in New Zealand from the knowledge graph of local geological time standards.####

# set up end point
endpoint = "http://virtuoso.nkn.uidaho.edu:8890/sparql/"

# attach SPARQL querry prefix.
sparql_prefix = " 
              prefix dc: <http://purl.org/dc/elements/1.1/>
              prefix gts: <http://resource.geosciml.org/ontology/timescale/gts#>
              prefix skos: <http://www.w3.org/2004/02/skos/core#>
              prefix time: <http://www.w3.org/2006/time#>
              prefix ts: <http://resource.geosciml.org/vocabulary/timescale/> 
              prefix isc: <http://resource.geosciml.org/classifier/ics/ischart/> 
      "

# run the query

q = paste0(
  sparql_prefix, 
  '
               SELECT   DISTINCT ?schemeID str(?label) AS ?geoConcpet ?begTimeValue ?endTimeValue 
               WHERE
               {GRAPH <http://deeptimekb.org/iscallnew> 
                 {
                   ?tconcept  a gts:GeochronologicEra ;  
                                   rdfs:label ?label ;
                                   skos:inScheme ?schemeID.
                   FILTER (lang(?label) = "en")
                   FILTER strstarts(?label, "Otaian").
                   ?tconcept time:hasBeginning ?beg ;
                   time:hasEnd ?end .
                   ?beg time:inTemporalPosition ?begTime .
                   ?end time:inTemporalPosition ?endTime .
                   ?begTime time:numericPosition ?begTimeValue .
                   ?endTime time:numericPosition ?endTimeValue .
                 }
               }
               ORDER BY DESC (?schemeID) 
              '
)
res = SPARQL(endpoint, q)$results

#### 2. Query the Canidae fossil occurrences in Otaian Age in New Zealand through Paleobiology Database with regional knowledge graph. ####
oc = pbdb_occurrences(limit = "all", base_name="canidae", min_ma = res$endTimeValue, max_ma = res$begTimeValue, show=c("coords", "phylo", "ident"))

#### 3. Query the Canidae fossil occurrences in Otaian Age in New Zealand through Paleobiology Database. ####
pbdb_occurrences (limit="all", base_name="canidae", 
                  interval="Otaian", show=c("coords", "phylo", "ident")) # You will get an error.
