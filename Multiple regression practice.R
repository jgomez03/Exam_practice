### exam practice - multiple regression

library(tidyverse)

##load data
my.data <- read_csv("regLectureData.csv")

glimpse(my.data)

## get initial descriptives
library(apaTables)
apa.cor.table(my.data)

##check for curvililinear 
psych::pairs.panels(as.data.frame(my.data))

##create regression model
# use iq and age to predict VG score - combine IQ/age into y hat
my.regression <- lm(VidScore ~ age + iq, data=my.data)
print(my.regression)
summary(my.regression)

#R2 = .29, meaning 29% of the variance accounted for by the linear combo of these variables

##get more comprehensive output by using apa tables
apa.reg.table(my.regression, filename = "myRegressionTable.doc")

## predicting scores
# for a person who is 43 years old and has an IQ of 130 - what is the CI on this estimate?
x_axis_range <- data.frame(age = c(43),iq=c(130))
CI_data <- predict(my.regression,newdata = x_axis_range, interval = "confidence" , level = 0.95)
CI_data <- as.data.frame(cbind(x_axis_range, CI_data))
print(CI_data)

##predicting scores
# prediction interval 
x_axis_range <- data.frame(age = c(43), iq=c(130))
PI_data <- predict(my.regression,newdata = x_axis_range, interval = "prediction" , level = 0.95)
PI_data <- as.data.frame(cbind(x_axis_range, PI_data))
print(PI_data)
                           