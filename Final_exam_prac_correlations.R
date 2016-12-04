## practising correlations 

#load data
bfi2 <- read_csv("bfi2.csv")

glimpse(bfi2)

library(apaTables)
apa.cor.table(bfi2)

## comparing the correlation between A1/C1 and E1/O1
library(cocor)
cocor(~A1+C1|E1+O1, data=as.data.frame(bfi2) )

#Comparing correlation between (A1,C1 and E1,O1): The correlation between A1,C1 and E1,O1 is 
#delta r = -0.0099, 95% CI[-0.11,0.09], *p* = 0.85, N = 759.The CIs are fairly moderate.
#The difference of plausible range of values for these data range from -.11 to .09 
#(weak negative and weak postitive). 



## correlation within the same data set
# comparing  C1/A1 and E1/A1
cocor(~C1+A1|E1+A1, data=as.data.frame(bfi2) )

#Comparing correlation b/w overlapping: which predicts A1 better? The correlation between 
#(A1, C1) and (A1, E1) is delta r = -0.08, 95% CI [-.18, .02], *p* = .13, N = 764. 
#The CIs suggest a weak negative to no correlation.There is no meaningful difference.  
#But plausible difference could be from -.18 to .02.



## comparing A1/E1 for men and A1/E1 for women
bfi2_men <- bfi2 %>% filter(gender==1) %>% select(-gender)
bfi2_women <- bfi2 %>% filter(gender==2) %>% select(-gender)
bfi2_men <- as.data.frame(bfi2_men)
bfi2_women <- as.data.frame(bfi2_women)

cocor(~A1+E1|A1+E1, data=list(bfi2_men, bfi2_women))

#The correlation for (A1,E1) for men and correlation for (A1,E1) for women was delta r = .02, 
#95% CI [-.14, .17], *p* = .8, N = 777. There is no difference.


#is rating-raises different than rating-critical - how diff
#(j = rating, k = raises, h = critical)
#(r.jk = .59, r.jh = .16, r.kh = .38) n = 30
?cocor.dep.groups.overlap
cocor.dep.groups.overlap(.59, .16, .38, 30, alternative = "two.sided",
                         test = "all", alpha = 0.05, conf.level = 0.95, null.value = 0, 
                         data.name = NULL, var.labels = NULL, return.htest = FALSE)


#ratings-raises versus complaints-critical
#nonoverlapping
#(j = rating, k = raises, h = complaints, m = critical)
#(r.jk = .59, r.hm = .19, r.jh = .83, r.jm = .16, r.kh = .67, r.km = .38)  )
cocor.dep.groups.nonoverlap (.59, .19, .83, .16, .67, .38, 30, alternative = "two.sided",
                             test = "all", alpha = 0.05, conf.level = 0.95, null.value = 0, 
                             data.name = NULL, var.labels = NULL, return.htest = FALSE)


#Comparing indepedant correlations
#(r1.jk = .59, r2.hm = .03, also need Ns)
cocor.indep.groups(.59, .03, 30, 30000, alternative = "two.sided",
                   test = "all", alpha = 0.05, conf.level = 0.95, null.value = 0, 
                   data.name = NULL, var.labels = NULL, return.htest = FALSE)

