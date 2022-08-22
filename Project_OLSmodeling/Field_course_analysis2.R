#------------------------------------------
#This code performs correlation analysis to study relationship between different nutrients, study site
#land covers, and how land cover is related to observed nutrient concentrations.
#Then the most influential land cover types are used to develop OLS model to predict nutrient 
#cincentrations based on watershed land cover distribution
#-----------------------------------------

#Uploading measured concentrations
Analyte_conc_csv<-read.csv(file="Analyte_conc.csv",sep=",",header=T) 
Analyte2_conc_csv<-read.csv(file="Analyte_conc.csv",sep=",",row.names=1,header=T) 
#check how variable looks like
head(Analyte2_conc_csv)
Analyte_conc=Analyte_conc_csv[,2:14]
row.names(Analyte_conc)=Analyte_conc_csv[,1]
Hach_data=Analyte_conc[1:3,]
IC_data=Analyte_conc[4:8,1:10]

#Library for correlation analysis
library(corrplot)

Analyte_cor_spear=cor(Analyte_conc,use="complete.obs",method = c("spearman"))

library("Hmisc")
rcor_vals_spear=rcorr(as.matrix(Analyte_conc),type = c("spearman"))
corrplot(rcor_vals_spear$r,tl.col="black")
rcor_vals_spear_IC_site=rcorr(as.matrix(IC_data),type = c("spearman"))
corrplot(rcor_vals_spear_IC_site$r,tl.col="black")
corrplot(rcor_vals_spear_IC_site$r,tl.col="black",method="color")
View(rcor_vals_spear_IC_site$r)
rcor_vals_spear_no_salty_lakes=rcorr(as.matrix(Analyte_conc[,1:10]),type = c("spearman"))
corrplot(rcor_vals_spear_no_salty_lakes$r,tl.col="black")

#analyzing correlations separately
Hach_data_t=t(Hach_data)
IC_data_t=t(IC_data)
rcor_vals_spear_hach=rcorr(as.matrix(Hach_data_t),type = c("spearman"))
corrplot(rcor_vals_spear_hach$r,tl.col="black")
rcor_vals_spear_IC=rcorr(as.matrix(IC_data_t),type = c("spearman"))
corrplot(rcor_vals_spear_IC$r,tl.col="black")

Analyte_conc_t=t(Analyte_conc_csv[,2:14])
colnames(Analyte_conc_t)=Analyte_conc_csv[,1]
colnames(Analyte_conc_t)=c('Phospohorus (mg/L)','Ammonia (mg/L)','Potassium (mg/L)','Fluoride (mg/L)',
                           'Chloride (mg/L)','Nitrate (mg/L)','Phosphate (mg/L)','Sulphate (mg/L')
rcor_vals_spear_analytes=rcorr(as.matrix(Analyte_conc_t[]),type = c("spearman"))
corrplot(rcor_vals_spear_analytes$r,tl.col="black")
corrplot(rcor_vals_spear_analytes$r,tl.col="black",method="color")

Land_cover_csv<-read.csv(file="Land_cover_field_course1.csv",sep=",",header=T) 
Land_cover=Land_cover_csv[,2:12]
row.names(Land_cover)=Land_cover_csv[,1]
land_vals_spear=rcorr(as.matrix(Land_cover),type = c("spearman"))
corrplot(land_vals_spear$r,tl.col="black")
corrplot(land_vals_spear$r,tl.col="black",method="color")

Analyte_for_land_cover=Analyte_conc[,-9]
Analyte_for_land_cover=Analyte_for_land_cover[,-3]
Analyte_land_t=t(Analyte_for_land_cover)
colnames(Analyte_land_t)=c('Phospohorus (mg/L)','Ammonia (mg/L)','Potassium (mg/L)','Fluoride (mg/L)',
                           'Chloride (mg/L)','Nitrate (mg/L)','Phosphate (mg/L)','Sulphate (mg/L')
Land_t=t(Land_cover)
rcor_vals_spear_analyte_land=rcorr(as.matrix(cbind(Analyte_land_t,Land_t)),type = c("spearman"))
corrplot(rcor_vals_spear_analyte_land$r,tl.col="black")
cor_mat_clim_spear=cor(Analyte_land_t,Land_t,use="complete.obs",method = c("spearman"))
corrplot(cor_mat_clim_spear,tl.col="black")

cor_mat_land_spear=cor(Land_cover,use="complete.obs",method = c("spearman"))
corrplot(cor_mat_land_spear,tl.col="black")


