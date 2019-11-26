
setwd('D:/Assignments/Bayesian Network/Assignment/Code/')
getwd()
library(stringr)
testdata<- read.csv2("BaseLine20191114.csv")
testdata <- testdata[2:( nrow(testdata) -1 ),]

View(testdata)

#Convert to Character
testdata[8:12]<-lapply(testdata[8:12], as.character)
sapply(testdata, class) 

#Remove ","
testdata[8] <- gsub("\\,", "", testdata$X...0.to.15.years)
testdata[9] <- gsub("\\,", "", testdata$X..15.to.25.years)
testdata[10] <- gsub("\\,", "", testdata$X..25.to.45.years)
testdata[11] <- gsub("\\,", "", testdata$X..45.to.65.years)
testdata[12] <- gsub("\\,", "", testdata$X..65.years.or.older)

#Convert to numeric
testdata[8:12] <- lapply(testdata[8:12], as.numeric)

#Compute Average For each group
testdata$Mean7.5<-testdata[8]*7.5
testdata$Mean20<-testdata[9]*20
testdata$Mean35<-testdata[10]*35
testdata$Mean55<-testdata[11]*55
testdata$Mean80<-testdata[12]*80

#Compute Average Age for each Neighberhood
#"X...0.to.15.years", "X..15.to.25.years","X..25.to.45.years","X..45.to.65.years"," X..65.years.or.older"
testdata$AgeCount <- rowSums(testdata[,c(8:12)], na.rm=TRUE)
testdata$AgeSum <- rowSums(testdata[,c("Mean7.5", "Mean20","Mean35","Mean55","Mean80")], na.rm=TRUE)
testdata$AgeAverage<- testdata$AgeSum/testdata$AgeCount






