library(tidyverse)
library(leaflet)
library(leaflet.extras)
library(janitor)
library(htmlwidgets)
library(readxl)

test <- read_csv("nfm_unit_lengths.csv")

test %>% filter(unit == "ber_005") %>% leaflet() %>% addProviderTiles("Esri", group = "Streets") %>% addProviderTiles("Esri.WorldImagery", group = "Aerials") %>% addCircleMarkers(label = ~paste0(unit, ":", location), radius = 5, color = "dodgerblue", fillOpacity = 1) %>% addLayersControl(baseGroups = c("Streets", "Aerials"))

hab_data <- read_excel("ber_unit_lengths_completed.xls") %>% clean_names()

hab_dist <- hab_data %>% group_by(unit) %>% summarize(length = max(meas) - min(meas)) %>% ungroup() %>% mutate(length_feet = round(length * 3.28084, digits = 0)) %>% select(unit, length_feet) %>% write_csv(path = "hab_lengths.csv")

hab_data %>% leaflet() %>% addProviderTiles("Esri", group = "Streets") %>% addProviderTiles("Esri.WorldImagery", group = "Aerials") %>% addCircleMarkers(label = ~paste0(unit, ":", location), radius = 5, color = "dodgerblue", fillOpacity = 1) %>% addLayersControl(baseGroups = c("Streets", "Aerials"))


View(hab_dist)
