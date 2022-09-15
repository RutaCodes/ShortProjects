#Ruta Basijokaite

#This functions normalizes given dataset

Normalizing_data = function(DATA){
  DATA_norm = data.frame(matrix(0,dim(DATA)[1],dim(DATA)[2])) 
  for (i in seq(from=1, to=dim(DATA)[2])){
    #Identifying NA values in the dataset
    D_ind = which(!is.na(DATA[,i]))
    #Normalizing data one column/site at a time
    DATA_norm[D_ind,i] = (DATA[D_ind,i]-min(DATA[,i],na.rm = TRUE))/
      (max(DATA[,i],na.rm = TRUE)-min(DATA[,i],na.rm = TRUE))
  }
  return(DATA_norm)
}