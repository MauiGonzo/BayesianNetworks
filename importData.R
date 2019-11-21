#### importData.R
# R-script for importing csv database


# install.packages("readr") # install module when you have not
library(readr)
install.packages("dplyr")# install module
library(dplyr) # run module

# import the data
cbsData <- read.csv("BaseLineOneRegion_mod.csv", sep = ";")

# cbsData <- read_delim("cbsData.csv", delim = ";") #returns a data frame
#tools
# use spec(...) to see the types, they are right now all char


# renmae and shape the data
colnames(cbsData)[1] <- "NAME" # translate Neighborhoods and neighborhoods  column name
colnames(cbsData)[2] <- "MUNICIPALLITY" # translate name column name
colnames(cbsData)[3] <- "REGIONTYPE"
colnames(cbsData)[4] <- "REGIONCODE"
colnames(cbsData)[5] <- "POPULATION"
colnames(cbsData)[6] <- "MALE"
colnames(cbsData)[7] <- "FEMALE"
colnames(cbsData)[8] <- "AGEGROUP_015"
colnames(cbsData)[9] <- "AGEGROUP_1525"
colnames(cbsData)[10] <- "AGEGROUP_2545"
colnames(cbsData)[11] <- "AGEGROUP_4565"
colnames(cbsData)[12] <- "AGEGROUP_65UP"
colnames(cbsData)[13] <- "UNMARRIED"
colnames(cbsData)[14] <- "MARRIED"
colnames(cbsData)[14] <- "MARRIED"
colnames(cbsData)[15] <- "SEPARATED"
colnames(cbsData)[16] <- "WIDOWED"
colnames(cbsData)[17] <- "WESTERN_ORIG"
colnames(cbsData)[18] <- "NONWESTERN_ORIG"
colnames(cbsData)[19] <- "MOROCCO_ORIG" #not use
colnames(cbsData)[20] <- "ABC_ORIG" #antillen bonaire curacao (etc)
colnames(cbsData)[21] <- "SURINAME_ORIG"
colnames(cbsData)[22] <- "TURKEY_ORIG"
colnames(cbsData)[23] <- "OTHER_ORIG"
colnames(cbsData)[24] <- "BIRTH_REL"
colnames(cbsData)[25] <- "MORTALITY_REL"
colnames(cbsData)[26] <- "HH_TOT" # household = hh
colnames(cbsData)[27] <- "SINGLE_HH_TOT"    #no use
colnames(cbsData)[28] <- "NOCHILD_HH_TOT"   #no use
colnames(cbsData)[29] <- "CHILD_HH_TOT"     #no use
colnames(cbsData)[30] <- "AVG_HH_SIZE"
colnames(cbsData)[31] <- "POP_DENSITY"
colnames(cbsData)[32] <- "AVG_HOUSE_VALUE"
colnames(cbsData)[33] <- "EMPTY_HOUSE_PERC"
colnames(cbsData)[34] <- "RENTAL_HOUSING_PERC"
colnames(cbsData)[35] <- "RENTAL_CORP_HOUSING_PERC"
colnames(cbsData)[36] <- "AVG_ELECTRICITY_CONS"
colnames(cbsData)[37] <- "AVG_GAS_CONS"
colnames(cbsData)[38] <- "AVG_INCOME_CAPITA"
colnames(cbsData)[39] <- "INCOME_LOW40PCT"
colnames(cbsData)[40] <- "INCOME_HIGH20PCT"
colnames(cbsData)[41] <- "INCOME_LOW"
colnames(cbsData)[42] <- "INCOME_SOCMIN"
colnames(cbsData)[43] <- "person_per type of benefit assistance" #wat is dat?
colnames(cbsData)[44] <- "SOCSEC_AO" #unfit for labor
colnames(cbsData)[45] <- "SOCSEC_WW" #unfit for work
colnames(cbsData)[46] <- "SOCSEC_AOW"
colnames(cbsData)[47] <- "BUSINESS_LOCATIONS"
colnames(cbsData)[48] <- "CAR_PER_HH"
colnames(cbsData)[49] <- "GEN_DIST_GP"
colnames(cbsData)[50] <- "GEN_DIST_SUPERMARKET"
colnames(cbsData)[51] <- "GEN_DIST_DAYCARE"
colnames(cbsData)[52] <- "GEN_DIST_SCHOOL"
colnames(cbsData)[53] <- "LAND_SIZE" #in ha
colnames(cbsData)[54] <- "PEOPLE_PER_KM2" #environmental density
colnames(cbsData)[55] <- "CRIME_BURGLARY_REL" #tot theft form home.. barn..ed???
colnames(cbsData)[56] <- "CRIME_PUB_ORDER_REL"
colnames(cbsData)[57] <- "CRIME_VIOLENCE_SEX_REL"

# tell R the names of the collumns
REGIONCODE 	<- names(cbsData)[4]
POPULATION 	<- names(cbsData)[5]
FEMALE 		<- names(cbsData)[7]
#etc
