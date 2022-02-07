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
mean(logistik$logistikverzug)

## 1. d)
plot_ly(x = logistik$logistikverzug, type = "histogram")

