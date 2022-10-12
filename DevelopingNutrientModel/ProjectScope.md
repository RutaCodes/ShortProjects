# Research Interest

Increased nutrient concentrations in surface water are often associated with decreased water quality. The goal of this project was to analyze how water quality differs across sites in California and Neveda and how land cover impacts observed nutrient concentrations. Relationship between land cover and observed nutrient (i.e. phosphorus, potassium, ammonia, fluoride, chloride, nitrate, sulphate) concentrations was studied and multiple linear regression model was developed to predict those concentrations.

# Sources of Nutrients

Nutrients can enter the system from various artificial and natural sources. Aftificial sources are often associated with agriculture, urbanization and other human related activities. 

![Screen Shot 2022-08-22 at 1 03 40 PM](https://user-images.githubusercontent.com/111301407/185978243-b4efa836-019b-4383-9aa3-dbf21b4cae28.png)

Some examples of natural and artificial nutrient sources by analyte:

![Screen Shot 2022-08-22 at 12 51 10 PM](https://user-images.githubusercontent.com/111301407/185976533-8090d8f1-8e9d-4f4e-a579-6d3ad7911eeb.png)

It is important to consider both sources to fully understand nutrient dynamics in study watersheds.

# Study Sites

Water samples were taken in multiple locations across California and Nevada. 

![Screen Shot 2022-08-22 at 1 25 27 PM](https://user-images.githubusercontent.com/111301407/185982274-f7fa8081-645c-4b20-a5a9-1b2449a144f5.png)

All selected study locations had varying levels of urban and agricultural activity, which was perfect for studying relationship between land cover and detected nutrient concentrations. 

# Results

Ion Chromatography (IC) was used to process samples and measure nutrient concentrations. IC results showed a wide range of concentrations:

![Screen Shot 2022-08-22 at 3 24 14 PM](https://user-images.githubusercontent.com/111301407/186002836-fdf9b45c-4dd6-4357-ac72-1db5ad5bf611.png)

Results highlights how urbanization impacts water quality: chloride and sulphate concetrations increased 20 times after Truckee river passed through Reno!

# Correlations 

First, correlation analysis was performed to determine similarities among nutrient occurance. Spearman correlation coefficeint was calculated to quantify co-occurance patterns among compounds:

![Screen Shot 2022-08-22 at 3 33 22 PM](https://user-images.githubusercontent.com/111301407/186003734-5953d90a-b079-4e07-bb63-a8a8d98f2974.png)

Similarly, land cover similarities among sites were analyzed:

![Screen Shot 2022-08-22 at 3 36 05 PM](https://user-images.githubusercontent.com/111301407/186004200-e283f6e9-96c5-4f04-ab89-d06f08d865c3.png)

These correlations analysis results allow to easily identify similar land use watersheds, which can be used to help predict nutrient concentrations. It would be expected that sites that are primarily forested with minimal urbanization would have lower nutrient concentration, while watersheds with high cultivated crop and urban cover would have higher nutrient concentrations.

Finally, correlation between land use and different nutrients was analyzed:

![Screen Shot 2022-08-23 at 3 50 42 PM](https://user-images.githubusercontent.com/111301407/186253122-1a62973a-a466-4261-8670-aade09aea1e8.png)

Results show that most of the studied compounds have relatively strong negative correlation with forested landcover (no agricultural or urban activity). On the other hand, ammonia, chloride, nitrate, and sulphate are strongly positively correlated with urban (i.e. developed) and agricultural (i.e. cultivated crops, hay/pasture, etc.) land covers. This signifies that these four compounds are likely entering the surface water from artificial sources, hence we see an increase in their concentrations when large portion of the watershed is affected by human activity. 

# Modeling

Ordinary Least Square Modeling was used to develop predictive nutrient concentration model. Results from correlation analysis were used to inform which land cover types should be used as explanatory variables in the model. Model was developed for each nutrient separately, as land cover influence on observed concentrations will vary from compound to compound. In total, 4 predictive OLS models were created: nitrate, chloride, ammonia, and sulphate. 

NITRATE MODEL

First, relationships between recorded nitrate concentrations and individual land covers were explored:

![Screen Shot 2022-08-25 at 11 51 32 AM](https://user-images.githubusercontent.com/111301407/186712023-1e5c9ebd-6fd8-4469-bbcd-cd4e32250754.png)
![Screen Shot 2022-08-25 at 11 51 49 AM](https://user-images.githubusercontent.com/111301407/186712051-22887c82-d412-4e77-9204-5a3d1ab56074.png)

Although relationship trends are clear, it is not enough to use a single land cover type as predictor variables as that linear regression model would not be very accurate. Instead, using multiple land cover types as predictor variables in the model better represents overall land cover impact on observed nitrate concentrations:

![Screen Shot 2022-08-25 at 12 03 42 PM](https://user-images.githubusercontent.com/111301407/186714578-5e5ae523-e86b-4635-916a-356538e96dbe.png)

This multiple linear regression model uses 6 land cover types as predictor variables producing R2 = 0.96.

Similarly, ammonia model produced high accuracy of R2 = 0.95, while sulphate model had R2 = 0.99. 

# Code

Code for correlation analysis and modeling that was mentioned here can be found in OLS_modeling_fieldC.R.
