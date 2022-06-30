# set working directory
setwd("")

# read template and formatted data
ex_botTop <- readLines("template.txt") # the template
data <- read.csv("R5.csv") # the csv file with the Age and Epoch data. It should has 11 columns: Region,	region's short name,	conceptName,	conceptLevel,	 Top (Ma),	 Bottom (Ma),	broader is local?,	 broader (Epoch),	 broaderTransitive,	 broaderTransitive,	 and broaderTransitive.

# initialize the result as NULL
result <- NULL

for (i in 1:nrow(data)){
  
  ex1 <- ex_botTop # take in the template
  
  ## REPLACE0:region's short name
  ex1 <- gsub(pattern = "REPLACE0", replace = as.character(data[i,2]), x = ex1)
  
  ## REPLACE1:the name of the concept
  ex1 <- gsub(pattern = "REPLACE1", replace = as.character(data[i,3]), x = ex1)
  
  ## REPLACE2: Epoch or Age
  ex1 <- gsub(pattern = "REPLACE2", replace = as.character(data[i,4]), x = ex1)
  
  ## REPLACE3:broader's region
  if(data[i,7] == "Y"){
    ex1 <- gsub(pattern = "REPLACE3", replace = as.character(data[i,2]), x = ex1) # if it has local broader in Series then use region's short name, this only works for concepts in Age
  }
  if(data[i,7] == "N"){
    ex1 <- gsub(pattern = "REPLACE3", replace = "isc", x = ex1) # if broader in Series is from international then use "isc"
  }
  
  ## REPLACE4:broader
  ex1 <- gsub(pattern = "REPLACE4", replace = as.character(data[i,8]), x = ex1)
  
  ## REPLACE5:broaderTransitive
  ex1 <- gsub(pattern = "REPLACE5", replace = as.character(data[i,9]), x = ex1) # broaderTransitive
  
  ## REPLACE6:broaderTransitive
  ex1 <- gsub(pattern = "REPLACE6", replace = as.character(data[i,10]), x = ex1) # broaderTransitive
  
  ## REPLACE7:time:hasEnd 
  if(i == 1){
    ex1 <- gsub(pattern = "REPLACE7", replace = paste0("Top", as.character(data[i,3])), x = ex1) # time:hasEnd of the concept
  }else{
    if(data[i,5] != data[i-1,6]){ # if this concept and the above one does not share a boundary
      ex1 <- gsub(pattern = "REPLACE7", replace = paste0("Top", as.character(data[i,3])), x = ex1) # time:hasEnd of the concept
    }
    if(data[i,5] == data[i-1,6]){ # if this concept and the above one does share a boundary
      ex1 <- gsub(pattern = "REPLACE7", replace = paste0("Base", as.character(data[i-1,3])), x = ex1[1:31]) # the concept above the present concept as the end of the present concept
    }
    
  }
  
  ## REPLACE8:bottom age of the concept
  ex1 <- gsub(pattern = "REPLACE8", replace = as.character(data[i,6]), x = ex1)
  ## REPLACE9:top age of the concept
  ex1 <- gsub(pattern = "REPLACE9", replace = as.character(data[i,5]), x = ex1)
  
  # remove broader or broaderTransitive that does not exist, or duplicated broaderTransitive
  if(data[i,8] == "None"){   # if no broader concept
    ex1[7]= "REMOVE"
  }
  if(data[i,9] == "None"){   # if no broaderTransitive concept
    ex1[8]= "REMOVE"
  }
  if(data[i,10] == "None"){   # if no broaderTransitive concept
    ex1[9]= "REMOVE"
  }
  if(data[i,4] == "Epoch"){   # There will be two "skos:broaderTransitive isc:Phanerozoic" for Epoch, thus should be removed
    ex1[10]= "REMOVE"
  }
  ex1=ex1[ex1!="REMOVE"]
  
  result <- c(result,ex1)
}

# write result to turtle file
write(result, "result.ttl")
