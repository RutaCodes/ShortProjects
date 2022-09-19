#Ruta Basijokaite
#----------------
#This function calculates Nash Sutcliffe Efficiency (NSE)
#----------------

###Variables:
#Aver_v - predicted average values
#Aver_v_obs - observed average values
#N - lenght of dataset
#sum_den - denominator of NSE formula
#sum_num - numerator of NSE formula
#NSE_val - NSE value

###Inputs:
#Aver_v - vector with predicted values
#Aver_v_obs - vector with observed values

NSE_v <- function(Aver_v,Aver_v_obs){
  sum_den=0
  sum_num=0
  N=length(Aver_v)
  for (i in seq(1,N)){
    sum_num=sum_num+(Aver_v[i]-Aver_v_obs[i])^2
    sum_den=sum_den+(Aver_v_obs[i]-mean(Aver_v_obs))^2
  }
  NSE_val=round(1-sum_num/sum_den,2)
  return(NSE_val)
}
