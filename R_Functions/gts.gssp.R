
# This query is written to plot all the golden spikes in year 2018-08

#INPUT
# 1. prefix: optional, the prefix that need to be added
# 2. graph: optional, the graph user provided
# 3. longlatdf: Latitude and longitude
# 4. conceptdf: list of all the concept
# 5. concept_full: merge of longlatdf and conceptdf
# 6. library leaflet: Leaflet is one of the most popular open-source JavaScript libraries for interactive maps

#OUTPUT
# 1. Plot all the golden spikes on the map and displays the concept name.

install.packages("dplyr")
install.packages("tidyr")
install.packages("leaflet")
library(leaflet)
library(SPARQL)
library(rworldmap)
library(stringr)

endpoint = "http://virtuoso.nkn.uidaho.edu:8890/sparql/"

# attach SPARQL querry prefix. Note: the graph for our study should be updated
sparql_prefix = "
    prefix tssc: <http://deeptimekb.org/tssc#> 
    prefix tsnc: <http://deeptimekb.org/tsnc#> 
    prefix tswe: <http://deeptimekb.org/tswe#> 
    prefix tsbr: <http://deeptimekb.org/tsbr#>
    prefix tsba: <http://deeptimekb.org/tsba#> 
    prefix tsjp: <http://deeptimekb.org/tsjp#> 
    prefix tsau: <http://deeptimekb.org/tsau#>                   
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
if (!is.null(prefix)){
  sparql_prefix = paste(prefix, sparql_prefix, sep = "/n")
}

# run the query
q1 = paste0(sparql_prefix, '
       SELECT DISTINCT (str(?spLabel) AS ?label1) (str(?spCoordinates) AS ?coord1)
WHERE
{
                
   GRAPH <http://deeptimekb.org/iscallnew>
   {   
       ?bdry  a gts:GeochronologicBoundary ;
               dc:description
               [
                 gts:stratotype ?baseSp ;
                 skos:inScheme ts:isc2018-08
               ] .
        
       ?baseSp samfl:shape ?spLocation ;  
               rdfs:label ?spLabel ;
               gts:ratifiedGSSP ?tf . 
        FILTER(regex(str(?tf), "true", "i"))

       ?spLocation geo:asWKT ?spCoordinates .
   }

}
')
res1 = SPARQL(endpoint, q1)$results

#take out only the long and lat records from the sparql query results
longlat<-substr(res1$coord1, 7, nchar(res1$coord1)-1)
concept <- substr(res1$label1, 25, nchar(res1$label1))

longlatdata<-str_split_fixed(longlat, " ", 2)

longlatdf <-data.frame(longlatdata)
conceptdf <- data.frame(concept)

#merge two files
concept_full <- bind_cols(conceptdf, longlatdf)

leaflet() %>%
  addTiles() %>%
  addMarkers(lng = as.numeric( as.character(longlatdf$X1) ), lat = as.numeric( as.character(longlatdf$X2)), popup = concept)













