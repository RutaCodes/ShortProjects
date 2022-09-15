#Ruta Basijokaite

#This functions standardizes given dataset

Standardizing_data = function(DATA){
  DATA_stand = data.frame(matrix(0,dim(DATA)[1],dim(DATA)[2])) 
  for (i in seq(from=1, to=dim(DATA)[2])){
    #Identifying NA values in the dataset
    D_ind = which(!is.na(DATA[,i]))
    #Standardizing data one column/site at a time
    DATA_stand[D_ind,i] = (DATA[D_ind,i]-mean(DATA[,i],na.rm = TRUE))/sd(DATA[,i],na.rm = TRUE)
  }
  return(DATA_stand)
}