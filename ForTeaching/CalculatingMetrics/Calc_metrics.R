# Example code

# Read in data for Devil's Lake and calculate the Bias and Nash Sutcliffe Efficiency (NSE)

# Variables:
# Devil = data from of input data
# mod_ch_vol = modeled change in reservoir volume
# mea_ch_vol = measured change in reservoir volume
# sum1 = summation used to calculate bias
# bias1 = bias calculated using loop
# bias2 = bias calculated using sum command
# bias3 = bias calculated using mean command
# sum2 = summation used to calculate numerator in NSE
# sum3 = summation used to calculate denominator in NSE
# NSE1 = NSE calculated using loop
# NSE2 = NSE calculated using sum commands


# Read in data file

Devil<-read.csv(file="Devils_Lake.csv")

# Define 2 variables of interest: mod_ch_vol and mea_ch_vol

mod_ch_vol<-Devil$Change_Volume
mea_ch_vol<-Devil$Meas_Change_Volume

#--------------------
#### Calculate bias

# Using loop

sum1<-0
n<-length(mea_ch_vol)
for (i in seq(1,n)){
  sum1<-sum1+(mod_ch_vol[i]-mea_ch_vol[i])
}

bias1<-round(sum1/n,2)

# In one command

bias2<-round(sum(mod_ch_vol-mea_ch_vol)/n,2)

# Or

bias3<-round(mean(mod_ch_vol-mea_ch_vol),2)

#--------------------
#### Calculate NSE

sum2<-0
sum3<-0
for (i in seq(1,n)){
  sum2<-sum2+((mod_ch_vol[i]-mea_ch_vol[i])^2)
  sum3<-sum3+((mea_ch_vol[i]-mean(mea_ch_vol))^2)
}
NSE1<-round(1-(sum2/sum3),3)

# In one command

NSE2<-round(1-(sum((mod_ch_vol-mea_ch_vol)^2)/sum((mea_ch_vol-mean(mea_ch_vol))^2)),3)

# Write output to file

write("Your Name","Name.out")
write("NSE for Modeled Devils Lake Change in Storage","Name.out",append=T)
write("Date","Name.out",append=T)
write("  ","Name.out",append=T)
write(paste("NSE = ",NSE1),"Name.out",append=T)

  