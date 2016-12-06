
library(tidyverse)
library(apaTables)

my.data <- read_csv("reg_quiz2_data.csv")

reg_pas <- lm(aSuc~PAS, data=my.data)
summary(reg_pas)

apa.reg.table(reg_pas)

reg_plot <- ggplot(my.data, aes(x=PAS, y=aSuc))
reg_plot <- reg_plot + geom_point()
reg_plot <- reg_plot + theme_classic()
reg_plot <- reg_plot + geom_smooth(method="lm", se=TRUE)
print(reg_plot)

my.hist <- ggplot(my.data,aes(PAS))
my.hist <- my.hist + geom_histogram(aes(y= ..count..), binwidth=.25, fill="black", colour="black")
print(my.hist)
