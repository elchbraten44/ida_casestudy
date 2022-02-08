library(tidyverse)
library(readr)
library(data.table)
library(stringr)
# Korrektes working directory ergänzen
#Hilfreicher Link: https://github.com/raredd/regex


#Welche Einzelteile bzw. Komponenten sind verbaut?
#Laut Bestandteile_Fahrzeuge_OEM1_Typ11:
#Komponenten: K4 (Karosserie); K3SG1 (Schaltung); K2LE1 (Sitze); K1BE1 (Motor)
#K1BE1 besteht aus T1,T2,T3,T4
#K2LE1 besteht aus T11,T14,T15
#K3SG1 besteht aus T21,T22,T23
#K4 besteht aus T30,T31,T32

# Import der Einzelteile
setwd("C:/Users/Samuel/code/ida_casestudy/Data/Einzelteil")

#Import der Einzeltei-Datensätze
#Einlesen der Datensätze als Strings
#Mit Schleife durchiterieren --> Datensatz


#Sehr groß, schwer zu öffnen
T1_dirty = readLines("Einzelteil_T02.txt") 


#Keine Symbole für Zeilenumbruch
T2_unclean = read.Lines("Einzelteil_T02.txt") %>% 
    gsub(pattern = ' ')



# Einlesen von Bauteil T3 ggf read.table ersetzen durch schnellere Funktion
# Überprüfen, ob das aus der txt kopierte Sonderzeichen auf allen PCs gleichermaßen erkannt wird
T3_dirty = readLines("Einzelteil_T03.txt") %>%
    gsub(pattern = '', replace = '\n', .) %>%
    gsub(pattern = '\\|', replace = ',', .)

for (i in 1:length(T3_dirty) ) {
    T3 <- read.table(textConnection(T3_dirty[i]), sep=",", header = TRUE)
}


# csv2 -> sep = ";"
# Erledigt
T4 = read.csv2("Einzelteil_T04.csv", stringsAsFactors = F)


#Zeilenumbruch wenn kein Absatnd vorhanden
#Funktioniert nicht!
T11_unclean = readLines("Einzelteil_T11.txt") %>% 
    gsub(pattern = '', replace = '\n', .) %>% 
    gsub(pattern = "...???????????")
#Zeilennummerierung wird entfernt
for(n in 2:length(T11_unclean)) {
    T11 = read.table(textConnection(T11_unclean[n]), sep = " ", header = T)
}





# sep =";"
# Erledigt
T14 = read.csv2("Einzelteil_T14.csv")
T15 = read.csv2("Einzelteil_T15.csv")
T21 = read.csv2("Einzelteil_T21.csv")


# sep = " "
# Zeilenumbruch = '' fehlender Abstand
T22_dirty = readLines("Einzelteil_T22.txt") %>% 
    gsub(pattern = '', replace = "\n") %>% 
    gsub(pattern = ' ', replace = ',')



# Erledigt
T23 = read.csv2("Einzelteil_T23.csv")
T30 = read.csv("Einzelteil_T30.csv")



#???
T31_dirty = readLines("Einzelteil_T31.txt") %>% 
    gsub(pattern = '', replace = '\n', perl=TRUE) 

for (m in 2:length(T31_dirty) ) {
    T31 <- read.table(textConnection(T3_dirty[m]), header = TRUE)
}




# Erledigt
T32 = read.csv2("Einzelteil_T15.csv")









#Import der Komponenten-Datensätze
#GK_Komponentennummer: Komponente als ganzes
#Bestandteile_Komponentennummer: Einzelteile der jeweiligen Komponente
setwd("C:/Users/Samuel/code/ida_casestudy/Data/Komponente")

#Erledigt
GK_K1BE1 = read.csv("Komponente_K1BE1.csv")

#Erledigt
GK_K2LE1_dirty = readLines("Komponente_K2LE1.txt") %>% 
    gsub(pattern = '', replace = '\n', perl = TRUE) %>% 
    gsub(pattern = 'II', replace = ',')

for(i in 2:length(GK_K2LE1)) {
    GK_K2LE1 = read.table(textConnection(GK_K2LE1_dirty[i]), sep=",", header = TRUE)
}


#Erledigt
GK_K3SG1 = read.csv("Komponente_K3SG1.csv")
GK_K4 = read.csv2("Komponente_K4.csv")



#Erledigt
Bestandteile_K1BE1 = read.csv2("Bestandteile_Komponente_K1BE1.csv")
Bestandteile_K2LE1 = read.csv2("Bestandteile_Komponente_K2LE1.csv")
Bestandteile_K3SG1 = read.csv2("Bestandteile_Komponente_K3SG1.csv")
Bestandteile_K4 = read.csv2("Bestandteile_Komponente_K4.csv")




