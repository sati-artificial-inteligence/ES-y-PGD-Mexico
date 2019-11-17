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

#### Manipulación de archivos ####
gasolineras <- unionXMLToDataFrameFiles(places.xml.df, prices.xml.df, ".attrs", "left") #Also reset if somethings goses wrong
View(gasolineras)

#x <- table(gasolineras$.attrs)
#x[1:10]

#str(gasolineras)
#colnames(gasolineras)
#test <- ChickWeight[-c(578),] 
eliminados <- ""

tryCatch({
    for(i in 1:(nrow(gasolineras)-1)){
      if(gasolineras$cre_id[i] == gasolineras$cre_id[i+1]){
        if(gasolineras$gas_price..attrs[i] == "regular"){
          if(is.na(gasolineras$gas_price.text.1[i])){
            if(gasolineras$gas_price..attrs[i+1] == "diesel"){
              gasolineras$gas_price.text.1[i] <- gasolineras$gas_price.text[i+1]
              gasolineras$gas_price..attrs.1[i] <- gasolineras$gas_price..attrs[i+1]
              eliminados <- paste(eliminados, i+1,collapse = " ")
              
            }
          }
          if (is.na(gasolineras$gas_price.text.2[i])){
            if(gasolineras$gas_price..attrs[i+1] == "premium"){
              gasolineras$gas_price.text.2[i] <- gasolineras$gas_price.text[i+1]
              gasolineras$gas_price..attrs.2[i] <- gasolineras$gas_price..attrs[i+1]
              eliminados <- paste(eliminados, i+1,collapse = " ")
            }
          }
        }
      }
    }
  }
)

# Need to remove all the rows that are already used when i put the diesel row data into to the regualr row data
tempEliminados <- eliminados

tempEliminados <- sub(
  pattern = " ",
  replacement = "",
  x = tempEliminados
)

tempEliminados <- data.frame(
  "col" = strsplit(
    x = tempEliminados,
    split = " "
  )
)

tempEliminados$c..2....10....15....18....22....24....27....37....41....47... <- as.character(tempEliminados$c..2....10....15....18....22....24....27....37....41....47...)
names(tempEliminados)[1] <- "Col"

sub(
  pattern = ,
  replacement = tempEliminados,
  x = gasolineras
)
  gasolineras <- gasolineras[-c(tempEliminados[i]),]







