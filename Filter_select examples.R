## filter and select practice 

##load data
my.data.sex <- read_csv("analytic_data.csv")

#filter by just males, choosing only neg_affect and pos_affect

male.affect.data <- select(my.data.sex, sex, neg_affect, pos_affect) 
male.affect.data <- filter(male.affect.data, sex == "Male")
View(male.affect.data)

#males with an extraversion score over 10
male.extra.data <- filter(my.data.sex, sex == "Male")
male.extra.data <- filter(my.data.sex, Extraversion>=10)
View(male.extra.data)

#anyone with extraversion score under 10 and posaffect score = 0
all.data <- filter(my.data.sex, Extraversion>=10, pos_affect == 0)
View(all.data)
