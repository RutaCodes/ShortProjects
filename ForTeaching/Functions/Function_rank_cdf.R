#Create a function that will return the 3 largest values from an array and determine an estimate
#of the cdf for each data point

#Example variable with 10 random values
x<-rnorm(10)

fun_rand<-function(x){
  i=rank(x)
  l_v=x[order(-i)] #sorting from largest to smallest; also could use sort(x, decreasing = T)
  l3=l_v[1:3]
  #cdf formula
  val=i/(length(x)/+1)
  #creating output file by combiling those two variables into one
  #cbind puts to columns
  outp=cbind(l3,round(val[(length(x)-2):length(x)],3))
  return(outp)
}

fun_rand(x)
