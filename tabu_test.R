# https://www.bnlearn.com/documentation/man/hc.html <- link for hc and tabu in one (almost the same)
library(bnlearn)
#setwd('/home/denise/Documents/Vakken/BN/BayesianNetworks')


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
###
testCBS <- cbsData[,-(1:4)]
testCBS[] <- lapply(testCBS, as.factor)
thing <- tabu(d)
thing

plot.new()
graphviz.plot(thing, shape = "ellipse", highlight = list(nodes = "CRIME_TOTAL" , col = "blue",textCol = "blue"))
