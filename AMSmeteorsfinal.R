##==================== AMS.METEORS.ORG ====================#

##########################################################
##### Iniciando la extracci?n de informaci?n general #####
##########################################################
library(rvest)

# Se asigna la p?gina de ams.meteors.org/firelogs
webpage<- 'https://www.amsmeteors.org/about/'

webpage <- read_html(webpage)

# Extrayendo contenido en la clase About AMS
contenidoWebaboutus <- html_nodes(webpage,'.post-2')

# Pasando la info a texto
textoNoticia <- html_text(contenidoWebaboutus)

# Viendo a priori la info en la variable textoNoticia
print(textoNoticia)

# Eliminando los \n,comillas("),puntos(.) y comas(,) del texto
textoNoticia <- gsub("\n","",textoNoticia)
textoNoticia <- gsub("\"","",textoNoticia)
textoNoticia <- gsub("[.]","",textoNoticia)
textoNoticia <- gsub(",","",textoNoticia)
textoNoticia <- gsub("-","",textoNoticia)
textoNoticia <- gsub("'","",textoNoticia)
textoNoticia <- gsub(":","",textoNoticia)
textoNoticia <- gsub(";","",textoNoticia)

# Viendo la info en la variable textoNoticia limpia
print(textoNoticia)

# Separando las palabras por espacio
splitEspacioNoticia <- strsplit(textoNoticia," ")[[1]]

# Pasando todas las palabras a min?sculas
splitEspacioNoticia <- tolower(splitEspacioNoticia)

# Contando palabras
unlistNoticias<-unlist(splitEspacioNoticia)
tablaPalabras<-table(unlistNoticias)

# Pasando la informaci?n a un data frame
dfPalabrasNoticia <- as.data.frame(tablaPalabras)

# Almacenando la informaci?n en CSV
write.csv(dfPalabrasNoticia, file="PalabrasNoticia.csv")

# almacenando info en un txt
write.table(dfPalabrasNoticia, file="PalabrasNoticia.txt")

##########################################################
######## Iniciando la extracci?n de avistamientos ########
##########################################################

fullTable <- data.frame()

for (i in 1:50) {
  # Se asigna la p?gina de ams.meteors.org/firelogs
  Fireball <- paste("https://www.amsmeteors.org/members/imo_view/browse_events?country=-1&year=2018&num_report=-99&page=",i,sep = "")
  
  print(Fireball)
  
  Fireball <- read_html(Fireball)
  
  # Extrayendo contenido en la clase registro de avistamientos
  tablainfo <- html_nodes(Fireball,"table")
  
  # Extraccion informacion tabla 
  tabla1 <- html_table(tablainfo,fill = TRUE)
  
  # Convierte a data.frame
  dfTabla <- data.frame(tabla1)
  
  # Elimina datos malos
  dfTabla <- dfTabla[-c(1), ]
  dfTabla$NA.<- NULL
  dfTabla$NA..1 <- NULL
  dfTabla$NA..2 <- NULL
  
  # Viendo la info del dataframe limpia
  print(dfTabla)
  
  fullTable <- rbind(fullTable,dfTabla)
  
  # Eliminando elementos repetidos
  fullTable <- unique(fullTable)
  
  # Almacenando la informaci?n en CSV
  write.csv(fullTable, file="TablaCompletareportes.csv")
  
}



##########################################################
######## Iniciando la extracci?n de usuarios #############
##########################################################

Tablacompleta <- data.frame()

for (i in 1:7) {
  # Se asigna la p?gina de ams.meteors.org/observations/
  Users <- paste("https://www.amsmeteors.org/observations/",i,sep = "")
  
  print(Users)
  
#Leyendo p?gina
Users <- read_html(Users)

# Extrayendo contenido en la Observaciones Table Responsive
tabla <- html_nodes(Users,".table-responsive")

# Extrayendo contenido en la clase tabla respuestas
tablainfo <- html_nodes(tabla,"table")


# Extracci?n informacion tabla 
tabla1 <- html_table(tablainfo)

# Convierte a data.frame
dfusuarios <- data.frame(tabla1)

# Elimina datos malos
dfusuarios <- dfusuarios[-c(1), ]
dfusuarios$NA.<- NULL
dfusuarios$NA..1 <- NULL
dfusuarios$NA..2 <- NULL

# Viendo a priori la info en la variable textoNoticia
print(dfusuarios)

Tablacompleta <- rbind(Tablacompleta,dfusuarios)

# Eliminando elementos repetidos
Tablacompleta <- unique(Tablacompleta)

# Almacenando la informaci?n en CSV
write.csv(Tablacompleta, file="TablaCompletausuarios.csv")

}


