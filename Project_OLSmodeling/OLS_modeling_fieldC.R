#------------------------------------------
#This code performs correlation analysis to study relationship among different nutrients, study site
#land covers, and between land cover and observed nutrient concentrations.
#Then the most influential land cover types are then used to develop OLS model to predict nutrient 
#concentrations using land cover percentage  as explanatory variable
#-----------------------------------------

#Uploading measured concentrations
#Nutrient type = row name, site name = column name
Analyte_conc<-read.csv(file="Analyte_conc.csv",sep=",",row.names=1,header=T) 

#### CORRELATION ANALYSIS ####

#Hmisc contains many functions useful for data analysis, including correlation analysis
library("Hmisc")
#Library for ploting correlation analysis results
library(corrplot)
#Analyzing correlation patterns among studied nutrient analytes
#Spearman correlation coefficient was used as it could not be assumed that relationship among variables
#is linear. Spearman correlation coefficient evaluates monotonic relationship among variables, which is a better fit
#to evaluate a relationship between environemnatal variables.
rcor_vals_spear=rcorr(as.matrix(Analyte_conc),type = c("spearman"))
corrplot(rcor_vals_spear$r,tl.col="black")
rcor_vals_spear_IC_site=rcorr(as.matrix(IC_data),type = c("spearman"))
corrplot(rcor_vals_spear_IC_site$r,tl.col="black")
rcor_vals_spear_no_salty_lakes=rcorr(as.matrix(Analyte_conc[,1:10]),type = c("spearman"))
corrplot(rcor_vals_spear_no_salty_lakes$r,tl.col="black")

#Concentrations split by detection method
Hach_data=t(Analyte_conc[1:3,])
IC_data=t(Analyte_conc[4:8,1:10])
#analyzing study site correlations separately based on analysis method
rcor_vals_spear_hach=rcorr(as.matrix(Hach_data),type = c("spearman"))
corrplot(rcor_vals_spear_hach$r,tl.col="black")
rcor_vals_spear_IC=rcorr(as.matrix(IC_data),type = c("spearman"))
corrplot(rcor_vals_spear_IC$r,tl.col="black")

#Analyzing co-occurance patterns among analyte concentrations
Analyte_conc_t=t(Analyte_conc)
#Changing column names 
colnames(Analyte_conc_t)=c('Phospohorus (mg/L)','Ammonia (mg/L)','Potassium (mg/L)','Fluoride (mg/L)',
                           'Chloride (mg/L)','Nitrate (mg/L)','Phosphate (mg/L)','Sulphate (mg/L')
rcor_vals_spear_analytes=rcorr(as.matrix(Analyte_conc_t),type = c("spearman"))
corrplot(rcor_vals_spear_analytes$r,tl.col="black")

#Analyzing study site land cover correlations
Land_cover<-read.csv(file="Land_cover_field_course1.csv",sep=",",row.names=1,header=T) 
land_vals_spear=rcorr(as.matrix(Land_cover),type = c("spearman"))
corrplot(land_vals_spear$r,tl.col="black")

#Removing 2 sites that do not have land use data
Analyte_land_t=Analyte_conc_t[-c(3,9),]
Land_t=t(Land_cover)
#Another function that can be used to perform correlation analysis - cor
#It is more convenient to use when distict correlations between two sets are analyzed, as it does not report 
#correlation values for each dataset, but reports only correlations between two sets
cor_mat_clim_spear=cor(Analyte_land_t,Land_t,use="pairwise.complete.obs",method = c("spearman"))
corrplot(cor_mat_clim_spear,tl.col="black")

#Using rcorr function calculates correlation between two sets in addition to correlations among columns in two 
#analyzed datasets. 
rcor_vals_spear_analyte_land=rcorr(as.matrix(cbind(Analyte_land_t,Land_t)),type = c("spearman"))
corrplot(rcor_vals_spear_analyte_land$r,tl.col="black")
#Results using cor function are identical to values in the upper right quadrant produced using rcorr function
View(rcor_vals_spear_analyte_land$r)
View(cor_mat_clim_spear)

#### end ####
#------------------------------
#### MODELING ####
#Model for each nutrient is developed separately, as land cover influence on observed concentrations will vary 
#from compound to compound
#In total, 3 different linear models were created: nitrate, ammonia, sulphate

