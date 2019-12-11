

g <- graphLayout(dagitty('dag {
AGE_AVG [pos="1.252,-0.085"]
BUSINESS_REL [pos="-0.605,-0.064"]
CRIME_TOTAL [outcome,pos="-0.044,-0.038"]
DENS_POP [pos="-0.923,-0.081"]
ENERGY_AVG [pos="-1.356,-0.049"]
FEMALE_PCT [pos="0.474,-0.069"]
HH_SIZE [pos="-1.232,-0.063"]
INCOME_AVG [pos="1.256,-0.074"]
MARRIED_PCT [pos="0.312,-0.077"]
PERC_IMMIGRATION_ORIG [pos="-0.849,-0.040"]
SOCSEC_PCT [pos="1.175,-0.042"]
PUB_SERV [pos="-0.149,-0.079"]
AGE_AVG -> INCOME_AVG
DENS_POP -> BUSINESS_REL
DENS_POP -> PUB_SERV
FEMALE_PCT -> CRIME_TOTAL
FEMALE_PCT -> INCOME_AVG
HH_SIZE -> ENERGY_AVG
INCOME_AVG -> CRIME_TOTAL
INCOME_AVG -> MARRIED_PCT
INCOME_AVG -> SOCSEC_PCT
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
  INCOME_AVG,
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

impliedConditionalIndependencies( g)

#test independence using a linear regression. (CRIME_TOTAL _||_ DENS | PUB_)
summary( lm( CRIME_TOTAL ~ DENS_POP + PUB_SERV, as.data.frame(scale(d)) ) )

#The coefficient of DENS_POP in this regression should be 0, but it clearly isn't. So there seems to be a
#mistake in this network. 

localTests(g,d ,type = 'cis.chisq')

net <- model2network(toString(g,"bnlearn"))
fit <- bn.fit( net, as.data.frame(scale(d)) )
fit

#If, on the other hand, we want to perform prediction , it is better to use the raw,
#unscaled data. That way, our predictions will be on the original grade scale (from 1 to 100).
fit <- bn.fit( net, d )
fit


# We want to get predictions for all possible  values.
# we can predict the CRIME_TOTAL grades from the INCOME_AVG (one of its parent)
predict(fit,node="CRIME_TOTAL", data=data.frame(INCOME_AVG=as.double(1:100)), method="bayes-lw")

# we can predict the CRIME_TOTAL grades from the FEMALE_PCT (one of its parent)
predict(fit,node="CRIME_TOTAL", data=data.frame(FEMALE_PCT=as.double(1:100)), method="bayes-lw")

# we can predict the CRIME_TOTAL grades from the MARRIED_PCT (one of its parent)
predict(fit,node="CRIME_TOTAL", data=data.frame(MARRIED_PCT=as.double(1:100)), method="bayes-lw")

# we can predict the CRIME_TOTAL grades from the PERC_IMMIGRATION_ORIG (one of its parent)
predict(fit,node="CRIME_TOTAL", data=data.frame(PERC_IMMIGRATION_ORIG=as.double(1:100)), method="bayes-lw")

# we can predict the CRIME_TOTAL grades from the DENS_POP (one of its ancestors)
predict(fit,node="CRIME_TOTAL", data=data.frame(DENS_POP=as.double(1:100)), method="bayes-lw")




