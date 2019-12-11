

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
summary( lm( CRIME_TOTAL ~ DENS_POP + PUB_SERV, as.data.frame(d) ) )

#The coefficient of DENS_POP in this regression should be 0, but it clearly isn't. So there seems to be a
#mistake in this network. 

localTests(g,d ,type = 'cis.chisq')

#*AGE_ _||_ CRIM | FEMA, INCO 0.9750000000      41.000      21  5.607090e-03
#AGE_ _||_ MARR | INCO       0.2524689416   64751.000   62258  1.532782e-12
#AGE_ _||_ SOCS | INCO       0.2524689416   64688.000   62198  1.588367e-12
#BUSI _||_ CRIM | PUB_       0.2328858067   42690.419   41390  3.809132e-06
#*BUSI _||_ CRIM | DENS       0.5966625619    5203.000    4242  9.912549e-23
#*BUSI _||_ PUB_ | DENS       0.5996725428    6172.000    5072  7.618579e-25
#CRIM _||_ DENS | PUB_       0.2327412095   42333.592   41056  5.041281e-06
#*CRIM _||_ ENER | PERC       0.8208129789     758.500     527  1.372918e-10
#FEMA _||_ MARR | INCO       0.2526238047   64292.000   61805  1.445601e-12
#FEMA _||_ SOCS | INCO       0.2525273880   64224.500   61746  1.670236e-12
#MARR _||_ SOCS | INCO       0.2524653729   64529.000   62047  1.752736e-12

##Based on the result of the test we need to make some changes in our dag

g2 <- graphLayout(dagitty('dag {
AGE_AVG [pos="0.904,-0.084"]
BUSINESS_REL [pos="-0.605,-0.064"]
CRIME_TOTAL [outcome,pos="-0.365,-0.026"]
DENS_POP [pos="-0.420,-0.083"]
ENERGY_AVG [pos="-1.356,-0.049"]
FEMALE_PCT [pos="0.474,-0.069"]
HH_SIZE [pos="-1.232,-0.063"]
INCOME_AVG [pos="1.256,-0.074"]
MARRIED_PCT [pos="-0.141,-0.077"]
PERC_IMMIGRATION_ORIG [pos="-0.849,-0.040"]
PUB_SERV [pos="-1.275,-0.072"]
SOCSEC_PCT [pos="0.873,-0.025"]
AGE_AVG -> CRIME_TOTAL
AGE_AVG -> INCOME_AVG
BUSINESS_REL -> CRIME_TOTAL
BUSINESS_REL -> PUB_SERV
CRIME_TOTAL -> DENS_POP
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
PUB_SERV -> CRIME_TOTAL
SOCSEC_PCT -> CRIME_TOTAL
}
'))
plot(g2)

impliedConditionalIndependencies(g2)

#I could not get the result
#localTests(g2,d ,type = 'cis.chisq')




net <- model2network(toString(g,"bnlearn"))
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




