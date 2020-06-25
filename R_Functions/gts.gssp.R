# INPUT
# 1. iscVersion: the version of the international stratigraphic chart
# 2. prefix: optional, the prefix that need to be added
# 3. graph: optional, the graph user provided

# OUTPUT
# scheme ID, GSSP, and longitude+latitude.

gts.gssp = function(iscVersion = NULL, prefix = NULL, graph = NULL){
  
  if(is.null(graph)){
    graph = "GRAPH <http://deeptimekb.org/iscallnew>"
  } 
  if(!is.null(iscVersion)){
    if(iscVersion == "latest") {
      iscVersion = gts.iscSchemes(id="latest", URI = F)
  }
  }
  
  endpoint = "http://virtuoso.nkn.uidaho.edu:8890/sparql/"
  
  # attach SPARQL querry prefix. Note: the graph for our study should be updated
  sparql_prefix = "
                  prefix dc: <http://purl.org/dc/elements/1.1/>
                  prefix gts: <http://resource.geosciml.org/ontology/timescale/gts#>
                  prefix skos: <http://www.w3.org/2004/02/skos/core#>
                  prefix time: <http://www.w3.org/2006/time#>
                  prefix ts: <http://resource.geosciml.org/vocabulary/timescale/> 
                  prefix isc: <http://resource.geosciml.org/classifier/ics/ischart/> 
                  prefix samfl: <http://def.seegrid.csiro.au/ontology/om/sam-lite#> 
                  prefix geo: <http://www.opengis.net/ont/geosparql#> 
                  "
  
  # run the query
  q = paste0(sparql_prefix, '
                            SELECT ?schemeID (str(?spLabel) AS ?GSSP) (str(?spCoordinates) AS ?coord)
                            WHERE
                            {
                                            
                               ', graph, '
                               {   
                                   ?bdry  a gts:GeochronologicBoundary ;
                                           dc:description
                                           [
                                             gts:stratotype ?baseSp ;
                                             skos:inScheme ?schemeID
                                           ] .
                                    
                                   ?baseSp samfl:shape ?spLocation ;  
                                           rdfs:label ?spLabel ;
                                           gts:ratifiedGSSP ?tf . 
                                    FILTER(regex(str(?tf), "true", "i"))
                                    FILTER(regex(?schemeID, "', iscVersion, '"))
                            
                                   ?spLocation geo:asWKT ?spCoordinates .
                               }
                            
                            }
                            ORDER BY ?schemeID
  ')
  
  # run the query
  res = SPARQL(endpoint, q)$results
  
  # select only the name of the schemeID
  res[,1] = sub(".*/", "", res[,1])
  res[,1] = substr(res[,1], 1, nchar(res[,1])-1)
  
  # change coordination to two columns (long and lat)
  longlat = substr(res$coord, 7, nchar(res$coord)-1)
  lat = sub(".* ", "", longlat)
  long = sub("\\ .*", "", longlat)
  res$longitude = long
  res$latitude = lat
  res = subset(res, select = c(1,2,4,5))
  
  return(res) 
}

