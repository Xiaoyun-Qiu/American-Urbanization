# rename foreign country
library(data.table)
library(stringr)

getwd()
list.files()

# 1850
cntyname1850 <- fread("cntyname1850.csv")
cntyname1850 <- cntyname1850[, num := as.numeric(row.names(cntyname1850)) + 1]
cntyname1850 <- cntyname1850[,`:=`(
  name1 = str_c("cnty_foreign",as.character(num)),
  name2 = str_c("urban_foreign",as.character(num)),
  name3 = str_c("cnty_",cntyname),
  name4 = str_c("urban_",cntyname)
)]
n <- nrow(cntyname1850)

ipums1850 <- fread("ipums1850_detailed.csv")
name <- names(ipums1850)
name[(1+2):(n+2)] <- cntyname1850$name3
name[(1+n+2):(n+n+2)] <- cntyname1850$name4
names(ipums1850) <- name
write.csv(ipums1850,"ipums1850_detailed.csv",row.names=F)

# 1860-1880
cntylist <- c("cntyname1860.csv","cntyname1870.csv","cntyname1880.csv")
datalist <- c("ipums1860_detailed.csv","ipums1870_detailed.csv","ipums1880_detailed.csv")
for(i in 1:3){
  cntyname <- fread(cntylist[i])
  cntyname <- cntyname[, num := as.numeric(row.names(cntyname)) + 1]
  cntyname <- cntyname[,`:=`(
    name1 = str_c("cnty_foreign",as.character(num)),
    name2 = str_c("urban_foreign",as.character(num)),
    name3 = str_c("cnty_",cntyname),
    name4 = str_c("urban_",cntyname)
  )]
  n <- nrow(cntyname)
  
  ipums <- fread(datalist[i])
  name <- names(ipums)
  name[(1+2):(n+2)] <- cntyname$name3
  name[(1+n+2):(n+n+2)] <- cntyname$name4
  names(ipums) <- name
  write.csv(ipums,datalist[i],row.names=F)
}

# employment
cntylist <- c("cntyname1850.csv","cntyname1860.csv","cntyname1870.csv","cntyname1880.csv")
datalist <- c("ipums1850_detailed.csv","ipums1860_detailed.csv","ipums1870_detailed.csv","ipums1880_detailed.csv")
cd <- "D:/Dropbox/Xiaoyun/DataConstruction/code/employment/"
for(i in 1:4){
  cntyname <- fread(cntylist[i])
  cntyname$num <- as.numeric(row.names(cntyname)) + 1
  cntyname <- cntyname[,`:=`(
    name1 = str_c("cnty_foreign",as.character(num),"_employ"),
    name2 = str_c("urban_foreign",as.character(num),"_employ"),
    name3 = str_c("cnty_",cntyname,"_employ"),
    name4 = str_c("urban_",cntyname,"_employ")
  )]
  n <- nrow(cntyname)
  
  
  ipums <- fread(paste0(cd,datalist[i]))
  name <- names(ipums)
  name[(1+2):(n+2)] <- cntyname$name3
  name[(1+n+2):(n+n+2)] <- cntyname$name4
  names(ipums) <- name
  write.csv(ipums,paste0(cd,datalist[i]),row.names=F)
}