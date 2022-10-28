#Ruta Basijokaite
#----------------
#This code explores different ways to calculate and visualize correlation results
#----------------

###UPLOADING SAMPLE DATA

#Uploading sample dataset - land cover percentages at different watersheds 
LC_Sample_w_names = read.csv(file="Sample_land_cover_data.csv",sep=",",header=T) 
LC_Sample = LC_Sample_w_names[,-c(1,2)]

#----------------------------------
##### NUMERICAL
#----------------------------------
#Using 'cor' function - for getting simple matrix of correlation coefficients

#Choosing correlation method
corr_method = "pearson" # can also be "spearman", "kendall"
#Computing correlation matrix
corr_cor = cor(LC_Sample, method=corr_method)

#------
#Using 'rcorr' function - for getting p-values of correlation coefficients 

corr_rcorr_list = rcorr(as.matrix(LC_Sample),type=corr_method)
corr_rcorr = corr_rcorr_list$r #pulling correlation coefficient values 

#----------------------------------
#### DISPLAY CORRELATION MATRIX
#----------------------------------

#install.packages("PerformanceAnalytics")
library("PerformanceAnalytics")

#The function 'chart.Correlation()' can be used to display a chart of correlation matrix
chart.Correlation(LC_Sample, histogram=TRUE, pch=19)

#------

library(GGally)
#The 'ggpairs()' function allows to build scatterplot matrix. Scatterplots of each pair of numeric variables are drawn on the 
#left part of the figure. Pearson correlation is displayed on the right. Variable distribution is available on the diagonal. 
ggpairs(data.frame(corr_cor)) 

#----------------------------------
####VISUALIZING CORRELATION RESULTS WITH DIVERGING COLOR SCHEMES
#----------------------------------

#Using heatmap to visualize correlations

#Setting color scheme - visualizing results with classic blue-white-red color palette that is used for correlation results
col = colorRampPalette(c("blue","white","red"))(20)
heatmap(x=corr_cor, col=col, symm=TRUE)
#where blue is positive correlation, red - negative

#------
#The function 'corrplot()' in the package of the same name, creates a graphical display of a correlation matrix,
#highlighting the most correlated variables in a dataset. Correlation coefficients are colored according to the value. 
library("corrplot")

corrplot(corr_cor, method="color", tl.cex=0.85, tl.col = "black",cl.ratio = 0.2,cl.cex = 0.7)
#This can be easily customized. Read more about how to customize this plot here:
#http://www.sthda.com/english/wiki/visualize-correlation-matrix-using-correlogram

#------
library(ggplot2)
library(ggcorrplot)

#Computing correlation matrix with p-values
corrp.mat = cor_pmat(LC_Sample)

#Visualizing correlation matrix using hierarchical clustering
ggcorrplot(corr_cor, hc.order=TRUE, outline.color="white", ggtheme = theme_bw(), tl.cex=8)
#Note that default color palette used by 'ggcorrplot()' is slightly different than the one used with 'corrplot()'
