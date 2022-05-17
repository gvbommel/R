# Nederland ----


# create a data frame to store your variables
df <- data.frame(
  X = (2008:2024),
  Y = c(56, 63, 67, 69, 65, 69, 71, 71, 74, 79, 80, 81, 87, 89, rep(NA, 3))
)

# The lm function in R will exclude the observations with NA values while fitting the model
model.1 <- lm(formula = Y ~ X, data = df)

# get the model summary
summary(model.1)

# broom is an extremely useful package for handling models in R
# install.packages("broom")
install.packages("broom")
# tidy your model and include 95% confidence intervals
broom::tidy(model.1, conf.int = T)


# you can use the predict function as well for precise predictions
# get predictions for every X value
predict(object = model.1, newdata = df)


# get predictions for 2018 through 2022 
prediction_nl <- predict(object = model.1, newdata = subset(df, X >= 2022))






# Oostenrijk ----


# create a data frame to store your variables
df <- data.frame(
  X = (2008:2024),
  Y = c(37, 41, 42, 44, 48, 54, 53, 58, 58, 62, 60, 62, 66, 63, rep(NA, 3))
)


# The lm function in R will exclude the observations with NA values while fitting the model
model.1 <- lm(formula = Y ~ X, data = df)

# get the model summary
summary(model.1)

# broom is an extremely useful package for handling models in R
# install.packages("broom")
install.packages("broom")
# tidy your model and include 95% confidence intervals
broom::tidy(model.1, conf.int = T)


# you can use the predict function as well for precise predictions
# get predictions for every X value
predict(object = model.1, newdata = df)


# get predictions for 2018 through 2022 
prediction_au <- predict(object = model.1, newdata = subset(df, X >= 2022))



# correlatie

nl_waar <- c(56, 63, 67, 69, 65, 69, 71, 71, 74, 79, 80, 81, 87, 89)
nl_geschat <- c(58, 61, 63, 65, 67, 70, 72, 74, 76, 78, 80, 83, 85, 87)

cor(nl_geschat, nl_waar)

au_waar <- c(37, 41, 42, 44, 48, 54, 53, 58, 58, 62, 60, 62, 66, 63)
au_geschat <- c(39, 41, 44, 46, 48, 50, 52, 55, 57, 59, 61, 63, 65, 67)

cor(au_geschat, au_waar)