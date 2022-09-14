#Ruta Basijokaite
#-------------------------------
#This code explores using BaseflowSeparation with dataset that has missing values.
#It compares using BaseflowSeparation on the whole dataset, and using it on consecutive values only 
#-------------------------------

#Upload Q data (e.g. Q dataset used for atrazine) in mm/day
Q_data_f_mm <- read.csv(file="Q_mm_final_list_0912.csv",sep=",",header=T)

#Loading baseflow separation function
source("BaseflowSeparation.R")

#Find sites that have NA values in Q data. Then test two methods of BaseflowSeparation
#Method 1 - Remove NAs and "pretend" it's a complete dataset
#Method 2 - Split dataset into groups of consecutive values, then only feed those values into BaseflowSeparation function
#In that way Baseflow separation will be performed on each group of values separately

#-------------------------------
######## METHOD 1 ########
#Removing NAs and using dataset with NAs removed as a complete vector to run BaseflowSeparation

#Initiating variables
Baseflow_v1 = Runoff_v1 = data.frame(matrix(0,dim(Q_data_f_mm)[1],dim(Q_data_f_mm)[2])) 
colnames(Baseflow_v1) = colnames(Runoff_v1) = colnames(Q_data_f_mm)
Baseflow_v1[,1] = Runoff_v1[,1] = Q_data_f_mm[,1]
for (i in seq(from=2, to=dim(Q_data_f_mm)[2])){
  #Finding NA values - baseflow separation function cannot deal with NAs
  NonNA_ind = which(!is.na(Q_data_f_mm[,i]))
  Basef_run = data.frame(matrix(NA, length(Q_data_f_mm[,i]),2))
  #Baseflow separation
  Basef_run[NonNA_ind,] = BaseflowSeparation(Q_data_f_mm[NonNA_ind,i], filter_parameter = 0.925, passes = 3)  
  Baseflow_v1[,i] = Basef_run[,1]
  Runoff_v1[,i] = Basef_run[,2]
}

#-------------------------------
######## METHOD 2 ########

#Creating groups based on consecutive Q values, so that only consecutive values are used for baseflow separation at a time
library(dplyr)
#library(tidyverse)
#Initiating new variable that would define NAs as 0 and values as 1 (from Q dataset)
Q_cons_gr = Q_val_TF = data.frame(matrix(0,dim(Q_data_f_mm)[1],dim(Q_data_f_mm)[2])) 
colnames(Q_cons_gr) = colnames(Q_val_TF) = colnames(Q_data_f_mm)
Q_cons_gr[,1] = Q_val_TF[,1] = Q_data_f_mm[,1]
for (i in seq(from=2, to=dim(Q_data_f_mm)[2])){
  Q_T_F=matrix(0,dim(Q_data_f_mm)[1],1)
  Q_T_F[!is.na(Q_data_f_mm[,i]),1] = 1 #setting NAs as 0s and values as 1s
  Q_val_TF[,i] = Q_T_F #recording #is it needed?
  Q_cons_gr[,i]=with(rle(Q_T_F[,1]), rep(values * cumsum(values & lengths >= 2),lengths))
}

#Loop to separate baseflow and runoff from Q using only consecutive values
#Initiating variables
Baseflow_v2 = Runoff_v2 = data.frame(matrix(0,dim(Q_data_f_mm)[1],dim(Q_data_f_mm)[2])) 
colnames(Baseflow_v2) = colnames(Runoff_v2) = colnames(Q_data_f_mm)
Baseflow_v2[,1] = Runoff_v2[,1] = Q_data_f_mm[,1]
for (i in seq(from=2, to=dim(Q_cons_gr)[2])){
  Basef_run_c=data.frame(matrix(NA, length(Q_data_f_mm[,i]),2))
  for (j in seq(1,max(Q_cons_gr[,i]))){
    Row_ind=which(Q_cons_gr[,i]==j)
    Basef_run_c[Row_ind,]=BaseflowSeparation(Q_data_f_mm[Row_ind,i], filter_parameter = 0.925, passes = 3)  
  }
  Baseflow_v2[,i]=Basef_run_c[,1]
  Runoff_v2[,i]=Basef_run_c[,2]
}

#-------------------------------
###### COMPARING RESULTS ######
#Visually comparing results from method 1 and method 2 - which one is more realistic?

#Identifying sites that have more than 1 group of consecutive values, for visualizing results
Which_gr = which(Q_cons_gr[dim(Q_cons_gr)[1],]>1)[-1] #1st column should be ignored as it's not Q values
WS_expl = Q_cons_gr[dim(Q_cons_gr)[1],Which_gr] #looking up sites that have more than 1 group
#Analyzing watersheds - how many values are missing?
count_occur_all = array(dim = c(19, 2, length(Which_gr)))
for (i in seq(1, length(Which_gr))){
  WS = Which_gr[i]
  C = cbind(rle(Q_cons_gr[,WS])$values, rle(Q_cons_gr[,WS])$lengths)
  count_occur_all[seq(1,dim(C)[1]),,i] = C
}
#WS = 18 is a good example when only one day is missing at a time (many others are similair, where only one value is missing at a time)
#WS = 31 has a period of missing 59 values in between two consecutive periods
#WS = 65 has 731 missing values between two consecutive periods