############  Nitrate Model

#Analyzing relationship between concnetrations and different land cover types
plot(Land_t[,4],Analyte_land_t[,6],pch=20,xlab=paste("Forested Land Cover %"),ylab=paste("Nitrate (mg/L)"))
#adding linear trend
abline(glm(Analyte_land_t[,6]~Land_t[,4]), col="blue",lwd=1,lty=2)

plot(Land_t[,2],Analyte_land_t[,6],pch=20,xlab=paste("Developed Land Cover %"),ylab=paste("Nitrate (mg/L)"))
abline(glm(Analyte_land_t[,6]~Land_t[,2]), col="blue",lwd=1,lty=2)

plot(Land_t[,5],Analyte_land_t[,6],pch=20,xlab=paste("Shrub Land Cover %"),ylab=paste("Nitrate (mg/L)"))
abline(glm(Analyte_land_t[,6]~Land_t[,5]), col="blue",lwd=1,lty=2)

plot(Land_t[,6],Analyte_land_t[,6],pch=20,xlab=paste("Herbaceous Land Cover %"),ylab=paste("Nitrate (mg/L)"))
abline(glm(Analyte_land_t[,6]~Land_t[,6]), col="blue",lwd=1,lty=2)

plot(Land_t[,7],Analyte_land_t[,6],pch=20,xlab=paste("Hay/Pasture Land Cover %"),ylab=paste("Nitrate (mg/L)"))
abline(glm(Analyte_land_t[,6]~Land_t[,7]), col="blue",lwd=1,lty=2)

plot(Land_t[,8],Analyte_land_t[,6],pch=20,xlab=paste("Cultivated Crops Land Cover %"),ylab=paste("Nitrate (mg/L)"))
abline(glm(Analyte_land_t[,6]~Land_t[,8]), col="blue",lwd=1,lty=2)

#Predictive OLS model for nitrate
#6 explanatory variables are used to predict nitrate concetrations in surface water:
#Forested, developed, shrub, herbaceous, hay/pasture, cultivated crops
Nitrate_model=lm(Analyte_land_t[,6]~Land_t[,4]+Land_t[,2]+Land_t[,5]+Land_t[,6]+Land_t[,7]+Land_t[,8])
summary(Nitrate_model)$r.squared
#Ploting results
plot(Analyte_land_t[1:8,6],Nitrate_model$fitted.values,pch=20,ylab=paste("Predicted Conc. (mg/L)"),xlab=paste("Nitrate (mg/L)"))
abline(glm(Nitrate_model$fitted.values~Analyte_land_t[1:8,6]), col="blue",lwd=1,lty=2)

############  Ammonia Model
plot(Land_t[,4],Analyte_land_t[,2],pch=20,xlab=paste("Forested Land Cover %"),ylab=paste("Ammonia (mg/L)"))
abline(glm(Analyte_land_t[,2]~Land_t[,4]), col="blue",lwd=1,lty=2)

plot(Land_t[,2],Analyte_land_t[,2],pch=20,xlab=paste("Developed Land Cover %"),ylab=paste("Ammonia (mg/L)"))
abline(glm(Analyte_land_t[,2]~Land_t[,2]), col="blue",lwd=1,lty=2)

plot(Land_t[,5],Analyte_land_t[,2],pch=20,xlab=paste("Shrub Land Cover %"),ylab=paste("Ammonia (mg/L)"))
abline(glm(Analyte_land_t[,2]~Land_t[,5]), col="blue",lwd=1,lty=2)

plot(Land_t[,6],Analyte_land_t[,2],pch=20,xlab=paste("Herbaceous Land Cover %"),ylab=paste("Ammonia (mg/L)"))
abline(glm(Analyte_land_t[,2]~Land_t[,6]), col="blue",lwd=1,lty=2)

plot(Land_t[,7],Analyte_land_t[,2],pch=20,xlab=paste("Hay/Pasture Land Cover %"),ylab=paste("Ammonia (mg/L)"))
abline(glm(Analyte_land_t[,2]~Land_t[,7]), col="blue",lwd=1,lty=2)

