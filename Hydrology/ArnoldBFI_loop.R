#Ruta Basijokaite

#Input: Q_year - vector with stream flow values from one year (mm/year)
#Output: ArnoldBFI_v - yearly Arnold's baseflow index

ArnoldBFI_loop = function(Q_year){

  y = Q_year #should not have NA values
  qdt = matrix(0,1,length(Q_year))
  qbt = matrix(0,1,length(Q_year))
  pval = 0.925
  for (k in seq (2,length(Q_year))){
    qbt[k] = pval*qbt[k-1]+((1-pval)/2)*(y[k]+y[k-1])
    if (qbt[k] >= y[k]){
      qbt[k] = y[k]
    }
  }
  ArnoldBFI_v = sum(qbt)/sum(y)
  return(ArnoldBFI_v)
}