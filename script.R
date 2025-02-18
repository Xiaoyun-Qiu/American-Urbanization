library(data.table)
library(stringr)

state <- state.name
state_abb <- state.abb
rename <- data.table(cbind(state,state_abb))
  
extractlist <- fread("extractlist.csv")
extractlist <- extractlist[extractlist$`spatial scope`!="",1:3]
extractlist$`spatial scope` <- gsub(" ","_",extractlist$`spatial scope`)

extractlist <- merge(extractlist,rename,by="state")
#extractlist$start<- unlist(lapply(str_split(extractlist$pp,"-"), function(x) x[1]))
#extractlist$end<- unlist(lapply(str_split(extractlist$pp,"-"), function(x) x[2]))


state <- extractlist[extractlist$`spatial scope`=="by_state",]
industry <- extractlist[extractlist$`spatial scope`=="by_industrial_area",]
city <- extractlist[extractlist$`spatial scope`=="by_city" | extractlist$`spatial scope`=="by_county",]

command1 <- data.table(paste0("pdftk input.pdf cat ",state$pp," output ",state$state_abb,"_",state$`spatial scope`,"_1939.pdf"))
command2 <- data.table(paste0("pdftk input.pdf cat ",industry$pp," output ",industry$state_abb,"_",industry$`spatial scope`,"_1939.pdf"))
command3 <- data.table(paste0("pdftk input.pdf cat ",city$pp," output ",city$state_abb,"_",city$`spatial scope`,"_1939.pdf"))


write.table(command1,file="statelist.txt",quote=F,row.names=F)
write.table(command2,file="industrylist.txt",quote=F,row.names=F)
write.table(command3,file="citylist.txt",quote=F,row.names=F)
