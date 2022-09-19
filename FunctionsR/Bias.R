#Ruta Basijokaite
#----------------
#This function calculates bias
#----------------

###Variables:
#Aver_v - predicted average values
#Aver_v_obs - observed average values
#sum_bias - numerator of bias formula
#N - lenght of dataset
#bias_val - bias value

###Inputs:
#Aver_v - vector with predicted values
#Aver_v_obs - vector with observed values

Bias_v <- function(Aver_v,Aver_v_obs){
  sum_bias=0
  N=length(Aver_v)
  for (i in seq(1,N)){
    sum_bias=sum_bias+(Aver_v[i]-Aver_v_obs[i])
  }
  bias_val=round(sum_bias/N,2)
  return(bias_val)
}
