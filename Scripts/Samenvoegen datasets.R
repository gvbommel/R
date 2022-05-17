# LET OP: Altijd eerst basisbestand laden ----

setwd("CSV")

# Laden en filteren Percentage internet gebruikers per land per jaar ----

# Originele dataset
online_purchases_by_individuals <- read_csv2("internet_purchases_by_individuals.csv") %>% 
  filter(year < 2021) %>% 
  arrange(country)

# Laden en filteren populatie per jaar ----

populatie_vanaf_2008 <- read_csv2("populatie_per_land.csv") %>% 
  pivot_longer(!"country", names_to = "year", values_to = "population") %>% # Aanpassing van wide to long
  filter(year %in% c(2008:2020)) %>% # Filter op jaar vanaf 2008
  filter(country %in% eu_countries) %>% # Filter op de juiste Europese landen
  arrange(country)

# Laden en filteren van PPS per jaar ----
pps_per_jaar_vanaf_2008 <- read_csv2("gdp_per_capita_in_pps.csv") %>% 
  filter(year %in% c(2008:2020)) %>% # Filter op jaar vanaf 2008
  filter(country %in% eu_countries) %>% # Filter op de juiste Europese landen
  arrange(country)


# Invoegen van populatie en pps bij online purchases

overview_by_country <- cbind(online_purchases_by_individuals, populatie = populatie_vanaf_2008$population)
overview_by_country <- cbind(overview_by_country, pps = pps_per_jaar_vanaf_2008$pps)

# Aanmaken kolom aantal_online_shoppers en online_shoppers_pps_adjusted
overview_by_country <- overview_by_country %>% 
  mutate(aantal_online_shoppers = individuals_purchasing_online_in_percentage * populatie / 100) %>% 
  mutate(online_shoppers_pps_adjusted = aantal_online_shoppers * pps / 100) %>% 
  mutate_if(is.numeric, ~round(., 0)) 

# Opslaan als nieuwe dataset ----
write_csv2(overview_by_country, "overview_by_country.csv")
  


  