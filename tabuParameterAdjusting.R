#Adjusting one parameter: scoring
score_methods <- c("loglik-g", "aic-g", "bic-g", "bge") #"pred-loglik-g", : Error in per.node.score(network = start, score = score, targets = nodes,  : REAL() can only be applied to a 'numeric', not a 'NULL'
nr_tests= length(score_methods)
tabu_avg_parentchild = matrix(ncol = 2, nrow = nr_tests)
for(score in 1:nr_tests){
  tabuNW_temp <- tabu(d, score =score_methods[score], maxp = Inf)
  #plot.new()
  png(filename = paste("Project2Figures/", score_methods[score], ".png", sep=''),
      width = 1200,
      height = 1200,
      bg = "transparent",
      res = 500)
  graphviz.plot(tabuNW_temp, shape = "ellipse", highlight = list(nodes = c("CRIME_TOTAL","FEMALE_PCT") , col = "blue",textCol = "blue"))
  dev.off()
  tabu_nodes <- 0      
  for(i in 1:length(tabuNW_temp$nodes)){
    tabu_nodes[i] <- names(tabuNW_temp$nodes[i])
    }
  
  tabuNW_temp_parentchild <- matrix(ncol = 3, nrow = length(tabuNW_temp$nodes))
  for(i in 1:length(tabuNW_temp$nodes)){
    tabuNW_temp_parentchild[i,] <- c(tabu_nodes[i],
                                     as.numeric(length(tabuNW_temp$nodes[[i]]$parents)),
                                     as.numeric(length(tabuNW_temp$nodes[[i]]$children)))
    }
  
  colnames(tabuNW_temp_parentchild) <- c('Variable Name','Parent','Child')
  tabu_avg_parentchild[score,] <- c(mean(as.numeric(tabuNW_temp_parentchild[,2])),
                                             mean(as.numeric(tabuNW_temp_parentchild[,3])))
  print(mean(as.numeric(tabuNW_temp_parentchild[,2])))
        }
colnames(tabu_avg_parentchild) <- c('avg Parent','avg Child')
tabu_avg_parentchild
