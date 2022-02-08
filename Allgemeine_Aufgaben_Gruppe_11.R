setwd("C:/Users/Samuel/code/ida_casestudy/data/Logistikverzug")
getwd()
install.packages("plotly")
library(tidyverse)
library(plotly)
library(stringr)


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

# Das Histogramm ähnelt einer Normalverteilung. (Eventuell mit Zentralem Grenzwertsatz argumentieren?)
# Die additive Überlagerung der einzelnen Zufallseffekte der Lieferbedingungen könnte dazu führen, 
# dass die Lieferverzüge approximativ normalverteilt sind
# Es handelt sich um eine symmetrische Verteilung, da Modus=Median=Mittelwert
# Modus ist definiert, da unimodale Verteilung vorliegt

# Aufgabe 2
## S. Rmd-File




# Aufgabe 3
# Wie viele der Komponenten K7 landeten in Fahrzeugen, die in Wehr, Landkreis Waldshut zugelassen wurden? (3 Punkte)
setwd("C:/Users/Samuel/code/ida_casestudy/Data/Zulassungen")
getwd()
#K7 ist nur in den Modellen vom Typ22 enthalten!!!


# Ist das der richtige Ort? Wehr (Baden) nicht in Zulassungstabelle vorhanden
# WEHR1 nach Tabelle Geodaten_Gemeinden_v1.2_2017-08-02_TrR
zulassungen = read.csv("Zulassungen_alle_Fahrzeuge.csv", head = TRUE, sep=";")
#Entfernen der unnötigen ersten Spalte
zulassungen = zulassungen[,-1]

setwd("C:/Users/Samuel/code/ida_casestudy/Data/Fahrzeug")
Komponenten_Typ22 = read.csv2("Bestandteile_Fahrzeuge_OEM2_Typ22.csv")
Komponenten_Typ22 = Komponenten_Typ22[,-1]

# Filtern der Zulassungen auf Fahrzeuge aus WEHR1
zulassungen_wehr1 = subset(zulassungen, subset = zulassungen$Gemeinden=="WEHR1")
# Mit Datensatz zu Bestandtteilen joinen
fahrzeuge_mit_k7_wehr1 = inner_join(Komponenten_Typ22, zulassungen_wehr1, by=c("ID_Fahrzeug" = "IDNummer"))
nrow(fahrzeuge_mit_k7_wehr1)



#Aufgabe 4
glimpse(zulassungen)

#IDNummer: Character
#Gemeinden: Character
#Zulassung: Character (könnte mit as.Date(zulassungen$Zulassung, format= "%Y %d %m") sinnvoll formatiert werden)



#Aufgabe 5
#Lösung: siehe Rmd File


#Aufgabe 6
zugelassene_fahrzeuge_mit_K7 = inner_join(zulassungen, Komponenten_Typ22, by=c("IDNummer" = "ID_Fahrzeug"))
gesuchtes_Fahrzeug = subset(zugelassene_fahrzeuge_mit_K7, subset=(zugelassene_fahrzeuge_mit_K7$ID_Karosserie == "K7-114-1142-31")) 
print(gesuchtes_Fahrzeug$Gemeinden)
