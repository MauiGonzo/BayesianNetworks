#
# preProcessData.R
#
# pre processing of the data 
#####################################################################
# status per 10-12
# TODO: modify / create columns so they fit with the nodes in the dag
# IncomeDistribution 		  : TODO: create kind of average age collum INCOME_AVG
# Urbanization 		        : TODO: created average (I am afraid this is not in the dataset, propose to leave it out...)
#####################################################################

# etc
# filter data, make data useable for cont network
# cbsData <- subset(cbsData, grepl("Neighborhood*", REGIONTYPE))  # any regex possible
cbsData <- subset(cbsData, grepl("Wijk*", REGIONTYPE))  # any regex possible

cbsData$INCOME_HIGH20PCT <- as.numeric(gsub(",", ".", gsub("\\.", "", cbsData$INCOME_HIGH20PCT)))
cbsData$INCOME_SOCMIN <- as.numeric(gsub(",", ".", gsub("\\.", "", cbsData$INCOME_SOCMIN)))

#Delete other columns,I think, we can use HH_SIZE 
if("HH_TOT" %in% colnames(cbsData))
{
  cbsData = subset(cbsData, select = -c(HH_TOT,SINGLE_HH_TOT,NOCHILD_HH_TOT,CHILD_HH_TOT))
}
cbsData$HH_SIZE <- as.numeric(gsub(",", ".", gsub("\\.", "", cbsData$HH_SIZE)))

### Handle "," AGE###
#
if(!"AGE_AVG" %in% colnames(cbsData))
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
  cbsData$AGE_AVG<- cbsData$AgeSum/cbsData$AgeCount
  #Delete other columns
  cbsData = subset(cbsData, select = -c(AGEGROUP_015,AGEGROUP_1525,AGEGROUP_2545,AGEGROUP_4565,AGEGROUP_65UP,Mean7.5,Mean20,Mean35,Mean55,Mean80,AgeSum,AgeCount))
}
###compute BUSINESS LOCATIONS ###
#
if(!"BUSINESS_REL" %in% colnames(cbsData))
{
  # cbsData$BUSINESS_REL <- cbsData$BUSINESS_LOCATIONS / cbsData$POPULATION * 1000 
  cbsData$BUSINESS_REL <- as.numeric(as.character(cbsData$BUSINESS_LOCATIONS )) / as.numeric(as.character(cbsData$POPULATION)) * 1000
}
### Handle "," POPULATION ####
#
#Convert to Character
cbsData[POPULATION]<-lapply(cbsData[POPULATION], as.character)
#Remove ","
cbsData[POPULATION]<-gsub("\\,", "", cbsData$POPULATION)
#Convert to numeric
cbsData[POPULATION]<- lapply(cbsData[POPULATION], as.numeric)

cbsData <- subset(cbsData, POPULATION > 5) #remove zero populations


###compute MARRIED % ###
if(!"MARRIED_PCT" %in% colnames(cbsData))
{
  cbsData$MARRIED_PCT <- as.numeric(as.character(cbsData$MARRIED)) / as.numeric(as.character(cbsData$POPULATION)) * 100
  #Delete other columnss
  cbsData = subset(cbsData, select = -c(UNMARRIED,SEPARATED,WIDOWED,MARRIED))
}

