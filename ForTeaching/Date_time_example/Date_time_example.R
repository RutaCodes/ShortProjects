#Example of Using Date Formats 

#Read in the file “Metro_pH_2008.txt”, which contains pH data for effluent and bypass flows at 
#Syracuse’s Metro Wastewater Treatment Plant:

input1 <- read.delim(file="Metro_pH_2008.txt", header=T, sep="\t")
# \t -- tab separated file
colnames(input1)

#The “read.delim” command reads in a file in a table format (like read.csv), but allows you to 
#identify how the data is formatted (this file is tab delimited, thus the “\t”).

#Convert the dates column to “POSIXlt” and storing them as a separate variable:

dates <- as.POSIXlt(input1[,1], format="%d-%b-%y")

#Taking the pH values:

pH <- as.numeric(input1[,9])

#Find the number of days in each month that you have data for:

numdays1 <- matrix(0,nrow=12, ncol=2) # 12 rows and 2 columns, can be numbers on their own to create blank matrix
#how many samples in each
for(i in seq(1,length(dates))) {
  numdays1[(dates$mon[i]+1),2] <- numdays1[(dates$mon[i]+1),2] + 1
}

#Set the name of each month:

numdays1[,1] <- month.name
#intergers turned to character type
numdays1

#Since numdays1 is a matrix, you can see that the format of the data in the matrix is now characters. 
#We can also set the column names as:

colnames(numdays1) <- c("Month","Days")
numdays1

#You will now find the average pH over each quarter of the year.  First set up a matrix to contain 
#the output (avg:  first column will be the quarter of the year and the second column with the average pH) 
#and the number of pH measurements in each quarter of the year:

avg <- matrix(0, nrow=4, ncol=2)
count <- array(0,4)

#Now create a loop that goes through all of the data points, extracts the quarter of the year in which 
#the data was taken, turns this into a numerical value, and sums and counts the pH values in each year:

for(i in seq(1, length(dates))){
  n <- as.numeric(substr(quarters(dates[i]),2,2))
  avg[n,2] <- avg[n,2] + pH[i]
  count[n] <- count[n] + 1
}

#Determine the average pH and put into the 2nd column of avg:

avg[,2] <- avg[,2]/count
avg[,2] <- round(avg[,2],2)

#Determine the quarter by putting the “Q” in front of a numeric value (1:4) with no spaces using the paste command:

avg[,1] <- paste("Q",1:4, sep="")

#Add some column headings:

colnames(avg) <- c("Quarter", "Average pH")
avg

#Notes that since avg is a matrix, and the quarter is a character, the pH values turn into a character.
#pH values need to be numerical if any numerical operations will be done 

#Creating data frame instead of matrix 
avg2 <- data.frame(avg[,1],as.numeric(avg[,2]))
colnames(avg2) <- c("Quarter", "Average pH")
avg2
