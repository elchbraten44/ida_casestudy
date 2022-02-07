setwd("C:/Users/Samuel/code/ida_casestudy/data/Logistikverzug")
getwd()
install.packages("plotly")
library(tidyverse)
library(plotly)


#Aufgabe 1
##Import der Daten für den Wareneingang
eingang = read.csv("Logistics_delay_K7.csv", head = TRUE)
##Entfernen der Zeilennummer (obsolet)
eingang = eingang[,2:6]
##Überpfüfung der Datentypen
mode(eingang$Wareneingang)
##Änderung des Datentyps des Wareneigangsdatums: character -> numeric
eingang$Wareneingang = as.Date(eingang$Wareneingang, format = "%Y-%m-%d")
mode(eingang$Wareneingang)


##Import des Datensatzes mit Infos zu den Produktionsdaten
produktion = read.csv("Komponente_K7.csv", head = TRUE, sep=";")
mode(produktion$Produktionsdatum)
##Entfernung der Zeilennummer + 
produktion = produktion[,2:6]
produktion$Produktionsdatum = as.Date(produktion$Produktionsdatum, format = "%Y-%m-%d")
mode(produktion$Produktionsdatum)
##Zusammenführung der Daten erfolgt mittels ID-Nummer (Überprüfung der Datentypen)
mode(eingang$IDNummer)
mode(produktion$IDNummer)
nrow(eingang)
nrow(produktion)


##Zusammenführung in einen Datensatz
logistik = merge(eingang, produktion, by = c("IDNummer","Herstellernummer","Werksnummer"))
rm(eingang,produktion)

##Hinzufügen einer Spalte für den Logistikverzug
logistik = data.frame(logistik, logistikverzug = as.double(logistik$Wareneingang-logistik$Produktionsdatum))
print(nrow(eingang) == nrow(produktion) & nrow(eingang) == nrow(logistik))


ggplot(logistik, aes(logistikverzug)) +
    geom_bar()


## 1. b)
max(logistik$logistikverzug)


## 1. c)
# Arithmetisches Mittel:
mean(logistik$logistikverzug)

# Median:
fivenum(logistik$logistikverzug)[3]

# Modus
names(which.max(table(logistik$logistikverzug)))



## 1. d)
plot_ly(x = logistik$logistikverzug, type = "histogram")


# Aufgabe 2
## S. Rmd-File




# Aufgabe 3
# Wie viele der Komponenten K7 landeten in Fahrzeugen, die in Wehr, Landkreis Waldshut zugelassen wurden? (3 Punkte)
setwd("C:/Users/Samuel/code/ida_casestudy/Data/Zulassungen")
getwd()

# Ist das der richtige Ort? Wehr (Baden) nicht in Zulassungstabelle vorhanden
# WEHR1 nach Tabelle Geodaten_Gemeinden_v1.2_2017-08-02_TrR
zulassungen = read.csv("Zulassungen_alle_Fahrzeuge.csv", head = TRUE, sep=";")
zulassungen = subset(zulassungen, subset = zulassungen$Gemeinden=="WEHR1")
# S. Stücklisten