###### Nitrate ######
plot(Land_t[,4],Analyte_land_t[,6],pch=20,xlab=paste("Forested Land Cover %"),ylab=paste("Nitrate (mg/L)"))
#add linear trend
#lines(predict(lm(Analyte_land_t[,6]~Land_t[,4])),col='green')
fit <- glm(Analyte_land_t[,6]~Land_t[,4])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,2],Analyte_land_t[,6],pch=20,xlab=paste("Developed Land Cover %"),ylab=paste("Nitrate (mg/L)"))
fit <- glm(Analyte_land_t[,6]~Land_t[,2])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,5],Analyte_land_t[,6],pch=20,xlab=paste("Shrub Land Cover %"),ylab=paste("Nitrate (mg/L)"))
fit <- glm(Analyte_land_t[,6]~Land_t[,5])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,6],Analyte_land_t[,6],pch=20,xlab=paste("Herbaceous Land Cover %"),ylab=paste("Nitrate (mg/L)"))
fit <- glm(Analyte_land_t[,6]~Land_t[,6])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,7],Analyte_land_t[,6],pch=20,xlab=paste("Hay/Pasture Land Cover %"),ylab=paste("Nitrate (mg/L)"))
fit <- glm(Analyte_land_t[,6]~Land_t[,7])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,8],Analyte_land_t[,6],pch=20,xlab=paste("Cultivated Crops Land Cover %"),ylab=paste("Nitrate (mg/L)"))
fit <- glm(Analyte_land_t[,6]~Land_t[,8])
abline(fit, col="blue",lwd=1,lty=2)

Nitrate_model=lm(Analyte_land_t[,6]~Land_t[,4]+Land_t[,2]+Land_t[,5]+Land_t[,6]+Land_t[,7]+Land_t[,8])
summary(Nitrate_model)
plot(Nitrate_model$fitted.values,Analyte_land_t[1:8,6],pch=20,xlab=paste("Predicted Values"),ylab=paste("Nitrate (mg/L)"))
plot(Analyte_land_t[1:8,6],Nitrate_model$fitted.values,pch=20,ylab=paste("Predicted Values"),xlab=paste("Nitrate (mg/L)"))
fitm <- glm(Nitrate_model$fitted.values~Analyte_land_t[1:8,6])
abline(fitm, col="blue",lwd=1,lty=2)
#legend(1,"R2=")

##### Chloride #####
plot(Land_t[,4],Analyte_land_t[,5],pch=20,xlab=paste("Forested Land Cover %"),ylab=paste("Chloride (mg/L)"))
fit <- glm(Analyte_land_t[,5]~Land_t[,4])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,2],Analyte_land_t[,5],pch=20,xlab=paste("Developed Land Cover %"),ylab=paste("Chloride (mg/L)"))
fit <- glm(Analyte_land_t[,5]~Land_t[,2])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,5],Analyte_land_t[,5],pch=20,xlab=paste("Shrub Land Cover %"),ylab=paste("Chloride (mg/L)"))
fit <- glm(Analyte_land_t[,5]~Land_t[,5])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,6],Analyte_land_t[,5],pch=20,xlab=paste("Herbaceous Land Cover %"),ylab=paste("Chloride (mg/L)"))
fit <- glm(Analyte_land_t[,5]~Land_t[,6])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,7],Analyte_land_t[,5],pch=20,xlab=paste("Hay/Pasture Land Cover %"),ylab=paste("Chloride (mg/L)"))
fit <- glm(Analyte_land_t[,5]~Land_t[,7])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,8],Analyte_land_t[,5],pch=20,xlab=paste("Cultivated Crops Land Cover %"),ylab=paste("Chloride (mg/L)"))
fit <- glm(Analyte_land_t[,5]~Land_t[,8])
abline(fit, col="blue",lwd=1,lty=2)

Chlor_model=lm(Analyte_land_t[,5]~Land_t[,4]+Land_t[,2]+Land_t[,5]+Land_t[,6]+Land_t[,7]+Land_t[,8])
summary(Chlor_model)
plot(Chlor_model$fitted.values,Analyte_land_t[1:8,5])
plot(Analyte_land_t[1:8,5],Chlor_model$fitted.values,pch=20,ylab=paste("Predicted Values"),xlab=paste("Chloride (mg/L)"))
fitm <- glm(Chlor_model$fitted.values~Analyte_land_t[1:8,5])
abline(fitm, col="blue",lwd=1,lty=2)