###compute SEX: FEMALE % ###
if(!"FEMALE_PCT" %in% colnames(cbsData))
{
  cbsData$FEMALE_PCT <- as.numeric(as.character(cbsData$FEMALE)) / as.numeric(as.character(cbsData$POPULATION)) * 100
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

###compute SOCSEC_PCT % ###
if(!"SOCSEC_PCT" %in% colnames(cbsData))
{

  sc <- grep("SOCSEC_NO_INCOME",colnames(cbsData))
  ec <- grep("SOCSEC_WW",colnames(cbsData))
  cbsData[sc:ec]<-lapply(cbsData[sc:ec], as.character)
  # cbsData[c(SOCSEC_NO_INCOME,SOCSEC_AO,SOCSEC_WW ,SOCSEC_AOW)]<-lapply(cbsData[c(SOCSEC_NO_INCOME,SOCSEC_AO,SOCSEC_WW ,SOCSEC_AOW)], as.character)
  
   #Remove ","
  cbsData[SOCSEC_NO_INCOME] <- gsub("\\,","",cbsData$SOCSEC_NO_INCOME)
  cbsData[SOCSEC_AO] <- gsub("\\,","",cbsData$SOCSEC_AO)
  cbsData[SOCSEC_WW] <- gsub("\\,","",cbsData$SOCSEC_WW)
  cbsData[SOCSEC_AOW] <- gsub("\\,","",cbsData$SOCSEC_AOW)
  
  #Convert to numeric
  cbsData[sc:ec]<-lapply(cbsData[sc:ec], as.numeric)
  # cbsData[c(SOCSEC_NO_INCOME, SOCSEC_AO,SOCSEC_WW,SOCSEC_AOW)] <- lapply(cbsData[c(SOCSEC_NO_INCOME, SOCSEC_AO,SOCSEC_WW,SOCSEC_AOW)], as.numeric)

  # cbsData$SOCSEC_PCT <- (cbsData$SOCSEC_NO_INCOME + cbsData$SOCSEC_AO + cbsData$SOCSEC_WW + cbsData$SOCSEC_AOW)/ cbsData$POPULATION * 100
  #without AOW might be better?
  cbsData <- cbsData %>%
    mutate(SOCSEC_PCT = rowSums(.[sc:ec]/ POPULATION * 100))
  # cbsData$SOCSEC_PCT <- (cbsData$SOCSEC_NO_INCOME + cbsData$SOCSEC_AO + cbsData$SOCSEC_WW + cbsData$SOCSEC_AOW)/ cbsData$POPULATION * 100
  #Delete other columns
  cbsData = subset(cbsData, select = -c(SOCSEC_NO_INCOME, SOCSEC_AO, SOCSEC_WW, SOCSEC_AOW))
}


###compute ENERGY_AVG ###
#
if(!"ENERGY_AVG" %in% colnames(cbsData))
{
  cbsData[c(AVG_GAS_CONS, AVG_ELECTRICITY_CONS)]<-lapply(cbsData[c(AVG_GAS_CONS, AVG_ELECTRICITY_CONS)], as.character)
  #Remove ","
  cbsData$AVG_GAS_CONS<-gsub("\\,", "", cbsData$AVG_GAS_CONS)
  cbsData$AVG_ELECTRICITY_CONS<-gsub("\\,", "", cbsData$AVG_ELECTRICITY_CONS)
  #Convert to numeric
  cbsData[c(AVG_GAS_CONS, AVG_ELECTRICITY_CONS)]<- lapply(cbsData[c(AVG_GAS_CONS, AVG_ELECTRICITY_CONS)], as.numeric)
  #Replace NA with 0
  #cbsData[c(AVG_GAS_CONS, AVG_ELECTRICITY_CONS)][is.na(cbsData[c(AVG_GAS_CONS, AVG_ELECTRICITY_CONS)])] <- 0
  cbsData$ENERGY_AVG <- cbsData$AVG_ELECTRICITY_CONS + cbsData$AVG_GAS_CONS 
  #Delete other columns
  cbsData = subset(cbsData, select = -c(AVG_GAS_CONS,AVG_ELECTRICITY_CONS))
}

###compute PUB_SERV ###
#
if(!"PUB_SERV" %in% colnames(cbsData))
{
  sc <- grep("GEN_DIST_GP",colnames(cbsData))
  ec <- grep("GEN_DIST_SCHOOL", colnames(cbsData))
  cbsData[sc:ec]<-lapply(cbsData[sc:ec], as.numeric)
  cbsData$PUB_SERV <-(cbsData$GEN_DIST_DAYCARE + cbsData$GEN_DIST_GP + cbsData$GEN_DIST_SCHOOL + cbsData$GEN_DIST_SUPERMARKET)/4
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


# 
##MORTALITY_REL
cbsData[MORTALITY_REL ]<-lapply(cbsData[MORTALITY_REL ], as.character)
#Convert to numeric
cbsData[MORTALITY_REL]<- lapply(cbsData[MORTALITY_REL], as.numeric)

##BIRTH_REL
cbsData[BIRTH_REL ]<-lapply(cbsData[BIRTH_REL ], as.character)
#Convert to numeric
cbsData[BIRTH_REL]<- lapply(cbsData[BIRTH_REL], as.numeric)

##DENS_POP
cbsData[DENS_POP ]<-lapply(cbsData[DENS_POP ], as.character)
#Convert to numeric
cbsData[DENS_POP]<- lapply(cbsData[DENS_POP], as.numeric)

##LAND_SIZE
cbsData[LAND_SIZE ]<-lapply(cbsData[LAND_SIZE ], as.character)
#Convert to numeric
cbsData[LAND_SIZE]<- lapply(cbsData[LAND_SIZE], as.numeric)

##VACANCY
cbsData[VACANCY ]<-lapply(cbsData[VACANCY ], as.character)
#Convert to numeric
cbsData[VACANCY]<- lapply(cbsData[VACANCY], as.numeric)


##HOUSE_VAL_AVG
cbsData[HOUSE_VAL_AVG ]<-lapply(cbsData[HOUSE_VAL_AVG ], as.character)
#Convert to numeric
cbsData[HOUSE_VAL_AVG]<- lapply(cbsData[HOUSE_VAL_AVG], as.numeric)



sapply(cbsData, class) 


cbsData$INCOME_LOW40PCT <- as.numeric(gsub(",", ".", gsub("\\.", "", cbsData$INCOME_LOW40PCT)))
cbsData$INCOME_AVG <- as.numeric(gsub(",", ".", gsub("\\.", "", cbsData$INCOME_AVG)))
cbsData$CAR_PER_HH <- as.numeric(gsub(",", ".", gsub("\\.", "", cbsData$CAR_PER_HH)))
cbsData$PUB_SERV <- as.numeric(gsub(",", ".", gsub("\\.", "", cbsData$PUB_SERV)))
cbsData$INCOME_LOW <- as.numeric(gsub(",", ".", gsub("\\.", "", cbsData$INCOME_LOW)))
cbsData$SOCSEC_PCT <- as.numeric(gsub(",", ".", gsub("\\.", "", cbsData$SOCSEC_PCT)))
