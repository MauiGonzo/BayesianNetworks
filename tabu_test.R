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
thing <- tabu(d, debug = TRUE, score = "loglik-g",maxp = 4, tabu = 12)
BIC(thing, d)
#possible parameters to adjust for: 
#   score (https://www.bnlearn.com/documentation/man/network.scores.html),
#   maxp (maximum number of parents of a node.)
#   tabu (length of the tabu-list)
#   max.tabu (a positive integer number, the iterations tabu search can perform without improving the best network score.)
#   max.iter 	(an integer, the maximum number of iterations.)

plot.new()
graphviz.plot(thing, shape = "ellipse", highlight = list(nodes = c("CRIME_TOTAL","FEMALE_PCT") , col = "blue",textCol = "blue"))
        
tabu_dag_temp <- 0      
for(i in 1:nrow(thing$arcs)){
  tabu_dag_temp[i] <- paste(toString(thing$arcs[i,1]) , '->' , toString(thing$arcs[i,2]), '\n')
}

tabu_nodes <- 0      
for(i in 1:nrow(thing$nodes)){
  tabu_nodes[i] <- paste(toString(thing$nodes[i]))
  }
tabu_dag_temp <- toString(tabu_dag_temp)
tabu_dag_temp
tabu_dag_temp <- gsub(',','', tabu_dag_temp)
dagtemp <- dagitty(paste('dag{', tabu_nodes, tabu_dag_temp, '}'))