######Ammonia ####
plot(Land_t[,4],Analyte_land_t[,2],pch=20,xlab=paste("Forested Land Cover %"),ylab=paste("Ammonia (mg/L)"))
fit <- glm(Analyte_land_t[,2]~Land_t[,4])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,2],Analyte_land_t[,2],pch=20,xlab=paste("Developed Land Cover %"),ylab=paste("Ammonia (mg/L)"))
fit <- glm(Analyte_land_t[,2]~Land_t[,2])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,5],Analyte_land_t[,2],pch=20,xlab=paste("Shrub Land Cover %"),ylab=paste("Ammonia (mg/L)"))
fit <- glm(Analyte_land_t[,2]~Land_t[,5])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,6],Analyte_land_t[,2],pch=20,xlab=paste("Herbaceous Land Cover %"),ylab=paste("Ammonia (mg/L)"))
fit <- glm(Analyte_land_t[,2]~Land_t[,6])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,7],Analyte_land_t[,2],pch=20,xlab=paste("Hay/Pasture Land Cover %"),ylab=paste("Ammonia (mg/L)"))
fit <- glm(Analyte_land_t[,2]~Land_t[,7])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,8],Analyte_land_t[,2],pch=20,xlab=paste("Cultivated Crops Land Cover %"),ylab=paste("Ammonia (mg/L)"))
fit <- glm(Analyte_land_t[,2]~Land_t[,8])
abline(fit, col="blue",lwd=1,lty=2)

Ammonia_model=lm(Analyte_land_t[,2]~Land_t[,4]+Land_t[,2]+Land_t[,5]+Land_t[,6]+Land_t[,7]+Land_t[,8])
summary(Ammonia_model)
plot(Ammonia_model$fitted.values,Analyte_land_t[,2])
plot(Analyte_land_t[,2],Ammonia_model$fitted.values,pch=20,ylab=paste("Predicted Values"),xlab=paste("Ammonia (mg/L)"))
fitm <- glm(Ammonia_model$fitted.values~Analyte_land_t[,2])
abline(fitm, col="blue",lwd=1,lty=2)

Ammonia_model2=lm(Analyte_land_t[,2]~Land_t[,2]+Land_t[,6]+Land_t[,8])
summary(Ammonia_model2)
plot(Ammonia_model2$fitted.values,Analyte_land_t[,2])

#####Sulphate ####
plot(Land_t[,4],Analyte_land_t[,8],pch=20,xlab=paste("Forested Land Cover %"),ylab=paste("Sulfate (mg/L)"))
fit <- glm(Analyte_land_t[,8]~Land_t[,4])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,2],Analyte_land_t[,8],pch=20,xlab=paste("Developed Land Cover %"),ylab=paste("Sulfate (mg/L)"))
fit <- glm(Analyte_land_t[,8]~Land_t[,2])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,5],Analyte_land_t[,8],pch=20,xlab=paste("Shrub Land Cover %"),ylab=paste("Sulfate (mg/L)"))
fit <- glm(Analyte_land_t[,8]~Land_t[,5])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,6],Analyte_land_t[,8],pch=20,xlab=paste("Herbaceous Land Cover %"),ylab=paste("Sulphate (mg/L)"))
fit <- glm(Analyte_land_t[,8]~Land_t[,6])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,7],Analyte_land_t[,8],pch=20,xlab=paste("Hay/Pasture Land Cover %"),ylab=paste("Sulphate (mg/L)"))
fit <- glm(Analyte_land_t[,8]~Land_t[,7])
abline(fit, col="blue",lwd=1,lty=2)

plot(Land_t[,8],Analyte_land_t[,8],pch=20,xlab=paste("Cultivated Crops Land Cover %"),ylab=paste("Sulphate (mg/L)"))
fit <- glm(Analyte_land_t[,8]~Land_t[,8])
abline(fit, col="blue",lwd=1,lty=2)

Suplhate_model=lm(Analyte_land_t[,8]~Land_t[,4]+Land_t[,2]+Land_t[,5]+Land_t[,6]+Land_t[,7]+Land_t[,8])
summary(Suplhate_model)
plot(Suplhate_model$fitted.values,Analyte_land_t[1:8,8])
plot(Analyte_land_t[1:8,8],Suplhate_model$fitted.values,pch=20,ylab=paste("Predicted Values"),xlab=paste("Sulfate (mg/L)"))
fitm <- glm(Suplhate_model$fitted.values~Analyte_land_t[1:8,8])
abline(fitm, col="blue",lwd=1,lty=2)


Sulphate_model2=lm(Analyte_land_t[,8]~Land_t[,4]+Land_t[,2]+Land_t[,5])
summary(Sulphate_model2)
plot(Sulphate_model2$fitted.values,Analyte_land_t[1:8,8])


