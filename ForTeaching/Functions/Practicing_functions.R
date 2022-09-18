#Sample code to practice building and using functions

#Function to calculate mean 
avg<-function(x){
  n=length(x)
  sum1=0
  for (i in seq(1,n)){
    sum1=sum1+x[i]
  }
  mean=sum1/n
  return(mean)
}

#Creating two variables and calculating their averages using function 'avg'
x<-c(1,2,3,4,5)
y<-c(6,7,8,9,10)
avg(x)
avg(y)

#Creating an array variable that has two columns and number of rows to match length of variables x and y
z<-matrix(0,length(x),2)
z
#Assigning values
z[,1]=x
z[,2]=y
z
avg(z)

#Creating data frame
data1<-data.frame(x,y,z)
data1
avg(data1)

#or use

apply(data1,MARGIN=1,FUN=avg) 
#This command allows to choose what average is calculated
#MARGIN=2 apply to the columns
#MARGIN=1 apply to the rows

#Summarizing variables
summary(x)
summary(data1)
