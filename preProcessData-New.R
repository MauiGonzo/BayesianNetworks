#
# preProcessData.R
#
# pre processing of the data 
#####################################################################
# status per 5-12
# TODO: modify / create columns so they fit with the nodes in the dag
# IMMIGRATION             : TODO: create percentage of Non Western ()
# Age 			              : DONE: AVG_AGE
# BUSINESS_LOCATIONS 		  : TODO: create kind of average
# LAND_SIZE 			        : should be fine the way it is
# AVG_INCOME_CAPITA 		  : OK
# BIRTH_REL 			        : OK
# CAR_PER_HH 			        : OK
# CRIME_TOTAL 			      : DONE: create cummulative crime column
# MORTALITY_REL			      : CHECK IF DONE: create average age collum
# Distance_to_public_services 	: TODO: create average collum
# AVG_ELECTRICITY_CONS 	  : CHECK: create average collum
# EMPTY_HOUSE_PERC 		    : TODO: create kind of average collum
# IncomeDistribution 		  : TODO: create kind of average age collum
# MARRIED 			          : TODO: create percentage married (or simmilar)
# POP_DENSIT   	          : OK
# POPULATION 			        : OK
# AVG_HOUSE_VALUE 		    : CHECK IF OK: create average age collum
# SEX 				            : TODO: create percentage female collumn
# SocialSecurity 		      : TODO: create kind of average collum
# Types_of_Households 		: TODO: create kind of average (we can use  (AVG_HH_SIZE) )
# Types_of_property 		  : TODO: create kind of average
# Urbanization 		        : TODO: create kind of average (I am afraid this is not in the dataset, propose to leave it out...)
#####################################################################

# etc
# filter data, make data useable for cont network
# cbsData <- subset(cbsData, grepl("Neighborhood*", REGIONTYPE))  # any regex possible
#cbsData <- subset(cbsData, grepl("Buurt*", REGIONTYPE))  # any regex possible
#View(cbsData)
#sapply(cbsData, class) 



#Delete other columns,I think, we can use AVG_HH_SIZE 
cbsData = subset(cbsData, select = -c(HH_TOT,SINGLE_HH_TOT,NOCHILD_HH_TOT,CHILD_HH_TOT))


### Handle "," AGE###
#
if(!"AVG_AGE" %in% colnames(cbsData))
{
  # convert to char
  cbsData[8:12]<-lapply(cbsData[8:12], as.character)

  #Remove ","
  cbsData[AGEGROUP_015] <- gsub("\\,","",cbsData$AGEGROUP_015)
  cbsData[AGEGROUP_1525] <- gsub("\\,","",cbsData$AGEGROUP_1525)
  cbsData[AGEGROUP_2545] <- gsub("\\,","",cbsData$AGEGROUP_2545)
  cbsData[AGEGROUP_4565] <- gsub("\\,","",cbsData$AGEGROUP_4565)
  cbsData[AGEGROUP_65UP] <- gsub("\\,", "", cbsData$AGEGROUP_65UP)

  #Convert to numeric
  cbsData[8:12] <- lapply(cbsData[8:12], as.numeric)

  #Compute Average Age
  #Average For each group
  cbsData$Mean7.5<-cbsData[AGEGROUP_015]*7.5
  cbsData$Mean20<-cbsData[AGEGROUP_1525]*20
  cbsData$Mean35<-cbsData[AGEGROUP_2545]*35
  cbsData$Mean55<-cbsData[AGEGROUP_4565]*55
  cbsData$Mean80<-cbsData[AGEGROUP_65UP]*80

  cbsData$AgeCount <- rowSums(cbsData[,c(8:12)], na.rm=TRUE)
  cbsData$AgeSum <- rowSums(cbsData[,c("Mean7.5", "Mean20","Mean35","Mean55","Mean80")], na.rm=TRUE)
  cbsData$AVG_AGE<- cbsData$AgeSum/cbsData$AgeCount
  #Delete other columns
  cbsData = subset(cbsData, select = -c(AGEGROUP_015,AGEGROUP_1525,AGEGROUP_2545,AGEGROUP_4565,AGEGROUP_65UP,Mean7.5,Mean20,Mean35,Mean55,Mean80,AgeSum,AgeCount))
}

