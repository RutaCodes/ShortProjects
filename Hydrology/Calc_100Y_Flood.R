#Ruta Basijokaite
#----------------
#This function calculates 100 year flood value using log-Pearson III distribution
#----------------

###Variables:
#zp - p-th percentile from a standard normal distribution
#Y - log of input
#N - length of input
#Y_bar - natural log of the data minus lower bound
#Sy - standard deviation of Y_ap
#Gy - real space coeff of skewness
#Gy_ap - unbiasing factor
#Kp - frequency factor
#Q_LP3 - 100 year flood using a log-Pearson III distribution

###Inputs:
#maxi - vector of annual maximums
#per - percentile

LP3<-function(maxi,per){
  zp<-qnorm(per)
  Y<-log(maxi)
  N=length(maxi)
  Y_bar<-mean(Y) #Y_bar=sum(log(x_dis))/N
  Sy<-sd(Y) #Sy=sqrt(sum((log(x_dis)-Y_bar)^2)/(N-1))
  Gy=(N*sum((Y-Y_bar)^3))/((N-1)*(N-2)*Sy^3)
  Gy_ap=(1+6/N)*Gy
  Kp=(2/Gy_ap)*((1+(zp*Gy_ap/6)-((Gy_ap^2)/36))^3)-(2/Gy_ap)
  Q_LP3=exp(Y_bar+Kp*Sy)
  return(Q_LP3)
}
