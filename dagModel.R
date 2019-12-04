# dag model
# TODO: edit the variable names
library(daggity)

g <- daggity('dag {
Age [pos="-2.280,-0.022"]
AmountOfCompanies [pos="-0.842,-0.064"]
AreaSize [pos="-2.302,-0.065"]
AverageIncome [pos="1.071,-0.051"]
BirthRate [pos="-1.643,-0.023"]
CarUsage [pos="0.684,-0.071"]
CrimeRate [outcome,pos="1.255,-0.023"]
DeathRate [pos="-1.946,-0.022"]
Distance_to_public_services [pos="-0.090,-0.080"]
EnergyConsumption [pos="-0.240,-0.068"]
HousingSurplus [pos="-0.086,-0.039"]
IncomeDistribution [pos="0.662,-0.059"]
Marital_Status [pos="-1.049,-0.025"]
PopulationDensity [pos="-1.339,-0.066"]
PopulationSize [exposure,pos="-2.104,-0.042"]
PropertyValues [pos="-1.027,-0.052"]
Sex [pos="-1.256,-0.035"]
SocialSecurity [pos="1.339,-0.063"]
Types_of_Households [pos="-0.631,-0.043"]
Types_of_property [pos="-0.099,-0.053"]
Urbanization [pos="-1.207,-0.077"]
Age -> DeathRate
Age -> PopulationSize
AmountOfCompanies -> PropertyValues
AreaSize -> PopulationDensity
AreaSize -> PopulationSize
AverageIncome -> CrimeRate
BirthRate -> PopulationSize
CarUsage -> Distance_to_public_services
DeathRate -> PopulationSize
Distance_to_public_services -> CrimeRate
EnergyConsumption -> CrimeRate
HousingSurplus -> CrimeRate
IncomeDistribution -> AverageIncome
IncomeDistribution -> CarUsage
IncomeDistribution -> CrimeRate
IncomeDistribution -> SocialSecurity
PopulationDensity -> AmountOfCompanies
PopulationDensity -> Distance_to_public_services
PopulationDensity -> PropertyValues
PopulationDensity -> Urbanization
PopulationSize -> PopulationDensity
PopulationSize -> Sex
Sex -> CrimeRate
Sex -> Marital_Status
SocialSecurity -> CrimeRate
Types_of_Households -> EnergyConsumption
Types_of_Households -> PropertyValues
Types_of_property -> EnergyConsumption
Types_of_property -> Types_of_Households
}
')
