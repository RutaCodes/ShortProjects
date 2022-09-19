# Base program for Reading USGS Streamflows directly from website

##############################################################################
# This script will read in daily average streamflows from multiple USGS gauging site
# The data is obtained directly from the internet using the url and the station number
##############################################################################

#----------------------------------------------------------------------------#
# remove all variables

rm(list=ls(all=TRUE))

#----------------------------------------------------------------------------#
# Start timer

ptm <- proc.time()

#----------------------------------------------------------------------------#
# Name files
# sites.csv contains a list of usgs gauge numbers

source('Read_Web_Streamflows_Functions.R')
site_file <- 'sites1.csv'

# Turn off warnings

options(warn=-1)
	
#----------------------------------------------------------------------------#
# Import list of site 

#gives USGS site numbers
sites1 <- as.array(read.csv(site_file,header=F)[,1])

#----------------------------------------------------------------------------#
# Read in site numbers, gage name, and flows
# Save all flows in the 

site_info <- list()

#Reach USGS site and read Q values from website
for (i in seq(1:length(sites1))){
	site_info[[i]] <- read.web.flows(sites1[i])
}

time <- proc.time() - ptm
time[3]

##############################################################################
#retrieve info from list e.g.site_info[[1]][[1]]
#site_info[[N]][[1]] - site number
#site_info[[N]][[2]] - site name
#site_info[[N]][[3]] - year, month, day, streamflow value
