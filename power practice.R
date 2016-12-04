## power practice 

library(tidyverse)

# analysis plan A

#a) meta-analysis
# traditional power analysis
library(pwr)
pwr.r.test(r=.50,power=.80)
#need a sample size of 28 to reliably replicate the findings from the meta analysis 

#b) single published study
#need safeguard
psych::r.con(r=-.30, n=100)
# -0.4687942 -0.1100677
library(pwr)
pwr.r.test(r=-.11,power=.80)

#c) no estimate 
#traditional estimate 
library(pwr)
pwr.r.test(r=.07,power=.80)
#N = 1598

# analysis plan B

#b) single published study
#need safeguard
psych::r.con(r=-.30, n=100)
# -0.4687942 -0.1100677
psych::r.con(r=-.30, n=150)
# -0.4391480 -0.1467962
psych::r.con(r=-.30, n=200)

## N of 200 is needed so CI width will not be more than .30
