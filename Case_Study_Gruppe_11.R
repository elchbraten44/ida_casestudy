if(!require(install.packages("tidyverse")))
    if(!require(install.packages("readr")))
        if(!require(install.packages("data.table")))
            if(!require(install.packages("visdat")))
                if(!require(install.packages("stringr")))
                    
                    # Laden der Packages
                    library(tidyverse)
library(readr)
library(data.table)
library(stringr)
library(visdat)
# Korrektes working directory ergänzen
#Hilfreicher Link: https://github.com/raredd/regex
# https://stackoverflow.com/questions/19128821/how-to-read-a-txt-file-line-by-line-in-r-rstudio
#https://evoldyn.gitlab.io/evomics-2018/ref-sheets/R_strings.pdf

#Laut Bestandteile_Fahrzeuge_OEM1_Typ11:
#Komponenten: K4 (Karosserie); K3SG1 (Schaltung); K2LE1 (Sitze); K1BE1 (Motor)
#K1BE1 besteht aus T1,T2,T3,T4
#K2LE1 besteht aus T11,T14,T15
#K3SG1 besteht aus T21,T22,T23
#K4 besteht aus T30,T31,T32

#Bestandteile_Fahrzeuge_OEM1_Typ11
#Fahrzeuge_OEM1_Typ11


# .txt-files mit Standard Texteditor ohne Highlighting... öffnen !

# Import der Einzelteile
setwd("C:/Users/Samuel/code/ida_casestudy/Data/Einzelteil")

# Funktioniert nicht
T1_dirty = readLines("Einzelteil_T01.txt") %>% 
    gsub(pattern = '[:  :][:|:][:  :][:|:][:  :]', replace = ',') %>% 
    gsub(pattern = '[: :]', replace = '\n') 

for(i in 2:length(T1_dirty) ) {
    T1 = read.table(textConnection(T1_dirty[i]), sep = ",", header = T)
}

rm(T1_dirty)



# Erledigt
T2_dirty = readLines("Einzelteil_T02.txt") %>% 
    gsub(pattern = '  ', replace = ',') %>% 
    gsub(pattern = '    ', replace = '\n')

for(i in 2:length(T2_dirty)) {
    T2 = read.table(textConnection(T2_dirty[i]), sep = ",", header = T)
}




# Erledigt, aber
# Einlesen von Bauteil T3 ggf read.table ersetzen durch schnellere Funktion
# Überprüfen, ob das aus der txt kopierte Sonderzeichen auf allen PCs gleichermaßen erkannt wird
T3_dirty = readLines("Einzelteil_T03.txt") %>%
    gsub(pattern = '', replace = '\n', .) %>%
    gsub(pattern = '\\|', replace = ',', .)

for (i in 2:length(T3_dirty) ) {
    T3 = read.table(textConnection(T3_dirty[i]), sep=",", header = T)
}



# Erledigt
T4 = read.csv2("Einzelteil_T04.csv", stringsAsFactors = F)


# Erledigt
T11_dirty = readLines("Einzelteil_T11.txt") %>% 
    gsub(pattern = '', replace = '\n', .) %>% 
    gsub(pattern = '\t', replace = ',')

#Zeilennummerierung wird entfernt
for(n in 2:length(T11_dirty)) {
    T11 = read.table(textConnection(T11_dirty[n]), sep = ",", header = T)
}


# Erledigt
T14 = read.csv2("Einzelteil_T14.csv", stringsAsFactors = F)
T15 = read.csv2("Einzelteil_T15.csv", stringsAsFactors = F)
T21 = read.csv2("Einzelteil_T21.csv", stringsAsFactors = F)



# Zeilenumbruch = '' fehlender Abstand
T22_dirty = readLines("Einzelteil_T22.txt") %>% 
    gsub(pattern = '', replace = "\n") %>% 
    gsub(pattern = '    ', replace = ',')

for(i in 2:length(T22_dirty)) {
    T22 = read.table(textConnection(T22_dirty[n]), sep = ",", header = T)
    
}



