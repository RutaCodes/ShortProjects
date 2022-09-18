# Sample Script

#  Description:  This script a) reads in the Syracuse precipitation and temperature file, 
#  b) changes the temperatures to Celsius and the precipitation to meters, 
#  c) set a flag = 1 if the average low temperature is below freezing (flag = 0 if above freezing)
#  d) calculates the average of these variables for the first 6 months of the year, and
#  e) write out the month, average monthly minimum temperature in C, the value of the flag, and
#  the average monthly minimum temperature over the first 6 months of the year

# Variable Descriptions
# input1 = data frame containing the average monthly low temp, high temp, and precip for Syracuse
# Average_Low_Temp_F = array of average monthly low temperatures in F
# Average_High_Temp_F = array of average monthly high temperatures in F
# Average_Prec_in = array of average monthly precipitation in inches
# Average_Low_Temp_C = array of average monthly low temperatures in C
# Average_High_Temp_C = array of average monthly high temperatures in C
# Average_Prec_m = array of average monthly precipitation in inches
# i = for loop counter
# Freezing_flag = freezing flag equal to 1 if average monthly low temp is below 0 C; flag equals 0 if not 
# sum1 = summations to calculate averages
# Avg_Low_Temp_6M_C = Average low temp for the 1st 6 months in C
# Avg_High_Temp_6M_C = Average high temp for the 1st 6 months in C
# Avg_Prec_6m_m = Average precip for the 1st 6 months in meters


# Read in input file

input1 <- read.csv(file= "Syracuse_Average_Temp_and_Precip.csv") 

# Change the units of the temperature files to Celsius

Average_Low_Temp_C = (5/9)*(input1$Average_Low_Temp_F-32)
Average_High_Temp_C = (5/9)*(input1$Average_High_Temp_F-32)

# Change the units of precipitation to meters (1 in = 0.0254 m)

Average_Prec_m = 0.0254*input1$Average_Precip_in

# Determine the dimensions of the data frame input 1
# The first dimension of d is the # of rows
# The second dimension of d is the # of columns

d=dim(input1)
d

# Create an array called flag that is of length 12 (which is d[1])

Freezing_flag <- array(0,d[1])

# Perform a loop through all months setting flag to 1 if avg low temp is below freezing

for (i in seq(1,d[1])){

   if (Average_Low_Temp_C[i] < 0)   {Freezing_flag[i]=1} else {Freezing_flag[i]=0}

}

# Determine the average over the 1st 6 months of the year the long way

sum1=0.0

for (i in seq(1,6)){

  sum1=sum1+Average_Low_Temp_C[i]

  print(i)
  print(sum1)
  y=scan(n=1) #asks for input, so it stops after n=1, alllows to go step by step

}

Avg_Low_Temp_6M_C<-sum1/6.0

# You could also do the above command much easier as

Avg_Low_Temp_6M_C_2<-sum(Average_Low_Temp_C[1:6])/6

# or 

Avg_Low_Temp_6M_C_3<-mean(Average_Low_Temp_C[1:6])

Avg_High_Temp_6M_C<-mean(Average_High_Temp_C[1:6])

Avg_Prec_6m_m<-mean(Average_Prec_m[1:6])

# Round to Average_Low_Temp_C to 2 decimal places

Average_Low_Temp_C = round(Average_Low_Temp_C,digits=2) 

# Create a data frame for output

output1 <- data.frame(input1$Month,Average_Low_Temp_C,Freezing_flag)

# Write output to a file

write.table(output1,"script1.out",quote=FALSE,append=FALSE,sep="  ",row.names=FALSE)

# Force a line in the output

write("   ","script1.out",append=TRUE)

# Write a ouptput identifier for Average Low Temperarature (C) for first 6 months 

write("Average Low Temperature (C) for first 6 months = ","script1.out",append=TRUE)

# Print out value of Average Low Temp for first 6 months after reducing to 1 decimal place

Avg_Low_Temp_6M_C=round(Avg_Low_Temp_6M_C,digits=1)

write(Avg_Low_Temp_6M_C,"script1.out",append=TRUE)

