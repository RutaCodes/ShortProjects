MAIN CODE - Comparing_BflowSep.R

# Baseflow Separation Function

Baseflow separation is a method that is used to analyze streamflow and approximate runoff and baseflow. EcoHydRology package (Fuka et al., 2018) has BaseflowSeparation.R function that allows to approximate these components of streamflow. This function reads a streamflow dataset and produces a baseflow dataset. It can be run using 1, 2 or 3 passes. In this case, 3 passes were used. Filter parameter value recommended by Nathan and McMahon (1990) of 0.925 was used. 

One problem with this function is that it does not deal with missing values in the dataset and does not have the capability to deal with NA values. Two methods were tested:
1) METHOD 1 - Removing NA values from the dataset alltogether and feeding that string without NAs into the BaseflowSeparation function
2) METHOD 2 - Splitting dataset into groups of consecutive values, then feeding only those values into BaseflowSeparation function. In that way Baseflow separation will be performed on each group of values separately.

You can find the code to do this comparison in Comparing_BflowSep.R. 

# Results

![Screen Shot 2022-09-14 at 3 25 21 PM](https://user-images.githubusercontent.com/111301407/190244534-b3374f8a-1c7e-4b26-9645-79e2de63c1ca.png)
![Screen Shot 2022-09-14 at 3 46 15 PM](https://user-images.githubusercontent.com/111301407/190248390-ec56ae21-936b-4916-91d7-8711319584e4.png)
![Screen Shot 2022-09-14 at 3 46 52 PM](https://user-images.githubusercontent.com/111301407/190248426-9289a49c-b706-4ca4-a22c-5142a6396c30.png)

# Conclusion
Both methods seem to be useful. Ignoring NA values (method) is more accurate when very few values are missing in the dataset. However, when dataset is missing a large chunk of data, doing baseflow saparation by groups of consecutive values seem to produce more realistic results. 

Read more about EcoHydRology package here:
https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.463.7823&rep=rep1&type=pdf
Read more about Baseflow Separation here:
https://rdrr.io/cran/EcoHydRology/man/BaseflowSeparation.html

References:
Fuka, D. T., Walter, M. T., Archibald, J. A., Steenhuis, T. S., Easton, Z. M. (2018). A Community Modeling Foundation for Eco-Hydrology. R package version 0.4.12
Nathan, R. J. and T. A. McMahon (1990). "Evaluation of automated techniques for base flow and recession analysis." Water Resources Research 26(7): 1465-1473.
