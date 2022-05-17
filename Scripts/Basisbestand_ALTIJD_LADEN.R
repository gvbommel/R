# Installeren van packages en libraries ----

# Packages
install.packages("tidyverse")
install.packages("here")
install.packages("skimr")
install.packages("janitor")
install.packages("broom")
install.packages("writexl")
install.packages("svglite")

# Libraries ----
library(here)
library(tidyverse)
library(lubridate)
library(skimr)
library(janitor)
library(broom)
library(writexl)
library(ggplot2)
library(svglite)

# Landen die gebruikt worden in analyse ----

eu_countries <- c("Austria", "Belgium", "Bulgaria", "Croatia", 
                 "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", 
                 "France", "Germany", "Greece", "Hungary", "Iceland",
                 "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg",
                 "Malta", "Netherlands", "North Macedonia", "Norway", 
                 "Poland", "Portugal", "Romania", "Slovakia", 
                 "Slovenia", "Spain", "Sweden", "Turkey", "United Kingdom")
