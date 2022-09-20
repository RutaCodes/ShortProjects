# Regression Analyses
#-------------------
# Program Description:
# This program reads in tree data for the Allegheny National Forest and fits regression models for tree volume as a 
# function of tree dbh, height, and a random number.

#This code explores different ways to build linear regression models as well as analyses different 
#statistics and model metrics that help with model development.
#-------------------

# Read in input file and attach
data1=read.csv("TreeData.csv")

#Plotting relationship between variables
plot(data1[,2],data1[,1],xlab="LBI",ylab="so2")

#Initial model
modeT1<-lm(data1[,2]~data1[,1])

#Model statistics
summary(modeT1)
betas=coef(modeT1)
res<-residuals(modeT1)
data1$so2[1]-betas[1]-betas[2]*data1$LBI[1]
so2_hat<-predict(modeT1)
data1$so2[1]-so2_hat[1]

#R squared and adjusted R2
R2<-summary(modeT1)$r.squared
Adj_R2<-summary(modeT1)$adj.r.squared
stdev_res<-summary(modeT1)$sigma
var_res<-stdev_res^2

# Initial plot of data
par(mfrow=c(1,1))
plot(data1)
par(mfrow=c(3,1))
plot(data1$Volume_ft.3~data1$Diameter_in)
plot(data1$Volume_ft.3~data1$Height_ft)
plot(data1$Volume_ft.3~data1$Lucky_Number)

# Calculate the correlations between the y and the potential x variables
cor(data1[,-3],data1$Volume_ft.3)

# Set up array to store adjusted R2
adj_r2_m1=array(0,10)

# Calculate the first linear model:  Volume on Diameter
m1 <- lm(data1$Volume_ft.3 ~ data1$Diameter_in)
summary(m1)
coef1=coef(m1)
pred1=predict(m1)
res1=residuals(m1)
dev1=deviance(m1)
sum(res1^2)
adj_r2_m1[1] <- summary(m1)$adj.r.squared

# Calculate the second linear model:  Volume on Height
m2 <- lm(data1$Volume_ft.3 ~ data1$Height_ft)
summary(m2)
adj_r2_m1[2] <- summary(m2)$adj.r.squared

# Calculate the third linear model:  Volume on Lucky Number
m3 <- lm(data1$Volume_ft.3 ~ data1$Lucky_Number)
summary(m3)
adj_r2_m1[3] <- summary(m3)$adj.r.squared

# Calculate the fourth model:  Volume on Diameter and Height
m4 <- lm(data1$Volume_ft.3 ~ data1$Diameter_in + data1$Height_ft)
summary(m4)
adj_r2_m1[4] <- summary(m4)$adj.r.squared

# Calculate the fifth model:  Volume on Diameter and Lucky Number
m5 <- lm(data1$Volume_ft.3 ~ data1$Diameter_in + data1$Lucky_Number)
summary(m5)
adj_r2_m1[5] <- summary(m5)$adj.r.squared

# Calculate the sixth model:  Volume on Height and Lucky Number
m6 <- lm(data1$Volume_ft.3 ~ data1$Height_ft + data1$Lucky_Number)
summary(m6)
adj_r2_m1[6] <- summary(m6)$adj.r.squared

# Calculate the seventh model:  Volume on Diameter, Height, and Lucky Number
m7 <- lm(data1$Volume_ft.3 ~ data1$Diameter_in + data1$Height_ft + data1$Lucky_Number)
summary(m7)
adj_r2_m1[7] <- summary(m7)$adj.r.squared

# Load "leaps"
library(leaps)

# Perform best subset regression
leaps(data1[,-3],data1$Volume_ft.3,method="adjr2",names=names(data1[,-3]))

# Perform stepwise regression using AIC
step(m1, scope = list( upper=m7, lower=~1),direction="both",trace=TRUE)

# Extract AIC
extractAIC(m1)

# Perform stepwise regression using an F test
library(MASS)

addterm(m1,scope = m7, test="F", sorted=TRUE)
addterm(m4,scope = m7, test="F", sorted=TRUE)
dropterm(m7,test="F", sorted=TRUE)

# Look at "best" model
summary(m4)
res4<-residuals(m4)
# pred -> Y hats
pred4<-predict(m4)

# Plot predicted values and residuals 
par(mfrow=c(2,2))
plot(pred4 ~ data1$Volume_ft.3)
abline(a=0,b=1)#puts straight line through your data  at 45 degrees
#if one point of data is an outlier - will have a lot of leverage on the model because 
#model is trying to reduce r2 and line getts pulled in the direction of the outlier 
plot(res4 ~ pred4)
#line throught the data - points next to line will have more pull
lines(lowess(pred4,res4)) #lowess - locally weighted 
#residuals vs explanatory variables
plot(res4 ~ data1$Diameter_in)
lines(lowess(data1$Diameter_in,res4))
plot(res4 ~ data1$Height_ft)
lines(lowess(data1$Height_ft,res4))

# Autocorrelation function of residuals
par(mfrow=c(1,1))
acf(res4) #acf -> autocorrelation function

# Calculate the test statistics for the PPCC test of normality of residuals
i<-rank(res4) #determine rank
pi<-(i-(3/8))/(length(res4)+(1/4)) #blom's plotting position
zpi<-qnorm(pi) 
r<-cor(res4,zpi) #test statistic is correlation between those two
r2<-cor(res4,qnorm((rank(res4)-(3/8))/(length(res4)+(1/4))))

#to run VIF you need car librarry
library(car)
vif(m4)

lnV=log(data1$Volume_ft.3)
lnQ=log(data1$Diameter_in)
lnH=log(data1$Height_ft)

m4_b=lm(lnV ~ lnQ+lnH)
summary(m4_b)

res4b=residuals(m4_b)
pred4b=predict(m4_b)

par(mfrow=c(2,2))
plot(pred4b ~ data1$Volume_ft.3)
abline(a=0,b=1)#puts straight line through your data at 45 degrees
#a = y interpt and b is slope
plot(res4b ~ pred4b)
lines(lowess(pred4b,res4b)) #lowess - locally weighted 
#residuals vs explanatory variables
plot(res4b ~ data1$Diameter_in)
lines(lowess(data1$Diameter_in,res4b))
plot(res4b ~ data1$Height_ft)
lines(lowess(data1$Height_ft,res4b))

r2b<-cor(res4b,qnorm((rank(res4b)-(3/8))/(length(res4b)+(1/4)))) 
#r2b and r2 will have a difference at 3rd sig. digit
