# Sample code to explore shapes of probability distributions

# This code plots the pdf for the N, LN2, LN3 distributions

# Variables: 
# p = array of probabilities from .001 to .999
# q = quantile from the normal distribution
# ux = mean in real space
# sdx = stdev in real space
# qn = quantile from normal distribution
# dn = pdf of normal distribution
# uy = mean of logs
# sdy = standard deviation of logs
# qln = quantile from lognormal distribution
# dln = pdf of lognormal distribution
# a = P3 shape parameter
# s = P3 scale parameter
# l = P3 location parameter
# qP3 = quantile from P3 distribution
# dP3 = pdf of P3 distribution
# qLP3 = quantile from LP3 distribution
# dLP3 = pdf of LP3 distribution


# Set array of probabilities

p<-seq(.001,.999,.001)

# Normal distribution (parameters, quantiles and pdf, and plot)

ux<-0 #if not 0, it will shift
sdx<-1

qn<-qnorm(p,ux,sdx)
dn<-dnorm(qn,ux,sdx)

plot(qn,dn,type="l",xlim=c(-5,5),xlab="X",ylab="f(x)",main="Normal")

# 2-parameter Lognormal (parameters, quantiles and pdf, and plot)

uy<-1 #positively skewed distribution
sdy<-1

qln2<-qlnorm(p,uy,sdy)
dln2<-dlnorm(qln2,uy,sdy)

plot(qln2,dln2,type="l",xlim=c(0,15),xlab="X",ylab="f(x)",main = "2-parameter Lognormal")

# 3-parameter lognormal (parameters, quantiles and pdf, and plot)

LB = 2 #it shifts the distribution
uy<-1
sdy<-1

qln3<-qlnorm(p,uy,sdy)
dln3<-dlnorm(qln3,uy,sdy)

plot((qln3+LB),dln3,type="l",xlim=c(0,15),xlab="X",ylab="f(x)",main = "3-parameter Lognormal")

