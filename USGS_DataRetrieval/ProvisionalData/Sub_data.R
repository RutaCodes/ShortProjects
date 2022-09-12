#Ruta Basijokaite

#----------------
#This code finds missing daily flow values and replaces them with average value that was calculated 
#using 15 min dataset
#----------------

#Loading data from one site that has missing flow values that can be corrected with average from 15min dataset
file_daily = read.csv(file="site01338000.csv",sep=",",header=T) 
dataF_daily = data.frame(file_daily[,2:5])
colnames(dataF_daily) = c("year","month","day",paste0("USGS",file_daily[1,1],"_Q"))
file_15min = read.csv(file="site01338000_15min.csv",sep=",",header=T) 
#Columns in 15min dataset: Site nr, year, month, day, hour, min, Q value
dataF_15min=data.frame(file_15min[,2:7])
names(dataF_15min)=c("year","month","day","hour","min",paste0("USGS",file_15min[1,1],"_Q"))

#Creating data file that has full range of dates
date_file= as.POSIXlt(seq(as.Date("2018/01/01"), as.Date("2019/12/31"), by="day"))
date_file_col=data.frame(date_file$year+1900, date_file$mon+1, date_file$mday)
names(date_file_col)=c("year","month","day")

#Combining two dataset: one will full range of dates, one with Q
library(dplyr)
data_cor=left_join(date_file_col,dataF_daily, on=c("year","month","day"))

#Finding NA flow values
ind_col5=which(is.na(data_cor[,4]))

#If there are missing daily Q values, replace them with daily average from 15min dataset
if (length(ind_col5)>0){
  for (i in 1:length(ind_col5)){
    
    #Finding date when we have missing value
    Yr_miss=data_cor[ind_col5[i],1]
    Mo_miss=data_cor[ind_col5[i],2]
    Day_miss=data_cor[ind_col5[i],3]
    
    #Finding that day in the 15 min dataset
    Mis_ind=which(dataF_15min$year==Yr_miss & dataF_15min$month==Mo_miss & dataF_15min$day==Day_miss)
    #calculating average streamflow value using 15min dataset
    Q_aver=mean(dataF_15min[Mis_ind,6],na.rm=T) #Na values will be ignored 
    data_cor[(ind_col5[i]),4]=Q_aver
  }
}
#data_cor - array with complete dates and corrected NAs 
