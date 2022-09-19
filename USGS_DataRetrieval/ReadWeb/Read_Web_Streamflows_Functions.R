# Function used for program reading USGS streamflows

##############################################################################
# This script will read in USGS daily streamflow data (cb_00060) from the  
# USGS website for a specified site number, start and end date. 
# The output will be a list where:
# gage = list[[1]]
# site name = list[[2]]
# matrix = list[[3]] where:
# year = matrix[,1]
# month = matrix[,2]
# day = matrix[,3]
# flow_cfs = matrix[,4]
##############################################################################

#----------------------------------------------------------------------------#
# Define variables

# site_no = site number
# start_date = beginning date
# end_date = ending date
# web = URL of USGS site 
# input = input data from USGS site 
# gage = gage name
# info = text connector for USGS input data 
# dmat = matrix as described above
# date = array of all dates
# output = list as defined above

read.web.flows <- function(site_no){
	#----------------------------------------------------------------------#
# Choose earliest possible date for start date

	  start_date<-'1880-1-1' #data record could start much later than that
    end_date<-'2019-12-31'
# Force site_no to be 8 digits

    #if site number is not 8 digits nr - it pastes 0 with not separation
	if (nchar(site_no)!=8){site_no<-paste('0',site_no,sep='')}

	#----------------------------------------------------------------------#
	# Combine input data into USGS URL

	web <-paste('https://waterdata.usgs.gov/nwis/dv?cb_00060=on&format=rdb&site_no=', site_no,'&referred_module=sw&period=&begin_date=',start_date,'&end_date=',end_date,sep='')
  	
  	#----------------------------------------------------------------------#
	# Read USGS flow URL as text lines

	input <- readLines(web)
	#----------------------------------------------------------------------#
	# Read gage information
	# Says take a subsection of line 15 from character 6 to the end of the line

	#at line 17 in the wbsite it says site name 
	gage <- substring(input[17],20,100)  #all characters from 20th character to 100th 	

	#----------------------------------------------------------------------#
	# Find row number of beginning of lines of data
	# Data starts on line which starts with "USGS . . . " so look for a "U"
    # toString takes the line and makes it a character string  
    # strsplit splits up all characters on line into separate units ('' means with no spaces), and makes a list out of them.
	# [[1]] means take the first item of the list and [1] says take the first character of this first list
    
	#looking for a line that starts with U (no spaces)
	for (i in seq(1:100)){ #assume its within first 100 lines
		if (strsplit(toString(input[i]),'')[[1]][1]=='U'){break} #if the first value is U - break (creates list)
	}

	#----------------------------------------------------------------------#
	# Read Flow data

	info <- textConnection(input[i:length(input)])
	dmat<-matrix(scan(info,sep='\t',what="",quiet=T),ncol=5,byrow=T)
  close(info)
	#----------------------------------------------------------------------#
	# Split date into year,month,day columns
	# paste converts to a character string, and then concatenates the string
	# Here strisplit splits the string based on having a dash
	# unlist produces a vector of elements in a string (i.e. it turns a list into a vector)
	# Note that the "\\" before "-" indicates that the character coming next is not part of alphabet

  #makes it numeric
	date <- as.numeric(unlist(strsplit(paste(dmat[,3]),"\\-"))) #\\ says its not a character
	date <- matrix(date,ncol=3,byrow=T)
	date <- data.frame(date)

  #----------------------------------------------------------------------#
	# Combine date matrix and flow array

	dmat <- cbind(date,as.numeric(dmat[,4]))
	colnames(dmat) <- c('year','month','day','flow_cfs')

	#----------------------------------------------------------------------#
	# Create output list

	output <- list(site_no,gage,dmat)
	names(output) <- c('site_no','gage','dmat')

	#----------------------------------------------------------------------#
	# Return result		

	return(output)
}
##############################################################################