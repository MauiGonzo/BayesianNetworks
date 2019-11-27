# DENSITY vs CRIME_TOTAL

library(dagitty)
library(bnlearn)
cbsData[PEOPLE_PER_KM2] <- as.numeric(as.character(cbsData[,"PEOPLE_PER_KM2"]))
dcd <- as.data.frame(scale(cbsData[,c(PEOPLE_PER_KM2, "CRIME_TOTAL")]))
dcd <- na.omit(dcd)
dag1 <- graphLayout(dagitty("dag{PEOPLE_PER_KM2 -> CRIME_TOTAL}"))
#localTests(dag1, dcd)
#plot(dag1)
net1 <- model2network(toString(dag1,"bnlearn"))
fit1 <- bn.fit(net1, dcd)
predicted.PEOPLE_PER_KM2 <- predict(fit1,node="PEOPLE_PER_KM2",data=dcd[,"CRIME_TOTAL",drop=F],method="bayes-lw")
plot(dcd[,"PEOPLE_PER_KM2"],predicted.PEOPLE_PER_KM2)