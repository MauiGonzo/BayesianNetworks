#### importData.R
# R-script for importing csv database


# import the data
# cbsData <- read.csv("./data/BaseLineOneRegion_mod.csv", sep = ";")
cbsData <- read.csv("./data/cbsData.csv", sep = ";")

#remove NA
cbsData <- na.omit(cbsData) 

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
colnames(cbsData)[30] <- "HH_SIZE"
colnames(cbsData)[31] <- "DENS_POP"
colnames(cbsData)[32] <- "HOUSE_VAL_AVG"
colnames(cbsData)[33] <- "VACANCY"
colnames(cbsData)[34] <- "RENTAL_HOUSING_PERC"
colnames(cbsData)[35] <- "RENTAL_CORP_HOUSING_PERC"
colnames(cbsData)[36] <- "AVG_ELECTRICITY_CONS"
colnames(cbsData)[37] <- "AVG_GAS_CONS"
colnames(cbsData)[38] <- "INCOME_AVG"
colnames(cbsData)[39] <- "INCOME_LOW40PCT"
colnames(cbsData)[40] <- "INCOME_HIGH20PCT"
colnames(cbsData)[41] <- "INCOME_LOW"
colnames(cbsData)[42] <- "INCOME_SOCMIN"
colnames(cbsData)[43] <- "SOCSEC_NO_INCOME" #bijstand
colnames(cbsData)[44] <- "SOCSEC_AO" #unfit for labor - arbeidsongeschiktheid
colnames(cbsData)[45] <- "SOCSEC_WW" #unfit for work - werkloosheidwet
colnames(cbsData)[46] <- "SOCSEC_AOW" # basic social pension after retirement
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
NAME		<- names(cbsData)[1]
MUNICIPALLITY	<- names(cbsData)[2]
REGIONTYPE	<- names(cbsData)[3]
REGIONCODE	<- names(cbsData)[4]
POPULATION	<- names(cbsData)[5]
MALE		<- names(cbsData)[6]
FEMALE		<- names(cbsData)[7]
AGEGROUP_015	<- names(cbsData)[8]
AGEGROUP_1525	<- names(cbsData)[9]
AGEGROUP_2545	<- names(cbsData)[10]
AGEGROUP_4565	<- names(cbsData)[11]
AGEGROUP_65UP	<- names(cbsData)[12]
UNMARRIED	<- names(cbsData)[13]
MARRIED		<- names(cbsData)[14]
SEPARATED	<- names(cbsData)[15]
WIDOWED		<- names(cbsData)[16]
WESTERN_ORIG	<- names(cbsData)[17]
NONWESTERN_ORIG	<- names(cbsData)[18]
MOROCCO_ORIG	<- names(cbsData)[19]
ABC_ORIG	<- names(cbsData)[20]
SURINAME_ORIG	<- names(cbsData)[21]
TURKEY_ORIG	<- names(cbsData)[22]
OTHER_ORIG	<- names(cbsData)[23]
BIRTH_REL	<- names(cbsData)[24]
MORTALITY_REL	<- names(cbsData)[25]
HH_TOT		<- names(cbsData)[26]
SINGLE_HH_TOT	<- names(cbsData)[27]
NOCHILD_HH_TOT	<- names(cbsData)[28]
CHILD_HH_TOT	<- names(cbsData)[29]
HH_SIZE	<- names(cbsData)[30]
DENS_POP	<- names(cbsData)[31]
HOUSE_VAL_AVG	<- names(cbsData)[32]
VACANCY	<- names(cbsData)[33]
RENTAL_HOUSING_PERC	<- names(cbsData)[34]
RENTAL_CORP_HOUSING_PERC	<- names(cbsData)[35]
AVG_ELECTRICITY_CONS	<- names(cbsData)[36]
AVG_GAS_CONS		<- names(cbsData)[37]
INCOME_AVG	<- names(cbsData)[38]
INCOME_LOW40PCT		<- names(cbsData)[39]
INCOME_HIGH20PCT	<- names(cbsData)[40]
INCOME_LOW		<- names(cbsData)[41]
INCOME_SOCMIN		<- names(cbsData)[42]
SOCSEC_NO_INCOME <- names(cbsData)[43] # 'bijstand'
SOCSEC_AO		<- names(cbsData)[44] # 'arbeids ongeschikt' unable to work
SOCSEC_WW		<- names(cbsData)[45] # 'werkloosheid wet'
SOCSEC_AOW		<- names(cbsData)[46] # 'algemene ouderdomswet' social basic pension
BUSINESS_LOCATIONS	<- names(cbsData)[47]
CAR_PER_HH		<- names(cbsData)[48]
GEN_DIST_GP		<- names(cbsData)[49]
GEN_DIST_SUPERMARKET	<- names(cbsData)[50]
GEN_DIST_DAYCARE	<- names(cbsData)[51]
GEN_DIST_SCHOOL		<- names(cbsData)[52]
LAND_SIZE		<- names(cbsData)[53]
PEOPLE_PER_KM2		<- names(cbsData)[54]
CRIME_BURGLARY_REL	<- names(cbsData)[55]
CRIME_PUB_ORDER_REL	<- names(cbsData)[56]
CRIME_VIOLENCE_SEX_REL	<- names(cbsData)[57]