# Erledigt
T23 = read.csv2("Einzelteil_T23.csv", stringsAsFactors = F)
T30 = read.csv("Einzelteil_T30.csv", stringsAsFactors = F)



#???
T31_dirty = readLines("Einzelteil_T31.txt") %>% 
    gsub(pattern = '', replace = '\n') %>% 
    gsub(pattern = '  ', replace = ',')

for(m in 2:length(T31_dirty) ) {
    T31 = read.table(textConnection(T3_dirty[m]), header = T)
}


# Erledigt
T32 = read.csv2("Einzelteil_T15.csv", stringsAsFactors = F)





#Import der Komponenten-Datensätze
#GK_Komponentennummer: Komponente als ganzes
#Bestandteile_Komponentennummer: Einzelteile der jeweiligen Komponente
setwd("C:/Users/Samuel/code/ida_casestudy/Data/Komponente")

#Erledigt
GK_K1BE1 = read.csv("Komponente_K1BE1.csv", stringsAsFactors = F)

#Erledigt
#Sonderzeichen an anderem Computer überprüfen (wird in R anders, als in Atom angezeigt)
GK_K2LE1_dirty = readLines("Komponente_K2LE1.txt") %>% 
    gsub(pattern = '', replace = '\n', perl = TRUE) %>% 
    gsub(pattern = 'II', replace = ',')

for(i in 2:length(GK_K2LE1)) {
    GK_K2LE1 = read.table(textConnection(GK_K2LE1_dirty[i]), sep=",", header = T)
}


#Erledigt
GK_K3SG1 = read.csv("Komponente_K3SG1.csv", stringsAsFactors = F)
GK_K4 = read.csv2("Komponente_K4.csv", stringsAsFactors = F)



#Erledigt
Bestandteile_K1BE1 = read.csv2("Bestandteile_Komponente_K1BE1.csv", stringsAsFactors = F)
Bestandteile_K2LE1 = read.csv2("Bestandteile_Komponente_K2LE1.csv", stringsAsFactors = F)
Bestandteile_K3SG1 = read.csv2("Bestandteile_Komponente_K3SG1.csv", stringsAsFactors = F)
Bestandteile_K4 = read.csv2("Bestandteile_Komponente_K4.csv", stringsAsFactors = F)



#_______________________________________________________________________________________

setwd("C:/Users/Samuel/code/ida_casestudy/Data/Fahrzeug")
getwd()
# Erledigt
Bestandteile_Fahrzeuge_OEM1_Typ11 = read.csv2("Bestandteile_Fahrzeuge_OEM1_Typ11.csv", stringsAsFactors = F)
Fahrzeuge_OEM1_Typ11 = read.csv("Fahrzeuge_OEM1_Typ11.csv", stringsAsFactors = F)

# Zusammenfügen:
OEM1_Typ11 = full_join(Bestandteile_Fahrzeuge_OEM1_Typ11, Fahrzeuge_OEM1_Typ11, by = "ID_Fahrzeug")
# Entfernen der ursprünglichen Datensätze
rm(Bestandteile_Fahrzeuge_OEM1_Typ11, Fahrzeuge_OEM1_Typ11)
# Entfernen unnötiger Spalten im Datensatz OEM1_Typ11
# "X.x", "X.y" und "X1" enthalten jew. nur die Zeilennummer
OEM1_Typ11$X.x = NULL
OEM1_Typ11$X.y = NULL
OEM1_Typ11$X1 = NULL

# Herstellernummer und Werksnummer irrelevant, da in Fahrzeug-ID enthalten
OEM1_Typ11$Herstellernummer = NULL
OEM1_Typ11$Werksnummer = NULL

vis_miss(OEM1_Typ11, warn_large_data = FALSE)
# Variable Fehlerhaft_Datum Prüfen
# Für alle Fahrzeuge, die nicht fehlerhaft sind hat Fehlerhaft_Datum den Wert NA