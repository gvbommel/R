# Laden van dataset

setwd("CSV")

# Originele dataset
breakdown <- read_csv2("online shoppers breakdown in last 3 months 2015_2021.csv") %>%   
  mutate(no_purchases = 100 - (purchases_1_or_2_times + purchases_3_to_5_times + purchases_6_to_10_times + purchases_more_than_10_times)) %>% 
  filter(year == 2021) %>% # Filter op jaar vanaf 2008
  filter(country %in% eu_countries) %>%   # Filter op de juiste Europese landen
  select(- year) %>% 
  pivot_longer(!"country", names_to = "amount", values_to = "percentage")

breakdown <- breakdown %>% 


ggplot(data = breakdown, aes(x = "", y = amount, fill = percentage) %>% 
         filter(country %in% c("Austria", "Belgium", "Netherlands", "France"))) + 
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0)
  facet_wrap(~country) +
  theme_minimal()
  
ggplot(data = breakdown %>% 
           filter(country %in% c("Austria", "Belgium", "Netherlands", "France"))) + 
    geom_bar(mapping = aes(x = percentage, fill = country)) +
    theme_minimal()
