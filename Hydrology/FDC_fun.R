#Ruta Basijokaite
#----------------
#This function calculates median flow duration curve
#----------------

###Variables:
#N - length of yearly flows
#Q_sort - sorted streamflow
#rank - ranked streamflows
#Ex_p - exceedance probability
#i1 - rank (integer) of specified percentile
#theta - estimator
#Q_f - streamflow at specified percentiles

###Inputs:
#flow - vector with discharge values
#percentiles - percentiles of interest

FDC_loop<-function(flow,percentiles){
  
  N<-length(flow)
  Q_sort=sort(flow,decreasing=TRUE)
  rank=1:N
  Ex_p=(rank/(1+N))
  
  i1=floor((N+1)*percentiles)
  theta=((N+1)*percentiles-i1)
  
  Q_f=(1-theta)*Q_sort[i1]+theta*Q_sort[i1+1]
  return(Q_f)

}
