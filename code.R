library(tidyverse)
library(glmnet)
library(kableExtra)
library(tidymodels)
library(stargazer)
library(essurvey)
library(nnet)
library(modelr)

#load the data
dt <- read.csv("ess2016se.csv", header = T)

#remove irrelevant ID variable
n_dt <- select(dt, -idno)

#create x matrix of predictors and y vector of outcomes
x <- model.matrix(~., n_dt)
y <- x[, "votesd"]
x <- x[, -which(colnames(x) == "votesd")]

#fit a lasso regression
m_lasso <- glmnet(x, y, family = "binomial", alpha = 1)

#plot the coefficient paths as a function of λ values.
plot(m_lasso, xvar = "lambda")

#plot the predictive accuracy as a function of λ by cross validation
cv_lasso <- cv.glmnet(x, y, family = "binomial", alpha = 1, nfolds = 5)
plot(cv_lasso)

#extract coefficients within one standard error of the model with the minimum error.
coef_1se <- tidy(coef(cv_lasso, s = "lambda.1se")) %>% 
  rename(coef = value) %>% 
  mutate(oddsrat = exp(coef)) %>%
  mutate(oddspct = 100*(oddsrat - 1))

kbl(coef_1se, digits = 3, caption = "Table: Minimum predictive error coefficients") %>% 
  kable_classic() %>% 
  kable_styling(font_size = 15)

#estimate an ordinary glm model
#adjust variables
n_dt <- n_dt %>% 
  mutate(vteurmmb = na_if(vteurmmb, "33. Would submit a blank ballot paper"),
         vteurmmb = na_if(vteurmmb, "44. Would spoil the ballot paper"),
         vteurmmb = na_if(vteurmmb, "55. Would not vote"))

#fit the regression
lr <- glm(votesd ~ stfgov + imbgeco + imueclt + gvrfgap + rfgbfml
          + vteurmmb + occgrp, family = "binomial", data = n_dt)

#make the table
stargazer(lr, 
          title = "Table: Logistic Regression Result", 
          align = TRUE, 
          type = "html",
          header = FALSE,
          no.space = TRUE)
    
    
