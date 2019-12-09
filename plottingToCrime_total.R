nijmegen <- cbsData %>% filter(as.character(cbsData$MUNICIPALLITY)== "Nijmegen                                ")

for(i in 5:NCOL(cbsData)-1) { # Loop over all columns except first few and the last
  plot(cbsData[,i],cbsData$CRIME_TOTAL,, main = toString(i-4), xlab=names(cbsData[i]), ylab= names(cbsData[NCOL(cbsData)]),col="blue")
  points(nijmegen[,i],nijmegen$CRIME_TOTAL, col="red")
  legend("topright", legend=c("ALL DATA", "NIJMEGEN"),
         col=c("blue", "red"), lty=0,pch=1, cex=1)
}
