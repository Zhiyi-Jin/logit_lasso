### Logistic Regression Models with a Lasso Penalty   

This is a project focusing on logistic regression with a Lasso Penalty. European Social Survey data is used to explore the predictors of voting behavior in Sweden, specifically voting for the populist right party, Sverigedemokraterna, a.k.a, the Sweden Democrats.      

The main dependent variable is votesd, a 0/1 indicator of whether the ESS respondent voted for the Sweden Democrats in the preceding election. The data are contained in the file ``ess2016se.csv``.
           
There are four main parts in the analysis:       
1. Selecting and reasoning likely predictors of voting for the Sweden Democrats in combination with a skim of the ESS “data protocol” included with ``ESS8_data_protocol`` file.
2. Fit a series of logistic regression models with a lasso penalty predicting the likelihood of voting for the Sweden Democrats.
3. Use cross validation in combination with lasso regression to examine the predictive accuracy of the lasso penalized models.
4. Using the same predictors estimating an ordinary ``glm`` model, and comparing these estimates to the estimates obtained using lasso penalized logistic regression.

Detailed analysis is contained in the ``report.pdf`` file.
