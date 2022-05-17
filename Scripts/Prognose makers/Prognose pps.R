# Prognose maker ----

# Laden van dataset

setwd("CSV")

# Originele dataset
overview_by_country <- read_csv2("overview_by_country.csv")

# BELANGRIJK Keuze maken voor land ----

chosen_country <- c("Austria")






selected_country <- overview_by_country %>% 
  filter(country == chosen_country)


# Creeren van prognose

# create a data frame to store your variables
df <- data.frame(
  year = (2008:2024),
  pps = c(selected_country$pps, rep(NA, 4))
)

# The lm function in R will exclude the observations with NA values while fitting the model
model.1 <- lm(formula = pps ~ year, data = df)


# tidy your model and include 95% confidence intervals
broom::tidy(model.1, conf.int = T)


# you can use the predict function as well for precise predictions
# get predictions for every X value
predict <- predict(object = model.1, newdata = df)


# Prediction toevoegen in nieuwe dataframe met originele waardes
complete <- df %>% 
  cbind(prediction = predict) %>% 
  mutate(country = chosen_country) %>% 
  mutate_if(is.numeric, ~round(., 0)) 

complete <- complete[, c(4,1,2,3)] # Ordenen van kolom landnaam eerst

# Controleren correlatie tussen data en prediction
correlation <- complete %>% 
  na.omit(complete) 

cor(correlation$pps, correlation$prediction)


# Data wegschrijven naar excel
write_xlsx(complete, "filename.xlsx")




# Plots ----

ggplot(data = online_purchases_by_individuals) + 
  geom_point(mapping = aes(x = year, y = individuals_purchasing_online_in_percentage, color = country))


ggplot(data = online_purchases_by_individuals %>% 
         filter(country %in% c("Austria", "Belgium", "Netherlands", "France"))) + 
  geom_line(mapping = aes(x = year, y = individuals_purchasing_online_in_percentage, color = country)) +
  theme_minimal()


smoothplot <- online_purchases_by_individuals %>% 
  filter(country %in% c("Austria", "Belgium", "Netherlands", "France")) %>% 
  ggplot(mapping = aes(x = year, y = individuals_purchasing_online_in_percentage, color = country)) +
  geom_smooth() +
  facet_wrap(~country) +
  theme_minimal()

smoothplot + 
  labs(title = "Online Shoppers: percentage per jaar", subtitle = "Percentage van bevolking met minimaal een online aankoop", caption = "Data afkomstig van Eurostat")



ggsave("Online Shoppers.svg")








