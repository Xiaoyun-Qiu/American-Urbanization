library(data.table)
library(stringr)
library(plyr)

state <- fread("state_label.csv")
V1 <- lapply(str_split(state$code,"label define statefip_lbl "),function(x) x[2])
V2 <- lapply(str_split(V1,", add"),function(x) x[1])
V3 <- lapply(str_split(V2,"\"\"'"),function(x) x[1])
statefip <- as.numeric(unlist(lapply(str_split(V3," `\"\""),function(x) x[1])))
state <- unlist(lapply(str_split(V3," `\"\""),function(x) x[2]))
mapping <- data.table(cbind(statefip,state))
mapping$stateabb <- mapvalues(mapping$state,c(state.name,"District of Columbia"),c(state.abb,"DC"))
mapping <- mapping[1:51,]
write.csv(mapping,"state_mapping.csv",row.names=F)



