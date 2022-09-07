#Ruta Basijokaite
#-------------------------------------------
#This code:
#1) Downloads streamflow data using dataRetrieval package 
#2) Records daily streamflow values for each site in an array
#3) Downloads site info for sites that have Q record
#-------------------------------------------
#Initial notes:
#Make sure dataRetrieval package is installed
#Make sure 'stringi' data package is also installed
#Make sure 'vctrs' data package is also installed
  
#Loading libraries
library(dataRetrieval)

#Loading data
#Reading in csv file with USGS sites
Site_info_all <- read.csv(file="Site_info.csv",sep=",",header=T)

#Reading in USGS site numbers 
Site_code <- Site_info_all[,1]
  
#Defining search variables:
startDate <- "2004-01-01" #Time period of interest 
endDate <- "2021-09-23"
parameterCd_Q <- "00060" #Daily discharge values
  
#Creating variable that has full range of dates
date_file = as.POSIXlt(seq(as.Date("2004/01/01"), as.Date("2021/09/23"), by="day"))
date_file_DF=data.frame(date_file)
names(date_file_DF) = "Date"
  
####### DOWNLOADING STREAMFLOW DATA AND SITE INFO
#Initiating variables used in the loop
site_nr_USGS = cnt = Site_code_short = siteINFO_all = 0
  
#Site  number length has to be no less than 8 numeric digits
for (i in seq(1,length(Site_code))){
  site_numb = as.character(Site_code[i])
  if (nchar(site_numb)<8){
    site_numb = paste0("0", site_numb)
  }
    
#Downloading daily discharge values
  discharge <- readNWISdv(site_numb, parameterCd_Q, startDate, endDate)
  if (dim(discharge)[1]>0){ #Check which study sites have recorded streamflow values
    cnt=cnt+1
    data_sh_DF = data.frame(matrix(0,dim(discharge)[1],2)) #Date, discharge
    site_nr_USGS[cnt] = paste0("USGS",site_numb)
    Site_code_short[cnt] = Site_code[i]
    colnames(data_sh_DF) = c("Date",site_nr_USGS[cnt])
    data_sh_DF[,1] = data.frame(as.POSIXlt(as.Date(discharge[,3])))
    data_sh_DF[,2] <- discharge$X_00060_00003 #daily flow values
    #Combining two dataset: one with full range of dates, one only with dates that have discharge values
    date_file_DF = left_join(date_file_DF,data_sh_DF, on="Date") #Array of Daily discarge values 
      
    #Downloading site info 
    if (cnt == 1){ #initiating data frame
      siteINFO_all = data.frame(matrix(0,1,dim(readNWISsite(siteNumbers=site_numb))[2]))
      siteINFO_all = readNWISsite(siteNumbers=site_numb)
    }else{
      siteINFO_all[nrow(siteINFO_all)+1,] = readNWISsite(siteNumbers=site_numb)}
  }
} 
  
#Reducing site info data frame, recording just values of interest
siteINFO_short2 = data.frame(paste0(siteINFO_all[,1],siteINFO_all[,2]),siteINFO_all[,c(3,7,8,30)])
colnames(siteINFO_short) = c("site_no",colnames(siteINFO_short[3:6]))

