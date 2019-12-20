# prediction.R
#
# testing and doing predicions with R on the dataset

# intuitive dag
g2 <- graphLayout(dagitty('dag {
AGE_AVG [pos="1.252,-0.085"]
BUSINESS_REL [pos="-0.605,-0.064"]
CRIME_TOTAL [outcome,pos="-0.044,-0.038"]
DENS_POP [pos="-0.923,-0.081"]
ENERGY_AVG [pos="-1.356,-0.049"]
FEMALE_PCT [pos="0.697,-0.071"]
HH_SIZE [pos="-1.232,-0.063"]
INCOME_LOW40PCT [pos="1.256,-0.074"]
MARRIED_PCT [pos="0.312,-0.077"]
PERC_IMMIGRATION_ORIG [pos="-0.849,-0.040"]
PUB_SERV [pos="-0.149,-0.079"]
SOCSEC_PCT [pos="1.175,-0.042"]
AGE_AVG -> INCOME_LOW40PCT
AGE_AVG -> MARRIED_PCT
BUSINESS_REL -> PUB_SERV
DENS_POP -> BUSINESS_REL
DENS_POP -> HH_SIZE
DENS_POP -> PUB_SERV
FEMALE_PCT -> CRIME_TOTAL
FEMALE_PCT -> SOCSEC_PCT
HH_SIZE -> ENERGY_AVG
HH_SIZE -> PUB_SERV
INCOME_LOW40PCT -> CRIME_TOTAL
INCOME_LOW40PCT -> SOCSEC_PCT
MARRIED_PCT -> CRIME_TOTAL
MARRIED_PCT -> SOCSEC_PCT
PERC_IMMIGRATION_ORIG -> CRIME_TOTAL
PERC_IMMIGRATION_ORIG -> ENERGY_AVG
PERC_IMMIGRATION_ORIG -> MARRIED_PCT
PUB_SERV -> CRIME_TOTAL
SOCSEC_PCT -> CRIME_TOTAL
}

'))
plot(g2)
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
dscale = as.data.frame(scale(d))
#sapply(d, class) 

impliedConditionalIndependencies(g2)
#a lot of implied conditional independencies implied by the network
# lets test some of them:
summary(lm(AGE_AVG ~ CRIME_TOTAL + INCOME_LOW40PCT + MARRIED_PCT + PERC_IMMIGRATION_ORIG, as.data.frame(scale(d))))
summary(lm(AGE_AVG ~ BUSINESS_REL, as.data.frame(scale(d))))
summary(lm(CRIME_TOTAL ~ DENS_POP + PUB_SERV, as.data.frame(scale(d))))
# the result shows that the coefficients are not 0, which they should be!
# lets test them all
# we conclude this network reuires removal/addition of paths 
# source finalDag.R for the final dag
source("finalDags.R")
g2 <- gtemp
localTests(g2, as.data.frame(scale(d)))
lvsem <- toString(g2, "lavaan")
lvsem.fit <- sem(lvsem, as.data.frame(scale(d)))
lavaanPlot(model = lvsem.fit, coefs = T)
summary(lvsem.fit)
M <- lavCor(as.data.frame(scale(d)))
localTests(g2, sample.cov = M, sample.nobs = nrow(as.data.frame(scale(d))))
fit2 <- sem(toString(g2, "lavaan"), sample.cov = M, sample.nobs = nrow(as.data.frame(scale(d))))
summary(fit2)
datascaled <- as.data.frame(scale(d))
predict.dens <- predict(lvsem.fit,node="DENS_POP", data=datascaled[,"CRIME_TOTAL",drop=F],method="bayes-lw")
#do predictions
net1 <- model2network(toString(g2, "bnlearn"))
fit1 <- bn.fit(net1, datascaled)
predict.crime <- predict(fit1, node="DENS_POP",data=datascaled[,"CRIME_TOTAL",drop=F],method="bayes-lw")

plot(datascaled[,"CRIME_TOTAL"],predict.crime)
abline(h = c(0,0.5,1,1.5,2),  lty = 2, col = "grey")
abline(v = -1:25,  lty = 2, col = "grey")
grid(nx=19, ny=19)


# re-test of the incomce category to use in the dag
# use glm
# for income cats
minc <- glm(CRIME_TOTAL ~ INCOME_AVG + INCOME_HIGH20PCT + INCOME_LOW + INCOME_LOW40PCT + INCOME_SOCMIN, family="binomial", data = cbsData)
summary(minc)


