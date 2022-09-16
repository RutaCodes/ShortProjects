#Ruta Basijokaite

# Dataset has missing data - what to do?

#### CALCULATING AVERAGE
#Calculating average when variable has missing/NA values
data1 = c(1,2,NA,4,NA,6) #Creating variable 
mean(data1,na.rm=T) #Calculates mean values using numeric values while ignoring NAs

#Removing NAs 
na.omit(data1) 
#Calculating mean values omitting NAs
mean(na.omit(data1))
#----------------------------
#### REPLACING CERTAIN VALUES
data2 = c(7,999.99,10,999.99,12)
#Replacing 999 values with NAs
for (i in seq(1,length(data2))){
  if (data2[i] == 999.99){
    data2[i] = NA
  }
}
#This command does the same
data2[data2==999.99] = NA

#In case variable has multiple iterations of 999.99 (e.g. 999.9) that symbolize missing values, find if quotient of that
#value is equal to 999
for (i in seq(1,length(data2))){
  #Using %/% operator to check if quotient is equal to 999, in case NA values have varying number of decimal places 
  #e.g. (999.9 %/% 1 == 999) and (999.9999 %/% 1 == 999)
  if ((data2[i] %/% 1) == 999){ 
    data2[i] = NA
  }
}

#----------------------------
#### CREATING NEW VARIABLES USING COMPLETE ROWS
A = c(1,NA,3,4,5,6,6)
B = c(6,7,NA,9,10,10,5)
C = c(11,12,13,NA,NA,15,5)
D = c(16,17,18,19,20,20,5)
#Creating an array using 4 separate vectors A,B,C,D
data3 = cbind(A,B,C,D) #combining columns
complete.cases(data3) #this command gives T/F string identifying which rows do not have any NA values 
#Creating a new array containing only full rows and removing rows that had any NA values
matrix(data3[complete.cases(data3)],length(which(complete.cases(data3))),dim(data3)[2])

#Creating data frame using 4 separate vectors A,B,C,D
data4 = data.frame(A,B,C,D)
#Function na.omit creates a new array using only complete rows in array, giving the same results as command in line 42
na.omit(data4)
       
#----------------------------
#### INFINITY VALUES
e = c(1,2,3,4,-4)
f = c(1,0,0,2,0)
#After performing matrix algebra, values divided by 0 will result in infinity
g = e/f
#Idenfity which cells are equal to infinity
gINF = is.infinite(g)
       