# Baseflow Separation Function

Baseflow separation is a method that is used to analyze streamflow and approximate runoff and baseflow components. EcoHydRology package that was created by Fuka et al., 2019 has BaseflowSeparation.R function that allows to approximate runoff and baseflow components of streamflow. However, this function does not account for missing values in the dataset and does not have the capability to deal with NA values. Two methods were tested:
1) Removing NA values from the dataset alltogether and feed that array without NAs into the BaseflowSeparation function
2) Grouping consecutive values and feeding only an array with those consecutive values into the BaseflowSeparation function

You can find the code to do this comparison in Comparing_BflowSep.R. 

# Results

# Conclusion

Read more about EcoHydRology package here:
https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.463.7823&rep=rep1&type=pdf

References:
