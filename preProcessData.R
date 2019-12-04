#
# preProcessData.R
#
# pre processing of the data 

# etc
# filter data, make data useable for cont network
cbsData <- subset(cbsData, grepl("Neighborhood*", REGIONTYPE))  # any regex possible

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