### Handle "," POPULATION ####
#
#Convert to Character
cbsData[POPULATION]<-lapply(cbsData[POPULATION], as.character)
#Remove ","
cbsData[POPULATION]<-gsub("\\,", "", cbsData$POPULATION)
#Convert to numeric
cbsData[POPULATION]<- lapply(cbsData[POPULATION], as.numeric)

cbsData <- filter(cbsData, POPULATION > 5) #remove zero populations


###compute MARRIED % ###
if(!"PERC_MARRIED" %in% colnames(cbsData))
{
  cbsData$PERC_MARRIED <- cbsData$MARRIED / cbsData$POPULATION * 100
  #Delete other columns
  cbsData = subset(cbsData, select = -c(UNMARRIED,SEPARATED,WIDOWED,MARRIED))
}

###compute FEMALE % ###
if(!"PERC_FEMALE" %in% colnames(cbsData))
{
  cbsData$PERC_FEMALE <- cbsData$FEMALE / cbsData$POPULATION * 100
  #Delete other columns
  cbsData = subset(cbsData, select = -c(FEMALE,MALE))
}

###compute IMMIGRATION_ORIG % ###
if(!"PERC_IMMIGRATION_ORIG" %in% colnames(cbsData))
{
  cbsData$PERC_IMMIGRATION_ORIG <- (cbsData$WESTERN_ORIG + cbsData$NONWESTERN_ORIG) / cbsData$POPULATION * 100
  #Delete other columns
  cbsData = subset(cbsData, select = -c(WESTERN_ORIG,NONWESTERN_ORIG,MOROCCO_ORIG,ABC_ORIG,SURINAME_ORIG,TURKEY_ORIG,OTHER_ORIG ))
}

###compute PERC_SOCSEC % ###
# if(!"PERC_SOCSEC" %in% colnames(cbsData))
# {
#   
#   cbsData[c(SOCSEC_NO_INCOME,SOCSEC_AO,SOCSEC_WW ,SOCSEC_AOW)]<-lapply(cbsData[c(SOCSEC_NO_INCOME,SOCSEC_AO,SOCSEC_WW ,SOCSEC_AOW)], as.character)
#    #Remove ","
#   cbsData[SOCSEC_NO_INCOME] <- gsub("\\,","",cbsData$SOCSEC_NO_INCOME)
#   cbsData[SOCSEC_AO] <- gsub("\\,","",cbsData$SOCSEC_AO)
#   cbsData[SOCSEC_WW] <- gsub("\\,","",cbsData$SOCSEC_WW)
#   cbsData[SOCSEC_AOW] <- gsub("\\,","",cbsData$SOCSEC_AOW)
#   #Convert to numeric
#   cbsData[c(SOCSEC_NO_INCOME, SOCSEC_AO,SOCSEC_WW,SOCSEC_AOW)] <- lapply(cbsData[c(SOCSEC_NO_INCOME, SOCSEC_AO,SOCSEC_WW,SOCSEC_AOW)], as.numeric)
#   
#   
#   cbsData$PERC_SOCSEC <- (cbsData$SOCSEC_NO_INCOME + cbsData$SOCSEC_AO + cbsData$SOCSEC_WW + cbsData$SOCSEC_AOW)/ cbsData$POPULATION * 100
#   #Delete other columns
#   cbsData = subset(cbsData, select = -c(SOCSEC_NO_INCOME, SOCSEC_AO, SOCSEC_WW, SOCSEC_AOW))
# }