#Comaring results from these 3 sites - do all of them agree which method is best?
#Manually selecting time periods to plot - testing WS one by one

WS = 18 # column/site number
count_occur = data.frame(rle(Q_cons_gr[,WS])$values, rle(Q_cons_gr[,WS])$lengths)
test_18 = data.frame(Q_cons_gr[,WS], with(rle(Q_cons_gr[,WS]), rep(lengths, lengths)))
#Visually selecting time period to represent
#for WS=18 start at the begging of gr=2 till the end
Comp_BaseF_18 = data.frame(Q_data_f_mm[,WS],Baseflow_v1[,WS],Baseflow_v2[,WS])
Period_18_v3 = seq((max(which(test_18[,1] == 3))-20), (min(which(test_18[,1] == 5))+20))
date_18 = as.POSIXlt(as.Date(Q_data_f_mm[Period_18_v3,1], "%Y-%m-%d",tz = "UTC"))
matplot(Comp_BaseF_18[Period_18_v3,],type=c("b"),pch=1,col=1:3, ylab='Streamflow (mm/day)',xaxt='n',las = 1)
axis(1, at = seq(1,length(date_18), by=5), labels = date_18[seq(1,length(date_18), by=5)], cex.axis=0.8, las = 2)
legend("topleft", legend = c("Streamflow","Method1","Methods2"), pch=1, col=1:3, bty='n')
title(main = paste(colnames(Q_data_f_mm)[WS],'\n Missing values = 2'))

WS = 31
count_occur = data.frame(rle(Q_cons_gr[,WS])$values, rle(Q_cons_gr[,WS])$lengths)
test_31 = data.frame(Q_cons_gr[,WS], with(rle(Q_cons_gr[,WS]), rep(lengths, lengths)))
Comp_BaseF_31 = data.frame(Q_data_f_mm[,WS],Baseflow_v1[,WS],Baseflow_v2[,WS])
date_31 = as.POSIXlt(as.Date(Q_data_f_mm[Period_31,1], "%Y-%m-%d",tz = "UTC"))
Period_31_v1 = seq(min(which(test_31[,1] == 2)), (min(which(test_31[,1] == 3))+50))
matplot(Comp_BaseF_31[Period_31_v1,],type=c("b"),pch=1,col=1:3, ylab='Streamflow (mm/day)',xaxt='n',las = 1)
axis(1, at = seq(1,length(date_31), by=10), labels = date_31[seq(1,length(date_31), by=10)],cex.axis=0.8, las = 2)
legend("topright", legend = c("Streamflow","Method1","Methods2"), pch=1, col=1:3, bty='n')
title(main = paste(colnames(Q_data_f_mm)[WS],'\n Missing values = 59'))

WS = 65
count_occur = data.frame(rle(Q_cons_gr[,WS])$values, rle(Q_cons_gr[,WS])$lengths)
test_65 = data.frame(Q_cons_gr[,WS], with(rle(Q_cons_gr[,WS]), rep(lengths, lengths)))
Comp_BaseF_65 = data.frame(Q_data_f_mm[,WS],Baseflow_v1[,WS],Baseflow_v2[,WS])
Period_65 = seq((min(which(test_65[,1] == 0))-50), (max(which(test_65[,1] == 0))+50))
date_65 = as.POSIXlt(as.Date(Q_data_f_mm[Period_65,1], "%Y-%m-%d",tz = "UTC"))
#Removing a chunk of missing values to plot non NA values closer together
Period_65_minus_t = Period_65[c(which(Period_65 < (min(which(test_65[,1] == 0))+20)),which(Period_65 > (max(which(test_65[,1] == 0))-20)))]
date_65_minus_t = as.POSIXlt(as.Date(Q_data_f_mm[Period_65_minus_t,1], "%Y-%m-%d",tz = "UTC"))
matplot(Comp_BaseF_65[Period_65_minus_t,],type=c("b"),pch=1,col=1:3, ylab='Streamflow (mm/day)',xaxt='n',las = 1)
axis(1, at = seq(1,length(date_65_minus_t), by=10), labels = date_65_minus_t[seq(1,length(date_65_minus_t), by=10)],cex.axis=0.8,las = 2)
legend("topright", legend = c("Streamflow","Method1","Methods2"), pch=1, col=1:3, bty='n')
title(main = paste(colnames(Q_data_f_mm)[WS],'\n Missing values = 731'))
