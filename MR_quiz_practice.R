###Re-doing regression quiz

library(tidyverse)

##load data
my.data <- read_csv("reg_quiz2_data.csv")

#glimpse(my.data)

##get descriptives
apa.cor.table(my.data)

##save apa table
apa.cor.table(my.data, filename="Table1_quiz8.doc", table.number=1)

##check for curvilinear relationship
psych::pairs.panels(as.data.frame(my.data))

#predicting academic success with positive affect
my.regression <- lm(aSuc ~ PAS, data=my.data)
print(my.regression)
summary(my.regression)
apa.reg.table(my.regression)

# a. predicting academic success with self esteem above and beyond PAS
my.regression.a <- lm(aSuc ~ PAS + selfEsteem, data=my.data)
print(my.regression.a)
summary(my.regression.a)
apa.reg.table(my.regression.a)

# b. predicting academic success with self esteem above and beyond NAS
my.regression.b <- lm(aSuc ~ NAS + selfEsteem, data=my.data)
print(my.regression.b)
summary(my.regression.b)
apa.reg.table(my.regression.b)

#c. predicting academic success with self esteem above and beyond NAS and PAS
block1 = lm(aSuc~NAS+PAS,data=my.data)

apa.reg.table(block1)

block2 = lm(aSuc~NAS+PAS+selfEsteem,data=my.data)

apa.reg.table(block1, block2)

apa.reg.table(block1, block2, filename="Table4_quiz8.doc", table.number=4)
