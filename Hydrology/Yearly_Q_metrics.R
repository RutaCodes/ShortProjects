#Ruta Basijokaite
#----------------
#This function calculates average yearly discharge, maximum yearly discharge and 7day annual minimum discharge
#----------------

###Variables:
#date - dates
#Discharge - discharge values
#Start year - starting year for the dataset
#Last year - last year in the dataset
#Nr_years - number of years in the dataset
#count, count2 - counters
#Months - vector of month numbers in order for water year
#Monthly_aver - matrix where nr of rows=months and nr of comulns=years
#Monthly_discharge - discharge values in one month
#Aver_total - average discharge values in each month
#Month_out - matrix of monthly averages required for the output
#Yearly_aver - annual yearly averages
#Max_annQ - annual daily maximums
#day7_min - annual 7day minimums
#x - start of the water year index / start of month index
#y - end of the water year index
#Yearly_discharge - discharge values in one year
#len,len2 - length of one year data
#day7_aver - 7 day averages
#Ann_out - matrix with average, max, and 7day min values

###Inputs:
#date - date vector in POSIXlt format  e.g. date = as.POSIXlt(Column_with_dates, format="%m/%d/%y")
#Discharge - vector with discharge values

Annual_loop <- function(date,Discharge){
 
len=length(Discharge)   
#Determining start and end date of the dataset 
Start_year<-date$year[1]+1900
Last_year<-date$year[len]+1900
Nr_years=Last_year-Start_year  
  
Yearly_aver=0.0
Max_annQ=0.0
count=0.0
day7_min=0.0
#Using for loop to estimate the streamflow average in year year
for (i in seq(Start_year,Last_year-1)){
  
  #Finding index of start of the year in the dataset
  x<-which((date$year+1900)==i & (date$mon+1)==10 & (date$mday)==1)
  #Finding the index of the end of the year in dataset
  y<-which((date$year+1900)==i+1 & (date$mon+1)==9 & (date$mday)==30)
  
  #Computing average (not rounding for more precise calculations)
  count=count+1
  Yearly_discharge=Discharge[x:y]
  Yearly_aver[count]=mean(Yearly_discharge)
  #determining annual maximum daily streamflow
  Max_annQ[count]=max(Yearly_discharge) #annual maximum
  
  len2=length(Yearly_discharge)
  count2=0.0
  day7_aver=0.0
  #running 7 day average to determine 7day annual minimum
  for (j in seq(7,len2)){
    count2=count2+1
    day7_aver[count2]=mean(Yearly_discharge[(j-6):j]) #7day averages
  }
  day7_min[count]=min(day7_aver) #annual 7 day minimum
}
Ann_out=cbind(Yearly_aver,Max_annQ,day7_min)
return(Ann_out)
}

Monthly_loop <- function(date,Discharge){
  
  Start_year<-date$year[1]+1900
  Last_year<-date$year[len]+1900
  Nr_years=Last_year-Start_year 

  count=0.0
  count2=0.0
  Months<-c(10,11,12,1,2,3,4,5,6,7,8,9)
  Monthly_aver<-matrix(0, nrow=length(Months), ncol=Nr_years)
  for (i in seq(Start_year,Last_year-1)){
    count=count+1
    for (j in seq(1,length(Months))){
      count2=count2+1
      #Finding index in the dataset
      x<-which((date$year+1900)==i & (date$mon+1)==(Months[j]))
      if (j>3){
        x<-which((date$year+1900)==i+1 & (date$mon+1)==(Months[j]))
      }
      #Computing monthly averagea (not rounding for more precise calculations)
      Monthly_discharge=Discharge[x]
      Monthly_aver[count2,count]=mean(Monthly_discharge) #monthly daily average
      }
    Monthly_discharge=0.0
    Monthly_discharge_obs=0.0
    count2=0.0
  }
  return(Monthly_aver)
}

