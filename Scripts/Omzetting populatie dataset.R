# Laden dataset en aanpassingen ----

setwd("CSV")

populatie_vanaf_2008 <- read_csv2("populatie_per_land.csv") %>% 
  pivot_longer(!"country", names_to = "year", values_to = "population") %>% # Aanpassing van wide to long
  filter(year %in% c(2008:2020)) %>% # Filter op jaar vanaf 2008
  filter(country %in% eu_countries) # Filter op de juiste Europese landen

