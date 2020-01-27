
#install.packages("pcalg")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

#BiocManager::install("RBGL")
#BiocManager::install("graph")
#BiocManager::install("Rgraphviz")

library(pcalg)

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

rowCount <-  nrow    (d)
columnName <- colnames(d)

pc.fit <- pc(suffStat = list(C = cor(d), n = rowCount), indepTest = gaussCItest, alpha=0.01, labels = columnName, verbose = TRUE)

if (require(Rgraphviz)) {
  ## show estimated CPDAG
  par(mfrow=c(1,2))
  iplotPC(pc.fit)
}
library(graph)
g<-pc.fit@graph
degree(g)
