# Installeren van packages en libraries ----

# Packages
install.packages("tidyverse")
install.packages("here")
install.packages("skimr")
install.packages("janitor")

# Libraries
library(here)
library(tidyverse)
library(lubridate)
library(skimr)
library(janitor)



# Laden van dataset ----

setwd("CSV")

# Originele dataset
online_retail <- read_csv2("Online Retail4.csv")


# Cleanen van de data ----

# Omzetten character datatype van InvoiceDate kolom naar datetime formaat
# Aanpassen kolomnaam naar lowercase
online_retail <- online_retail %>% 
  mutate(InvoiceDate = dmy_hms(InvoiceDate)) %>% 
  rename_with(tolower) %>% 
  clean_names()



# Analyseren van de data ----

# Onderstaande 7 stappen kunnen samen uitgevoerd worden om verschillende overzichten per land te krijgen en deze samen te voegen tot een tabel ----
# 1 Totaalbedrag per order door middel van quantity * unit price
online_retail_total <- online_retail %>% 
  mutate(totalvalue = quantity * unitprice)

# 2 Totale waarde van online orders per land
total_per_country <- online_retail_total %>% 
  group_by(country) %>% 
  summarize(total_of_all_orders = sum(totalvalue)) %>% 
  arrange(-total_of_all_orders)

# 3 Totaal aantal orders per land
orders_per_country <- online_retail_total %>% 
  group_by(country) %>% 
  summarize(total_orders = n_distinct(invoiceno)) %>% 
  arrange(-total_orders)

# 4 Aantal klanten per land
customers_per_country <- online_retail_total %>% 
  group_by(country) %>% 
  summarize(customers = n_distinct(customerid)) %>% 
  arrange(-customers)

# 5 Samenvoegen van mean_per_country, customers_per_country, orders_per_country, total_per_country
per_country_merge <- list(customers_per_country, orders_per_country, total_per_country)

complete_info_per_country <- per_country_merge %>% 
  reduce(full_join, by= "country")

# 6 Gemiddelde waarde per order per land
complete_info_per_country$mean_per_order <- 
  (complete_info_per_country$total_of_all_orders / complete_info_per_country$total_orders) 

# 7 Aanpassing van bedragen naar twee decimalen achter komma
complete_info_per_country <- complete_info_per_country %>% 
mutate_if(is.numeric, ~round(., 2))



# Overzicht aantal orders en totaalbedrag per klant
overview_per_customer <- online_retail_total %>% 
  group_by(customerid, country) %>% 
  drop_na() %>% 
  summarize(total_orders = n_distinct(invoiceno), total_value = sum(totalvalue))

