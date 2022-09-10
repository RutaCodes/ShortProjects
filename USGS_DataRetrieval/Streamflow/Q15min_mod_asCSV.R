#Ruta Basijokaite

#----------------
#This code downloads 15 min streamflow data for specified site list and
#modifies downloaded dataset by removing unnecessary columns as well as changes date format
#----------------

#Make sure dataRetrieval package is installed
#load necessary libraries
library(dataRetrieval)
#Make sure 'stringi' data package is also installed

#Reading excel file with all study site USGS numbers
Site_info_all <- read.csv(file="Site_info.csv",sep=",",header=T)

#Site numbers
Site_info=Site_info_all[,1]

#Number of sites analyzed
nr_sites=length(Site_info)

#Defining search variables:
#Study time period 
start_of_period <- as.Date("2018-01-01")
end_of_period <- as.Date("2019-12-31")  

for (i in seq(1,nr_sites)){
  
  #Correcting site nr
  site_numb <- as.character(Site_info[i])
  if (nchar(site_numb)<8){
    site_numb = paste0("0", site_numb)
    Site_info[i] = site_numb
  }
  
  #Download record of 15 min streamflow data
  all_15Q <- readNWISuv(site= site_numb, parameterCd = "00060", startDate= start_of_period, endDate= end_of_period)
 
  #Pulling values needed from all_dailyQ variable
  site_nr <- as.numeric(all_15Q$site_no) #site number
  site_nr_USGS <- paste0("USGS",site_nr)
  dates <- all_15Q$dateTime #dates corresponding to streamflow values
  flow_v <- all_15Q$X_00060_00000 #15 min flow values
  
  #converting dates to posix lt object
  myDates <- as.POSIXlt(dates, format= "%Y-%m-%d %H:%M:%OS") #for 15 min values
  
  #Pull year, month, day values from date 
  year <- myDates$year+1900
  month <- myDates$mon+1
  day <- myDates$mday
  hour <- myDates$hour 
  min <- myDates$min
  
  #New array is created to record streamflow values, dates and site nr info
  Q15_arr <- cbind(site_nr_USGS,year,month,day,hour,min,flow_v)
  
  #Saving downloaded data as csv file for further analysis
  write.table(Q15_arr,file=paste0("USGS",Site_info[i],"_15Q.csv",sep=""),sep=",",row.names=F,col.names=F,append=T) 
}
