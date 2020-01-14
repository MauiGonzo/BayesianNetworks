#https://www.bnlearn.com/documentation/man/hc.html <- link for hc and tabu in one (almost the same)
library(bnlearn)
setwd('/home/denise/Documents/Vakken/BN/Project2')

x = data.frame(replicate(10,sample(0:100,1000,rep=TRUE)))
x[] <- lapply(x, as.factor)
thing <- tabu(x, start = NULL, whitelist = NULL, blacklist = NULL, score = NULL, debug = FALSE,
              tabu = 10, max.tabu = 10, max.iter = Inf, maxp = Inf, optimized = TRUE)
thing
###
testCBS <- cbsData[,-(1:4)]
testCBS[] <- lapply(testCBS, as.factor)
thing <- tabu(testCBS, start = NULL, whitelist = NULL, blacklist = NULL, score = NULL, debug = FALSE,
              tabu = 10, max.tabu = tabu, max.iter = Inf, maxp = Inf, optimized = TRUE)
thing
