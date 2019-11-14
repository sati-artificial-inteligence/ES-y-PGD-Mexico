#### Installing packages ####
#string of packages to use
packagesToLoad <- c("XML", "plyr", "ggplot2", "gridExtra", "maps")

#To load packages
for(i in 1:length(packagesToLoad)){
  if(!require(packagesToLoad[i], character.only = TRUE)){
    install.packages(packagesToLoad, dependencies = TRUE)
    require(packagesToLoad[i], character.only = TRUE)
  }else{
    require(packagesToLoad[i], character.only = TRUE)
  }
}

#To detach packages
for(i in 1:length(packagesToLoad)){
  detach(pos = match(paste("package", packagesToLoad[i], sep = ":"), search()))
}

#### Importar Archivos ####
places.xml <- xmlParse(
 file = "places.xml"
)

prices.xml <- xmlParse(
  file = "prices.xml"
)

xmltop <- xmlRoot(places.xml) #gives content to root
xmltop[1] #Info 1 child node

class(xmltop)

xmlName(xmltop) #name of node: places
xmlSize(xmltop) #how many childs are in node: 12502

xmlSize(xmltop[[1]]) # number of nodes inside child 1: 3
xmlSApply(xmltop[[1]], xmlName) # name of nodes inside child 1: name, cred_id, location
xmlSApply(xmltop[[1]], xmlAttrs) # attributes of nodes inside child 1: NULL, NULL, NULL
xmlSApply(xmltop[[1]], xmlSize) # amount of elements inside child 1: 1, 1, 2

xmltop[[1]][[1]]
xmltop[[1]][[2]]
xmltop[[1]][[3]]


