#Ruta Basijokaite
#----------------
#Filling NA values with average from closest cells 
#----------------

###Variables:
#Data_v - dataset of interest that is being corrected 
#len - length of dataset
#NonNA - index of non NA values
#a - index of first non NA value

###Inputs:
#Data_v - data vector

NA_correct <- function(Data_v){
  len=length(Data_v)
  for (i in seq(1,len-1)){
    if (is.na(Data_v[i])){
      if (is.na(Data_v[i+1])){
        NonNA=which(!is.na(Data_v[i+1:len-1]))
        a=min(NonNA)+i-1
        Data_v[i:(a-1)]=0.5*(Data_v[i-1]+Data_v[a])}
      else {
        Data_v[i]=0.5*(Data_v[i-1]+Data_v[i+1])}}
  }
  return(Data_v)
}