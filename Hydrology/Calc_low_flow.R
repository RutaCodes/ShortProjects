#Ruta Basijokaite
#----------------
#This function calculates 7-day 10-year low streamflow using a 3-parameter lognormal distribution
#----------------

###Variables:
#zp - p-th percentile from a standard normal distribution
#Y_bar - natural log of the data average
#N - length of input
#Sy - standard deviation of Y_ap/minimum (depending if statement is correct)
#Q7_10 - 7-day 10-year low streamflow using a 3-parameter lognormal distribution
#LB_est - lower bound
#Y_ap - latural log of the data minus lower bound
#Y_bar - mean of Y_ap

###Inputs:
#mini - annual 7 day minimums
#perc - percentile 

LN3 <- function(mini, perc){
  zp<-qnorm(perc)
  if (min(mini)+max(mini)-2*median(mini)<=0) { 
    Y=log(mini)
    N=length(mini)
    Y_bar=mean(Y) #Y_bar=sum(log(mini))/length(mini)
    Sy=sd(Y) #Sy=sqrt(sum((log(mini)-Y_bar)^2))/(length(mini)-1)
    Q7_10=exp(Y_bar+zp*Sy)
  }
  else {
    #Lower bound
    LB_est<-(min(mini)*max(mini)-median(mini)^2)/(min(mini)+max(mini)-(2*median(mini)))
    #Y
    Y_ap=log(mini-LB_est)
    #N_ap=length(Y_ap)
    Y_bar=mean(Y_ap) #Y_bar=sum(Y_ap)/length(Y_ap)
    Sy=sd(Y_ap) #Sy=sum((Y_ap-Y_bar)^2)/(length(Y_ap)-1)
    #100 year flood
    Q7_10=LB_est+exp(Y_bar+zp*Sy)
  }
  return(Q7_10)  
}
