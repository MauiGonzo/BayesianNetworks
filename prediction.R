

g <- graphLayout(dagitty('dag {
AGE_AVG [pos="1.252,-0.085"]
BUSINESS_REL [pos="-0.605,-0.064"]
CRIME_TOTAL [outcome,pos="-0.044,-0.038"]
DENS_POP [pos="-0.923,-0.081"]
ENERGY_AVG [pos="-1.356,-0.049"]
FEMALE_PCT [pos="0.474,-0.069"]
HH_SIZE [pos="-1.232,-0.063"]
INCOME_LOW40PCT [pos="1.256,-0.074"]
MARRIED_PCT [pos="0.312,-0.077"]
PERC_IMMIGRATION_ORIG [pos="-0.849,-0.040"]
SOCSEC_PCT [pos="1.175,-0.042"]
PUB_SERV [pos="-0.149,-0.079"]
AGE_AVG -> INCOME_LOW40PCT
DENS_POP -> BUSINESS_REL
DENS_POP -> PUB_SERV
FEMALE_PCT -> CRIME_TOTAL
FEMALE_PCT -> INCOME_LOW40PCT
HH_SIZE -> ENERGY_AVG
INCOME_LOW40PCT -> CRIME_TOTAL
INCOME_LOW40PCT -> MARRIED_PCT
INCOME_LOW40PCT -> SOCSEC_PCT
MARRIED_PCT -> CRIME_TOTAL
PERC_IMMIGRATION_ORIG -> CRIME_TOTAL
PERC_IMMIGRATION_ORIG -> ENERGY_AVG
SOCSEC_PCT -> CRIME_TOTAL
PUB_SERV -> CRIME_TOTAL
}
'))
plot(g)



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

impliedConditionalIndependencies( g)

#test independence using a linear regression. (CRIME_TOTAL _||_ DENS | PUB_)
summary( lm( CRIME_TOTAL ~ DENS_POP + PUB_SERV, as.data.frame(d) ) )

#The coefficient of DENS_POP in this regression should be 0, but it clearly isn't. So there seems to be a
#mistake in this network. 

localTests(g,d ,type = 'cis.chisq')

##Based on the result of the test we need to make some changes in our dag

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

impliedConditionalIndependencies(g2)
#a lot of implied conditional independencies implied by the network
# lets test some of them:
summary(lm(AGE_AVG ~ CRIME_TOTAL + INCOME_LOW40PCT + MARRIED_PCT + PERC_IMMIGRATION_ORIG, as.data.frame(scale(d))))
summary(lm(AGE_AVG ~ BUSINESS_REL, as.data.frame(scale(d))))
summary(lm(CRIME_TOTAL ~ DENS_POP + PUB_SERV, as.data.frame(scale(d))))
# the result shows that the coefficients are not 0, which they should be!
# lets test them all
# localTests(g2, as.data.frame(scale(d)), type = 'cis.chisq')
localTests(g2, as.data.frame(scale(d)))
lvsem <- toString(g2, "lavaan")
lvsem.fit <- sem(lvsem, as.data.frame(scale(d)))
lavaanPlot(model = lvsem.fit, coefs = T)
# create new dag, in which HH_S is connected to CRIME_TOTAL
g3 <- dagitty('dag {
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
  HH_SIZE -> CRIME_TOTAL
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
}' )
plot(g3)
localTests(g3, as.data.frame(scale(d))) 
# looks better
# compare:
net <- model2network(toString(g3,"bnlearn"))
fit <- bn.fit(net, as.data.frame(scale(d)))
fit
# lets try this one
predict.read <- predict(fit, node = CRIME_TOTAL)

#I could not get the result
# maurice: me neither
localTests(g2,d ,type = 'cis.chisq')




net <- model2network(toString(g2,"bnlearn"))
fit <- bn.fit( net, d )
fit

# We want to get predictions for all possible  values.
# we can predict the CRIME_TOTAL grades from the INCOME_AVG (one of its parent)
predicted.crime_income <- predict(fit,node="CRIME_TOTAL",data=d[,"INCOME_LOW40PCT",drop=F],method="bayes-lw")
plot(d[,"INCOME_LOW40PCT"],predicted.crime_income)

# we can predict the CRIME_TOTAL grades from the FEMALE_PCT (one of its parent)
predicted.crime_female <- predict(fit,node="CRIME_TOTAL",data=d[,"FEMALE_PCT",drop=F],method="bayes-lw")
plot(d[,"FEMALE_PCT"],predicted.crime_female)

# we can predict the CRIME_TOTAL grades from the MARRIED_PCT (one of its parent)
predicted.crime_married <- predict(fit,node="CRIME_TOTAL",data=d[,"MARRIED_PCT",drop=F],method="bayes-lw")
plot(d[,"MARRIED_PCT"],predicted.crime_married)


# we can predict the CRIME_TOTAL grades from the PERC_IMMIGRATION_ORIG (one of its parent)
predicted.crime_immigration <- predict(fit,node="CRIME_TOTAL",data=d[,"PERC_IMMIGRATION_ORIG",drop=F],method="bayes-lw")
plot(d[,"PERC_IMMIGRATION_ORIG"],predicted.crime_immigration)


# we can predict the CRIME_TOTAL grades from the DENS_POP (one of its ancestors)
predicted.crime_density <- predict(fit,node="CRIME_TOTAL",data=dscale[,"DENS_POP",drop=F],method="bayes-lw")
plot(dscale[,"DENS_POP"],predicted.crime_density)

predicted.crime_income <- predict(fit,node="CRIME_TOTAL",data=d[,"HH_SIZE",drop=F],method="bayes-lw")
plot(d[,"HH_SIZE"],predicted.crime_density)

# use glm
# for income cats
minc <- glm(CRIME_TOTAL ~ INCOME_AVG + INCOME_HIGH20PCT + INCOME_LOW + INCOME_LOW40PCT + INCOME_SOCMIN, family="binomial", data = cbsData)
summary(minc)


