#------------------------------------------
#This code utalizes USGS dataRetrieval package to automate data download for multiple sites and attributes
#E.g. this code can be used to retrieve USGS streamflow values for a specified site

#dataRetrieval package has multiple functions that can be used to download data
#Read more about them here:
#https://cran.r-project.org/web/packages/dataRetrieval/vignettes/dataRetrieval.html#readnwissite
#-----------------------------------------
#Clear workspace
rm(list=ls(all=T))

#Make sure dataRetrieval package is installed and load necessary libraries
library(dataRetrieval)
#Make sure 'stringi' data package is also installed

#### Uplaoding site info, specifying study period and parameter code

#Specify which file contains USGS site numbers of interest
file="Site_info.csv"
#Reading csv file with USGS site numbers
Site_info_all = read.csv(file,sep=",",header=T)

#Specifying time period 
start_of_period = as.Date("2000-01-01")
end_of_period = as.Date("2019-12-31")

#Selecting which parameter to download
parameterCd = "00060" # "00060" code stands for discharge

#### Pulling data from USGS website

#Number of sites analyzed
nr_sites = dim(Site_info_all)[1]
#If csv file contains more than one column with site numbers, 
View(Site_info_all)
#Specify which column contains site numbers
Site_string = Site_info_all[,1]

#For loop that is used to go through the list of watrsheds in Site_info file
#Pulling streamflow values from the website and saving them
for (i in seq(1,nr_sites)){
    
    #Downloading data for one watershed at a time
    site_numb = as.character(Site_string[i])
    
    #dataRetrieval package requires 8 digit site number code 
    #when csv file is created, 0s at the beginning of the code are often removed
    #If site number is less than 8 characters, add 0
    if (nchar(site_numb) < 8){
      Site_string[i] = paste0("0", site_numb)
      }
    
    #downloading daily streamflow data using readNWISdv function for specified period
    data_Q <- readNWISdv(site= Site_string[i], parameterCd , startDate= start_of_period, endDate= end_of_period)
    
    #Saving downloaded data as csv file for further analysis
    write.table(data_Q,file=paste( "USGS",Site_string[i],"_Q.csv",sep=""),sep=",",row.names=F,col.names=F,append=T)
}

