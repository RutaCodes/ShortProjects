#Ruta Basijokaite
#----------------
#This code finds recession periods in dataset and identified two longest ones 
#----------------

#Uploading data
Genesee_data<-read.csv(file="Genesee_data.csv",sep=",",header=F)
Discharge_obs<-Genesee_data[,2]
date=as.POSIXlt(Genesee_data[,1], format="%m/%d/%y")

#2014 water year
yr_st1=which((date$year+1900)==2013 & (date$mon+1)==10 & (date$mday)==1)
yr_end1=which((date$year+1900)==2014 & (date$mon+1)==9 & (date$mday)==30)

#2014 discharge
Discharge_yrs=Discharge_obs[yr_st1:yr_end1]

#Identifying days that had lower streamflow values than the day before
ind=0
N=length(Discharge_yrs)
for (i in seq(2,N)){
  if (Discharge_yrs[i]<Discharge_yrs[i-1]){
    ind[i]=i
  }
  else{
    ind[i]=0
  }
}

#Counting consecutive days that recession occured
cnt=0
counting=0
for(i in seq(2,N)){
  frst=ind[i-1]
  last=ind[i]
  if(last==frst+1){
    cnt=cnt+1
    counting[i]=cnt
  }
  else{
    counting[i]=0
    cnt=0
  }
}

#Combining dates, discharge values and identified recession periods
DF_14=data.frame(date[yr_st1:yr_end1],Discharge_yrs,counting)

#Identifying longest recession period
end_r = which(counting == max(counting))
start_r = which(counting == max(counting)) - max(counting)

#Longest recession period
Longest_reces = DF_14[start_r:end_r,] #17 days

#Identifying 2nd longest recession period
counting_n = counting [-seq(start_r,end_r)]
end_r2 = which(counting_n == max(counting_n))
start_r2 = which(counting_n == max(counting_n)) - max(counting_n) 

#2nd longest recession period
Longest2_reces = DF_14[start_r2:end_r2,] #13 days