###compute AVG_ENERGY_CONS ###
#
if(!"AVG_ENERGY_CONS" %in% colnames(cbsData))
{
  cbsData[c(AVG_GAS_CONS, AVG_ELECTRICITY_CONS)]<-lapply(cbsData[c(AVG_GAS_CONS, AVG_ELECTRICITY_CONS)], as.character)
  #Remove ","
  cbsData$AVG_GAS_CONS<-gsub("\\,", "", cbsData$AVG_GAS_CONS)
  cbsData$AVG_ELECTRICITY_CONS<-gsub("\\,", "", cbsData$AVG_ELECTRICITY_CONS)
  #Convert to numeric
  cbsData[c(AVG_GAS_CONS, AVG_ELECTRICITY_CONS)]<- lapply(cbsData[c(AVG_GAS_CONS, AVG_ELECTRICITY_CONS)], as.numeric)
  #Replace NA with 0
  #cbsData[c(AVG_GAS_CONS, AVG_ELECTRICITY_CONS)][is.na(cbsData[c(AVG_GAS_CONS, AVG_ELECTRICITY_CONS)])] <- 0
  cbsData$AVG_ENERGY_CONS <- cbsData$AVG_ELECTRICITY_CONS + cbsData$AVG_GAS_CONS 
  #Delete other columns
  cbsData = subset(cbsData, select = -c(AVG_GAS_CONS,AVG_ELECTRICITY_CONS))
}

###compute GEN_DIST_PUBLICSERVICES ###
#
if(!"GEN_DIST_PUBLICSERVICES" %in% colnames(cbsData))
{
  sc <- grep("GEN_DIST_GP",colnames(cbsData))
  ec <- grep("GEN_DIST_SCHOOL", colnames(cbsData))
  cbsData[sc:ec]<-lapply(cbsData[sc:ec], as.numeric)
  cbsData$GEN_DIST_PUBLICSERVICES <-(cbsData$GEN_DIST_DAYCARE + cbsData$GEN_DIST_GP + cbsData$GEN_DIST_SCHOOL + cbsData$GEN_DIST_SUPERMARKET)/4
  #Delete obsolete columns
  cbsData = subset(cbsData, select = -c(GEN_DIST_DAYCARE,GEN_DIST_GP,GEN_DIST_SCHOOL,GEN_DIST_SUPERMARKET) )
}

###compute CRIME_TOTAL ###
#
if(!"CRIME_TOTAL" %in% colnames(cbsData))
{
  cbsData[c(CRIME_BURGLARY_REL, CRIME_PUB_ORDER_REL,CRIME_VIOLENCE_SEX_REL)]<-lapply(cbsData[c(CRIME_BURGLARY_REL, CRIME_PUB_ORDER_REL,CRIME_VIOLENCE_SEX_REL)], as.character)
  #Remove ","
  cbsData[CRIME_BURGLARY_REL] <- gsub("\\,","",cbsData$CRIME_BURGLARY_REL)
  cbsData[CRIME_PUB_ORDER_REL] <- gsub("\\,","",cbsData$CRIME_PUB_ORDER_REL)
  cbsData[CRIME_VIOLENCE_SEX_REL] <- gsub("\\,","",cbsData$CRIME_VIOLENCE_SEX_REL)
  #Convert to numeric
  cbsData[c(CRIME_BURGLARY_REL, CRIME_PUB_ORDER_REL,CRIME_VIOLENCE_SEX_REL)] <- lapply(cbsData[c(CRIME_BURGLARY_REL, CRIME_PUB_ORDER_REL,CRIME_VIOLENCE_SEX_REL)], as.numeric)
  
  cbsData$CRIME_TOTAL<- cbsData$CRIME_BURGLARY_REL + cbsData$CRIME_PUB_ORDER_REL + cbsData$CRIME_VIOLENCE_SEX_REL
  #Delete other columns
  cbsData = subset(cbsData, select = -c(CRIME_BURGLARY_REL, CRIME_PUB_ORDER_REL,CRIME_VIOLENCE_SEX_REL) )

}

sapply(cbsData, class) 

