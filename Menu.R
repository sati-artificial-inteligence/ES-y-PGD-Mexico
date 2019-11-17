#### Installing packages ####

#String of packages required/needed
packagesToLoad <- c("XML", "plyr", "ggplot2", "gridExtra", "maps")

loadLibrarys(packagesToLoad) #Attach librarys
#detachLibrarys(packagesToLoad) #Detach librarys if needed

#### Importar Archivos ####
places.xml <- loadXMLFiles("places.xml")
prices.xml <- loadXMLFiles("prices.xml")

#xmltop <- xmlRoot(places.xml) #gives content to root
#xmltop[1] #Info 1 child node

#class(xmltop)

#xmlName(xmltop) #name of node: places
#xmlSize(xmltop) #how many childs are in node: 12502

#xmlSize(xmltop[[1]]) # number of nodes inside child 1: 3
#xmlSApply(xmltop[[1]], xmlName) # name of nodes inside child 1: name, cred_id, location
#xmlSApply(xmltop[[1]], xmlAttrs) # attributes of nodes inside child 1: NULL, NULL, NULL
#xmlSApply(xmltop[[1]], xmlSize) # amount of elements inside child 1: 1, 1, 2

#### Cargar Archivos ####
places.xml.df <- xmlToDataFrameFiles(places.xml)
prices.xml.df <- xmlToDataFrameFiles(prices.xml)

View(places.xml.df)
View(prices.xml.df)

colnames(gasolineras)
#### Manipulación de archivos ####
gasolineras <- unionXMLToDataFrameFiles(places.xml.df, prices.xml.df, ".attrs", "left") #Also reset if somethings goses wrong
View(gasolineras)

#x <- table(gasolineras$.attrs)
#x[1:10]

#str(gasolineras)
#colnames(gasolineras)
#test <- ChickWeight[-c(578),] 
eliminados <- c()

tryCatch({
  for(i in 1:(nrow(gasolineras)-1)){
    if(gasolineras$cre_id[i] == gasolineras$cre_id[i+1]){
      if(gasolineras$gas_price..attrs[i] == "regular"){
        if(is.na(gasolineras$gas_price.text.1[i])){
          if(gasolineras$gas_price..attrs[i+1] == "diesel"){
            gasolineras$gas_price.text.1[i] <- gasolineras$gas_price.text[i+1]
            gasolineras$gas_price..attrs.1[i] <- gasolineras$gas_price..attrs[i+1]
            #gasolineras <- gasolineras[-c(i+1),]
            eliminados <- paste(eliminados, i+1,collapse = "|")
            
          }
        }
        if (is.na(gasolineras$gas_price.text.2[i])){
          if(gasolineras$gas_price..attrs[i+1] == "premium"){
            gasolineras$gas_price.text.2[i] <- gasolineras$gas_price.text[i+1]
            gasolineras$gas_price..attrs.2[i] <- gasolineras$gas_price..attrs[i+1]
            #gasolineras <- gasolineras[-c(i+1),]
            eliminados <- paste(eliminados, i+1,collapse = "|")
          }
        }
      }
    }
  }
}
)
replace(eliminados, list = )

nrow(eliminados)

gasolineras <- gasolineras[-c(eliminados[2:length(eliminados)]),]













