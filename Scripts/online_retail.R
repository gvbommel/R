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

# Omzetten van InvoiceDate kolom naar: datum zonder tijd in date format
online_retail <- online_retail %>% 
  separate(InvoiceDate, into = c("date"), sep = " ") %>% 
  mutate(date = dmy(date)) %>% 
  rename_with(tolower) %>% # Aanpassen kolomnaam naar lowercase
  clean_names()




# Analyseren van de data ----


# Totaalbedrag per orderregel toevoegen aan dataframe door middel van quantity * unit price
online_retail <- online_retail %>% 
  mutate(totalvalue = quantity * unitprice)


# Overzicht per land van:
complete_info_per_country <- online_retail %>% 
  group_by(country) %>% 
  summarize(customers = n_distinct(customerid), # Totaal aantal klanten
            total_orders = n_distinct(invoiceno), # Totaal aantal orders
            total_value = sum(totalvalue), # Totale waarde van alle orders 
            mean_per_order = (total_value / total_orders) # Gemiddelde waarde per order
            ) %>% 
  mutate_if(is.numeric, ~round(., 2)) 


# Overzicht aantal orders en totaalbedrag per klant
overview_per_customer <- online_retail %>% 
  group_by(customerid, country) %>% 
  drop_na() %>% 
  summarize(total_orders = n_distinct(invoiceno), total_value = sum(totalvalue))

summary <- complete_info_per_country %>% 
  summarize(total_orders = sum(total_orders), total_value = sum(total_value))


# Vizualiseren van de data ----

# Kolomdiagram gemiddelde per order per land
col_chart <- complete_info_per_country %>% 
  ggplot(aes(x = fct_reorder(country, mean_per_order), y = mean_per_order)) +
  geom_col() +
  labs(x = "country", y = " gemiddelde per order")

col_chart + coord_flip()

# Scatterpoint aantal orders ten opzichte van gemiddelde order prijs
overview_per_customer %>% 
  ggplot(aes(x = total_orders, y = total_value)) +
  geom_point()
  
