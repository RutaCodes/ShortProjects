#Ruta Basijokaite
#----------------
#This function calculates monthly average values for water year
#----------------

###Variables:
#date - dates
#Precip - precipitation dataset
#len - length of one year data
#Start year - starting year for the dataset
#Last year - last year in the dataset
#Nr_years - number of years in the dataset
#count, count2 - counters
#x - water year index / start of month index
#Months - vector of month numbers in order for water year
#Monthly_P_aver - matrix where nr of rows=months and nr of comulns=years
#Monthly_P - precipitation values in one month
#Monthly_yr_aver - monthly averages throughout all years

###Inputs:
#date - date vector in POSIClt format  e.g. date = as.POSIXlt(Column_with_dates, format="%m/%d/%y")
#Precip - vector with precipitation values

Monthly_loop <- function(date,Precip){
  
  len=length(date)
  Start_year<-date$year[1]+1900
  Last_year<-date$year[len]+1900
  Nr_years=Last_year-Start_year 
  
  count=0.0
  count2=0.0
  Months<-c(10,11,12,1,2,3,4,5,6,7,8,9)
  Monthly_yr_aver=0
  Monthly_P_aver<-matrix(0, nrow=length(Months), ncol=Nr_years)
  for (i in seq(Start_year,Last_year-1)){
    count=count+1
    for (j in seq(1,length(Months))){
      count2=count2+1
      #Finding index in the dataset
      x<-which((date$year+1900)==i & (date$mon+1)==(Months[j]))
      if (j>3){
        x<-which((date$year+1900)==i+1 & (date$mon+1)==(Months[j]))
      }
      #Computing monthly average (not rounding for more precise calculations)
      Monthly_P=Precip[x]
      Monthly_P_aver[count2,count]=mean(Monthly_P,na.rm=TRUE) #monthly daily average
    }
    Monthly_P=0.0
    count2=0.0
  }
  for (i in seq(1,12)){
    Monthly_yr_aver[i]=mean(Monthly_P_aver[i,],na.rm=TRUE)
  }
  return(Monthly_yr_aver)
}
