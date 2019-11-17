#Funciones

#Load librarys
loadLibrarys <- function(librarys){
  #To load packages
  for(i in 1:length(librarys)){
    if(!require(librarys[i], character.only = TRUE)){
      install.packages(librarys, dependencies = TRUE)
      require(librarys[i], character.only = TRUE)
    }else{
      require(librarys[i], character.only = TRUE)
    }
  }
}

#Detach librarys
detachLibrarys <- function(librarys){
  for(i in 1:length(librarys)){
    detach(pos = match(paste("package", librarys[i], sep = ":"), search()))
  }
}

#Read files
loadXMLFiles <- function(fileName){
  fileName.xml <- xmlParse(
    file = fileName
  )
  return(fileName.xml)
}

#Convert to data frames xml files
xmlToDataFrameFiles <- function(fileName){
  fileName.df <- ldply(xmlToList(fileName), data.frame)
  fileName.df <- fileName.df[,2:length(fileName.df)]
  
  return(fileName.df)
}

#Unite the xml files
unionXMLToDataFrameFiles <- function(fileName1, fileName2, colName, typeName){
  
  joinFile <- join(
    x = fileName1,
    y = fileName2,
    by = colName,
    type = typeName,
    match = "all"
  )
  
  joinFile$name <- as.character(joinFile$name)
  joinFile$cre_id <- as.character(joinFile$cre_id)
  joinFile$location.x <- as.character(joinFile$location.x)
  joinFile$location.y <- as.character(joinFile$location.y)
  joinFile$.attrs <- as.character(joinFile$.attrs)
  joinFile$.attrs <- as.numeric(joinFile$.attrs)
  joinFile$gas_price.text <- as.character(joinFile$gas_price.text)
  joinFile$gas_price.text <- as.double(joinFile$gas_price.text)
  joinFile$gas_price..attrs <- as.character(joinFile$gas_price..attrs)
  joinFile$gas_price.text.1 <- as.character(joinFile$gas_price.text.1)
  joinFile$gas_price.text.1 <- as.double(joinFile$gas_price.text.1)
  joinFile$gas_price..attrs.1 <- as.character(joinFile$gas_price..attrs.1)
  joinFile$gas_price.text.2 <- as.character(joinFile$gas_price.text.2)
  joinFile$gas_price.text.2 <- as.double(joinFile$gas_price.text.2)
  joinFile$gas_price..attrs.2 <- as.character(joinFile$gas_price..attrs.2)
  
  return(joinFile)
}










