library(tidyverse)

### load raw data
raw_data <- read_csv(file="lab_quiz_week2_data.csv")

### str raw data
str(raw_data)

### view raw data
View(raw_data)

### deal with missing values 
raw_data <- read_csv(file="lab_quiz_week2_data.csv",na=c("","NA","-999"))

### categorical variables to factors 
## create data set with just categorical variables
categorical_variables <- select(raw_data, univ, prog_year)

##convert into factor
# need to add levels 
categorical_variables$univ <- as.factor(categorical_variables$univ)
levels(categorical_variables$univ) <- list("Waterloo"=1,"Guelph"=2)

categorical_variables$prog_year <- as.factor(categorical_variables$prog_year)
levels(categorical_variables$prog_year) <- list("First Year"=1,"Second Year"=2,"Third Year"=3,"Fourth Year"=4,"Grad School"=5)

#create scale items
pos_affect_items <- select (raw_data, PA1, PA2, PA3, PA4, PA5)
dep_items <- select (raw_data, D1, D2, D3, D4, D5)
prog_sat_items <- select (raw_data, PS1, PS2, PS3, PS4, PS5)

age <- select(raw_data, age)

## check for out of range values using psych package
psych::describe(pos_affect_items) #there are out of range values
psych::describe(dep_items) #there are out of range values
psych::describe(prog_sat_items) #there are out of range values

pos_affect_items
dep_items
prog_sat_items

#set out of range values to NA (for scales WITH out of range values)
is_bad_value <- pos_affect_items<1 | pos_affect_items>7
pos_affect_items[is_bad_value] <- NA

is_bad_value <- dep_items<1 | dep_items>4
dep_items[is_bad_value] <- NA

is_bad_value <- prog_sat_items<1 | prog_sat_items>6
prog_sat_items[is_bad_value] <- NA

## flip reverse key items

#use 8 because scale starts at 1 and it's a 7 point scale
pos_affect_items <- mutate(pos_affect_items,PA1=8-PA1)
#View(pos_affect_items)

#use 5 because scale starts at 1 and it's a 4 point scale
dep_items <- mutate(dep_items,D4=5-D4)
dep_items <- mutate(dep_items,D5=5-D5)
#View(dep_items)

#use 5 because scale starts at 1 and it's a 6 point scale
prog_sat_items <- mutate(prog_sat_items,PS1=7-PS1)
prog_sat_items <- mutate(prog_sat_items,PS2=7-PS2)
#View(prog_sat_items)

## obtain scale score
pos_affect <- psych::alpha(as.data.frame(pos_affect_items) ,check.keys=FALSE)$scores
dep <- psych::alpha(as.data.frame(dep_items) ,check.keys=FALSE)$scores
prog_sat <- psych::alpha(as.data.frame(prog_sat_items), check.keys=FALSE)$scores

## combine everything into analytic data
# include categorical variables plus any scales 
analytic_data <- cbind(categorical_variables,age,pos_affect,dep,prog_sat)
analytic_data

##save data
write_csv(analytic_data,path="exam_prac_analytic_data_gomez.csv")

## tables and figures
#create a correlation table

library(apaTables)
analytic_data
apa.cor.table(analytic_data, filename="Table1.doc", table.number=1)


#create scatterplot 
pos_affect.dep <- qplot(pos_affect, dep,data=analytic_data)
print(pos_affect.dep)
cor.test(x=analytic_data$pos_affect,y=analytic_data$dep)
ggsave("Figure1.pdf")
