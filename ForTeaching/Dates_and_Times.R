#------------------
#This code explores different date and time formats
#------------------
#Remove all data
rm(list=ls(all=T))

#To access the current date
a1 <- Sys.Date()
a1
class(a1)

#Examine information about the date 
months(a1)
weekdays(a1) 
quarters(a1)
julian(a1) # Julian is the number of days since the origin

b1 <- as.Date("1960-09-30")  #date of the end of 1960 water year
quarters(b1)
months(b1)
c1 <- as.Date("1960-10-01")  #date of beginning of 1961 water year
quarters(c1)
months(c1)

#Dates stored as the number of days since the origin (1970-01-01)
mat <- matrix(NA,3,3)
mat[,1] <- c(a1,b1,c1)
rownames(mat) <- c("a","b","c")
colnames(mat) <- c("Date","POSIXct","POSIXlt")
mat # Note that the dates before January 1, 1970 are negative  

#The “POSIXct” data type is the number of seconds since the start of January 1, 1970 (since the epoch; 
#this is sometimes called Unix time). Negative numbers represent the number of seconds before this time, 
#and positive numbers represent the number of seconds afterwards.
a2 <- Sys.time()
a2
class(a2)
#The class of this data is "POSIXct" "POSIXt"
#The same functions used with the “Date” class can still be used
months(a2)
weekdays(a2)
quarters(a2)
julian(a2)

#We can also set the same dates as b1 and c1 as “POSIXct”:
b2 <- as.POSIXct("1960-09-30")  #date of the end of 1960 water year
quarters(b2)
months(b2)

c2 <- as.POSIXct(c1)  #date of beginning of 1960 water year
quarters(c2)
months(c2)

#Note that when only a date is inputted, the time can also be assigned:
a2
b2
c2

b2 <- as.POSIXct("1960-09-30 14:00 EDT")  
b2

#A vector of these dates can also be including in a larger matrix or data frame, although they 
#appear as the number of seconds since 1970-01-01 00:00:00 UTC (Universal Coordinated Time, the basis 
#for time and time zone worldwide):
mat[,2] <- c(a2,b2,c2)
mat
#You can see that these values are stored as the number of seconds since January 1, 1970.

#The “POSIXlt” data type is a list (multidimentional vector), and the entries in the list have the specific meanings 
a3 <- as.POSIXlt(Sys.time())
a3
class(a3)

#The same functions can still be used
months(a3)
weekdays(a3)
quarters(a3)
julian(a3)
#where again julian is the number of days since the origin of January 1, 1970.  
#“POSIXlt”, though, allows you to access a lot more information than the other data classes, and generally is preferred.
#“POSIXlt” allows you to access the number associated with every component of a date.

a3$sec #seconds, 0-61 (somehow???)
a3$min #minutes, 0-59 
a3$hour #hours, 0-23
a3$mday #day of the month, 1-31
a3$mon #(whole) months after the first of the year, 0-11
a3$year #years since 1900
a3$wday #day of the week (start Sunday), 0-6
a3$yday #day of the year, 0-365
a3$isdst #daylight savings time flag, yes=(+), no=0, ?=(-)

#Notice that some of the values do not look how you'd expect:
a3$mon
a3$year
a3$wday
a3$yday

#These require a quick conversion by adding the origin (usually 1):
a3$mon + 1
a3$year + 1900
a3$wday + 1
a3$yday + 1

#These capabilities open up more possibilities for how to distinguish the first day of the water year and leap years:
b3 <- as.POSIXlt("1960-09-30")
quarters(b3)
b3$mon + 1
b3$mday
c3 <- as.POSIXlt("1960-10-01")
quarters(c3)
c3$mon + 1
c3$mday

#One drawback to POSIXlt data is that it cannot be part of a larger matrix.
mat[,3] <- c(a3,b3,c3)
#This is because POSIXlt makes the date components into a list (a new data format we will use a lot in this class). 
#There are actually 9 values behind each date. Instead you must keep the dates as a separate array.
mat2 <- c(a3,b3,c3)
mat2

#### MANIPULATING DATES

#Adding one day to current date/time depends on the data format.  
#For the “Date” class, adding 1 will you move 1 day forward from the current date (number of days from 1970-01-01):
a1 + 1

#or subtract a week
a1 - 7

#or add 30 days
a1 + 30

#POSIXct and POSIXlt both ultimately count to number of seconds since the 1970-01-01 00:00:00 UTC, 
#so you need to add the number of seconds in a day to add one day:
a2 + 86400 
a3 + 86400
a3 - 86400

#POSIXlt is additionally separated into several components in a list, so you can also add to the day of the month 
#(this is more intuitive and sometimes makes more sense in your code):
a3  
a3$mday <- a3$mday+1
a3

#This list format no longer works with POSIXlt
#a3[[1]]
#a3[[2]]
#a3[[3]]
#a3[[4]]
#a3[[5]]
#a3[[6]]
#The double bracket “[[#]]” allow you to access different elements of a list. 
#One nice thing about lists is the data doesn’t need to be in the same format (unlike a matrix) or length (unlike a data frame).
  
#### HANDLING DIFFERENT DATA FORMATS

#If your date has an unusual format, you will get an error when you try converting it to an R date 
#format. To specify the format, you will need to look at the help for "strptime" to find how to 
#specify your format (look under the "Details" section).
help(strptime)
  
#Most commonly used with dates (there are others):
    
# "%b" = Three-letter abbreviated month name
# "%B" = Full month name
# "%d" = Day of the month as decimal number (01-31)
# "%m" = Month as decimal number (01-12)
# "%Y" = Year with century (eg. 2014)
# "%y" = Year without century (00-99).  
#where 00-68 are taken to be the 21st century (eg."68" means 2068 not 1968) and 69-99 are 20th century

d1 <- "01/31/2000"
class(d1)
d1_new<-as.POSIXlt(d1, format="%m/%d/%Y")
d1_new
class(d1_new)
d1_new2<-as.Date(d1, format="%m/%d/%Y")
class(d1_new2)
  
d2 <- "January 31, 2000"
as.POSIXlt(d2, format="%B %d, %Y")
  
d3 <- "1:00PM Jan 31, 2000"
as.POSIXlt(d3, format="%I:%M%p %b %d, %Y")
  
d4 <- "01-31-1968"
as.POSIXlt(d4, format="%m-%d-%Y")
  
d5 <- "01-31-68"
d5b<-as.POSIXlt(d5, format="%m-%d-%y")
d5b
d5c<-as.POSIXlt(as.Date(d5b)-100*365.25)
d5c
library(lubridate)
d5d<-d5b %m+% years(-100)
d5d

#NOTE: if converting from a number, you will need to specify the origin and possibly apply some scaling. For example, 
#Excel's "Jan 21, 2014" (the default origin in Excel) is represented as 41660 days since Dec 31, 1899, and with some trial-and-error 
#you can get these conversions to work out:

# January 21, 2014  
as.Date(41660, origin="1899-12-30")
as.POSIXct(41660*86400, origin="1899-12-30 5:00 UTC")
as.POSIXlt(41660*86400, origin="1899-12-30 5:00 UTC")
  
