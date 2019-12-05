#
# preProcessData.R
#
# pre processing of the data 
#####################################################################
# status per 5-12
# TODO: modify / create columns so they fit with the nodes in the dag
# Age 				: TODO: create average age collum
# BUSINESS_LOCATIONS 		: TODO: create kind of average
# LAND_SIZE 			: should be fine the way it is
# AVG_INCOME_CAPITA 		: OK
# BIRTH_REL 			: OK
# CAR_PER_HH 			: OK
# CRIME_TOTAL 			: DONE: create cummulative crime column
# MORTALITY_REL			: CHECK IF DONE: create average age collum
# Distance_to_public_services 	: TODO: create average collum
# AVG_ELECTRICITY_CONS 		: CHECK: create average collum
# EMPTY_HOUSE_PERC 		: TODO: create kind of average collum
# IncomeDistribution 		: TODO: create kind of average age collum
# MARRIED 			: TODO: create percentage married (or simmilar)
# POP_DENSITY 			: OK
# POPULATION 			: OK
# AVG_HOUSE_VALUE 		: CHECK IF OK: create average age collum
# SEX 				: TODO: create percentage female collumn
# SocialSecurity 		: TODO: create kind of average collum
# Types_of_Households 		: TODO: create kind of average
# Types_of_property 		: TODO: create kind of average
# Urbanization 		: TODO: create kind of average (I am afraid this is not in the dataset, propose to leave it out...)
#####################################################################

# etc
# filter data, make data useable for cont network
# cbsData <- subset(cbsData, grepl("Neighborhood*", REGIONTYPE))  # any regex possible
cbsData <- subset(cbsData, grepl("Buurt*", REGIONTYPE))  # any regex possible

### Handle "," AGE ###
#
# convert to char
cbsData[8:12]<-lapply(cbsData[8:12], as.character)
sapply(cbsData, class) 

#Remove ","
cbsData[AGEGROUP_015] <- gsub("\\,","",cbsData$AGEGROUP_015)
cbsData[AGEGROUP_1525] <- gsub("\\,","",cbsData$AGEGROUP_1525)
cbsData[AGEGROUP_2545] <- gsub("\\,","",cbsData$AGEGROUP_2545)
cbsData[AGEGROUP_4565] <- gsub("\\,","",cbsData$AGEGROUP_4565)
cbsData[AGEGROUP_65UP] <- gsub("\\,", "", cbsData$AGEGROUP_65UP)
#onvert to numeric
cbsData[8:12] <- lapply(cbsData[8:12], as.numeric)


### Handle "," POPULATION ####
#
#Convert to Character
cbsData[POPULATION]<-lapply(cbsData[POPULATION], as.character)
sapply(cbsData, class)
#Remove ","
cbsData[POPULATION]<-gsub("\\,", "", cbsData$POPULATION)
#Convert to numeric
cbsData[POPULATION]<- lapply(cbsData[POPULATION], as.numeric)

### Numberic CRIME
#
counter <- 55
for (crime_type in c(1,2,3)){
  cbsData[counter] <- as.numeric(as.character(cbsData[,counter]))
  counter = counter + 1
}


### Numberic ORIG
#


#filter

cbsData[POPULATION] <- as.numeric(as.character(cbsData[,"POPULATION"]))
cbsData <- filter(cbsData, POPULATION > 5) #results in to many zeros  

#compute averages
cbsData$FEMALE <- cbsData$FEMALE / cbsData$POPULATION * 100

cbsData$CRIME_TOTAL= cbsData$CRIME_BURGLARY_REL + cbsData$CRIME_PUB_ORDER_REL + cbsData$CRIME_VIOLENCE_SEX_REL
# incorp average age

