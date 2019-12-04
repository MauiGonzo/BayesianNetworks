# dag model
# TODO: edit the variable names
library(daggity)

g <- daggity('dag {
Age [pos="-2.280,-0.022"]
BUSINESS_LOCATIONS [pos="-0.842,-0.064"]
LAND_SIZE [pos="-2.302,-0.065"]
AVG_INCOME_CAPITA [pos="1.071,-0.051"]
BIRTH_REL [pos="-1.643,-0.023"]
CAR_PER_HH [pos="0.684,-0.071"]
CRIME_TOTAL [outcome,pos="1.255,-0.023"]
MORTALITY_REL [pos="-1.946,-0.022"]
Distance_to_public_services [pos="-0.090,-0.080"]
AVG_ELECTRICITY_CONS [pos="-0.240,-0.068"]
EMPTY_HOUSE_PERC [pos="-0.086,-0.039"]
IncomeDistribution [pos="0.662,-0.059"]
MARRIED [pos="-1.049,-0.025"]
POP_DENSITY [pos="-1.339,-0.066"]
POPULATION [exposure,pos="-2.104,-0.042"]
AVG_HOUSE_VALUE [pos="-1.027,-0.052"]
SEX [pos="-1.256,-0.035"]
SocialSecurity [pos="1.339,-0.063"]
Types_of_Households [pos="-0.631,-0.043"]
Types_of_property [pos="-0.099,-0.053"]
Urbanization [pos="-1.207,-0.077"]
Age -> MORTALITY_REL
Age -> POPULATION
BUSINESS_LOCATIONS -> AVG_HOUSE_VALUE
LAND_SIZE -> POP_DENSITY
LAND_SIZE -> POPULATION
AVG_INCOME_CAPITA -> CRIME_TOTAL
BIRTH_REL -> POPULATION
CAR_PER_HH -> Distance_to_public_services
MORTALITY_REL -> POPULATION
Distance_to_public_services -> CRIME_TOTAL
AVG_ELECTRICITY_CONS -> CRIME_TOTAL
EMPTY_HOUSE_PERC -> CRIME_TOTAL
IncomeDistribution -> AVG_INCOME_CAPITA
IncomeDistribution -> CAR_PER_HH
IncomeDistribution -> CRIME_TOTAL
IncomeDistribution -> SocialSecurity
POP_DENSITY -> BUSINESS_LOCATIONS
POP_DENSITY -> Distance_to_public_services
POP_DENSITY -> AVG_HOUSE_VALUE
POP_DENSITY -> Urbanization
POPULATION -> POP_DENSITY
POPULATION -> SEX
SEX -> CRIME_TOTAL
SocialSecurity -> CRIME_TOTAL
Types_of_Households -> AVG_ELECTRICITY_CONS
Types_of_Households -> AVG_HOUSE_VALUE
Types_of_property -> AVG_ELECTRICITY_CONS
Types_of_property -> Types_of_Households
}
')
