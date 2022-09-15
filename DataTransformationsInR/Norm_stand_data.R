#Ruta Basijokaite
#-------------------------------------
#This code standardized and normalizes data array
#-------------------------------------
#### LOADING DATA AND DEFINING VARIABLES 

#Loading data array
#Enter your csv file name here
#For example 
file="Q_mm_final_list_0912.csv"
DATA <- read.csv(file,sep=",",header=T)

#colnames(DATA)

#-------------------------------------
#### NORMALIZING DATA

source("Norm_data.R")
DATA_nor_var = cbind(DATA[,1],Normalizing_data(DATA[,-1])) #first columns has dates - don't need to be transformed
colnames(DATA_nor_var) = colnames(DATA)

#-------------------------------------
#### STANDARDIZING DATA

source("Stand_data.R")
DATA_stand_var = cbind(DATA[,1],Standardizing_data(DATA[,-1])) #first columns has dates - don't need to be transformed
colnames(DATA_stand_var) = colnames(DATA)

#-------------------------------------
#### VISUALIZING TRANSFORMATION RESULTS

#Picking column/site to explore transformation results 
WS = 4 
#Before transformation
d=density(DATA[which(!is.na(DATA[,WS])),WS]) 
plot(d, main = "Before transformation")

#After normalizing
d2=density(DATA_nor_var[which(!is.na(DATA_nor_var[,WS])),WS]) 
plot(d2, main = "After normalizing")

#After standardizing
d3=density(DATA_stand_var[which(!is.na(DATA_stand_var[,WS])),WS]) 
plot(d3, main = "After standardizing")

#------------------------