plot(Land_t[,8],Analyte_land_t[,2],pch=20,xlab=paste("Cultivated Crops Land Cover %"),ylab=paste("Ammonia (mg/L)"))
abline(glm(Analyte_land_t[,2]~Land_t[,8]), col="blue",lwd=1,lty=2)

Ammonia_model=lm(Analyte_land_t[,2]~Land_t[,4]+Land_t[,2]+Land_t[,5]+Land_t[,6]+Land_t[,7]+Land_t[,8])
summary(Ammonia_model)$r.squared
plot(Analyte_land_t[,2],Ammonia_model$fitted.values,pch=20,ylab=paste("Predicted Conc. (mg/L)"),xlab=paste("Ammonia (mg/L)"))
abline(glm(Ammonia_model$fitted.values~Analyte_land_t[,2]), col="blue",lwd=1,lty=2)

#Reducing number of explanatory variables. Only including variables that were identified as significant in the 
#model above
Ammonia_model2=lm(Analyte_land_t[,2]~Land_t[,2]+Land_t[,6]+Land_t[,8])
summary(Ammonia_model2)$r.squared
plot(Analyte_land_t[,2],Ammonia_model2$fitted.values,pch=20,ylab=paste("Predicted Conc. (mg/L)"),xlab=paste("Ammonia (mg/L)"))
abline(glm(Ammonia_model2$fitted.values~Analyte_land_t[,2]), col="blue",lwd=1,lty=2)

############ Sulphate Model
plot(Land_t[,4],Analyte_land_t[,8],pch=20,xlab=paste("Forested Land Cover %"),ylab=paste("Sulfate (mg/L)"))
abline(glm(Analyte_land_t[,8]~Land_t[,4]), col="blue",lwd=1,lty=2)

plot(Land_t[,2],Analyte_land_t[,8],pch=20,xlab=paste("Developed Land Cover %"),ylab=paste("Sulfate (mg/L)"))
abline(glm(Analyte_land_t[,8]~Land_t[,2]), col="blue",lwd=1,lty=2)

plot(Land_t[,5],Analyte_land_t[,8],pch=20,xlab=paste("Shrub Land Cover %"),ylab=paste("Sulfate (mg/L)"))
abline(glm(Analyte_land_t[,8]~Land_t[,5]), col="blue",lwd=1,lty=2)

plot(Land_t[,6],Analyte_land_t[,8],pch=20,xlab=paste("Herbaceous Land Cover %"),ylab=paste("Sulphate (mg/L)"))
abline(glm(Analyte_land_t[,8]~Land_t[,6]), col="blue",lwd=1,lty=2)

plot(Land_t[,7],Analyte_land_t[,8],pch=20,xlab=paste("Hay/Pasture Land Cover %"),ylab=paste("Sulphate (mg/L)"))
abline(glm(Analyte_land_t[,8]~Land_t[,7]), col="blue",lwd=1,lty=2)

plot(Land_t[,8],Analyte_land_t[,8],pch=20,xlab=paste("Cultivated Crops Land Cover %"),ylab=paste("Sulphate (mg/L)"))
abline(glm(Analyte_land_t[,8]~Land_t[,8]), col="blue",lwd=1,lty=2)

Suplhate_model=lm(Analyte_land_t[,8]~Land_t[,4]+Land_t[,2]+Land_t[,5]+Land_t[,6]+Land_t[,7]+Land_t[,8])
summary(Suplhate_model)$r.squared
plot(Analyte_land_t[1:8,8],Suplhate_model$fitted.values,pch=20,ylab=paste("Predicted Conc. (mg/L)"),xlab=paste("Sulfate (mg/L)"))
abline(glm(Suplhate_model$fitted.values~Analyte_land_t[1:8,8]), col="blue",lwd=1,lty=2)

#Simplified model
Sulphate_model2=lm(Analyte_land_t[,8]~Land_t[,4]+Land_t[,2]+Land_t[,5])
summary(Sulphate_model2)$r.squared
plot(Analyte_land_t[1:8,8],Sulphate_model2$fitted.values,pch=20,ylab=paste("Predicted Conc. (mg/L)"),xlab=paste("Sulfate (mg/L)"))
abline(glm(Sulphate_model2$fitted.values~Analyte_land_t[1:8,8]), col="blue",lwd=1,lty=2)

#### end ####
