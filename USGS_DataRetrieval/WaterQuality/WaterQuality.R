#Ruta Basijokaite
#-------------------------------------------
#This code downloads water quality data for specified sites based on defined parameter codes
#-------------------------------------------
#Initial notes:
#Make sure dataRetrieval package is installed
#Make sure 'stringi' data package is also installed
#Make sure 'vctrs' data package is also installed

#Loading libraries
library(dataRetrieval)

#Loading data
#Reading in csv file with USGS sites
Site_info_all <- read.csv(file="Site_list_final_0907.csv",sep=",",header=T)

#Reading in USGS site numbers 
Site_code <- Site_info_all[,1]

#Defining search variables:
startDate <- "2004-01-01" #Time period of interest 
endDate <- "2021-09-23"
parameterCd_Q <- "00060" #Daily discharge values
#Water quality parameters of interest (for atrazine):
parameterCd <- c("39630","39632")
#39630 - atrazine, water, unfiltered, recoverable, ug/L
#39632 - atrazine, water, filtered, recoverable, ug/L

####### DOWNLOADING WATER QUALITY DATA

#Site  number length has to be no less than 8 numeric digits
for (i in seq(1,length(Site_code))){
  site_numb = as.character(Site_code[i])
  if (nchar(site_numb)<8){
    site_numb = paste0("0", site_numb)
    Site_code[i] = site_numb
  }
} 
samples <- readWQPqw(paste0("USGS-", Site_code), parameterCd, startDate, endDate)

#Keeping important columns
samples_list <- samples %>% 
  select(site_no = MonitoringLocationIdentifier,
         startDateTime = ActivityStartDate,
         sampleType = ActivityMediaSubdivisionName,
         parm_cd = USGSPCode,
         hyd_cond_cd = HydrologicCondition,
         remark_cd = ResultDetectionConditionText,
         result_va = ResultMeasureValue) %>% 
  arrange(site_no, startDateTime)

samples_list$site_no = gsub("-","",samples_list$site_no)

#Removing NAs
samples_list_up = samples_list[-which(is.na(samples_list$result_va)),]

#Previously water quality could be downloaded using readNWISqw function, but NWIS functions are being retired
#Read more about it here: https://cran.r-project.org/web/packages/dataRetrieval/vignettes/qwdata_changes.html
