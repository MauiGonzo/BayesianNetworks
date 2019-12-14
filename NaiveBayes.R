
install.packages(c("devtools","pROC","naivebayes"))

library(naivebayes)

d <- subset(cbsData, select = c(
  AGE_AVG,
  INCOME_LOW40PCT,
  BUSINESS_REL,
  CRIME_TOTAL,
  PUB_SERV,
  MARRIED_PCT,
  FEMALE_PCT,
  SOCSEC_PCT,
  DENS_POP,
  PERC_IMMIGRATION_ORIG,
  HH_SIZE,
  ENERGY_AVG) )

d <- as.data.frame(lapply(d,factor))

sapply(d, class) 
                      

m <- naive_bayes(CRIME_TOTAL ~ FEMALE_PCT + INCOME_LOW40PCT + MARRIED_PCT + PERC_IMMIGRATION_ORIG + PUB_SERV + SOCSEC_PCT,data=d)

m

 