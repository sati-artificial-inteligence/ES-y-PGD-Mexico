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


