# install deeptimekb package from github
devtools::install_github("Demerara/DeepTimeKB", upgrade = FALSE, force = T)
library(DeepTimeKB)

gts.list("international") # international should be the latest isc
gts.list("international", "Epoch")
gts.list("North America", "Epoch")
gts.list(region = 2) # error
gts.list(region = "international", "non") # error


gts.range("Jurassic")
gts.range("Harju")
gts.range("Wordian")
gts.range("Wordian", region = "North America")
gts.range("Wordian", region = "international")
gts.range("Wordian", region = "international", iscVersion = "2017")
gts.range("Wordian", region = "New Zealand") # warning
gts.range("Wordian", region = "North America", iscVersion = "2017") # warning


gts.topo("Jurassic", "Harju") # Error in gts.topo("Jurassic", "Harju") : 
                              # Please specify region and/or iscVersion of geoConcept1 to make sure gts.range(geoConcept1) has one retured result
gts.topo("Jurassic", "Harju", iscVersion1 = "2012")
gts.topo("Harju", "Wordian") # Error in gts.topo("Harju", "Wordian") : 
                             # Please specify region and/or iscVersion of geoConcept2 to make sure gts.range(geoConcept2) has one retured result
gts.topo("Harju", "Wordian", region2 = "North America")

gts.listRegion()

gts.iscSchemes("all")
gts.iscSchemes("latest")
gts.iscSchemes("latest", URI=F)
gts.iscSchemes("all", URI=F)

a = gts("Jurassic")
View(a)
a = gts("Harju")
View(a)

gts.hierarchy("Jurassic")
gts.hierarchy("Harju") 
gts.hierarchy("Wordian") # not narrowerConcept
gts.hierarchy("Precambrian") # no broaderCocnept

gts.level("Jurassic")
gts.level("Wordian")

gts.point(50)

gts.gssp() # get GSSP data from all ISC versions
gts.gssp("latest")
gts.gssp("2009")

gssp.map("latest")
gssp.map()
gssp.map("2009")

