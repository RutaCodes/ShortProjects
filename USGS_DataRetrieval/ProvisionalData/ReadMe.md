MAIN CODE - Sub_data.R

As USGS stream flow data is reported on the website in real time, data that can be found on the website can be one of two times: approved and preliminary. As stream flow data is reported on the website in real time (preliminary data), it takes some time for the agency to verify the observations (approved data). During the period where data has not been approved, it is possible that some values can be missing due to malfunctioning equipment or storm events. However, these missing values can be corrected if stream flow gage of interest records daily as well as 15 min data. In that case, average 15 min data could be used to substitute missing values. This method allows the user to calculate dau=ily streamflow estimates before USGS provides data corrections and releases approved data, in case preliminary data is necessary for user's research. 


released data goes through approval process 


The main code substitutes averaged 15 min data to replace missing daily values. As an example, daily and 15 min stream flow data from USGS01338000 ORISKANY CREEK NEAR ORISKANY NY is provided.

<img width="621" alt="Screen Shot 2022-09-11 at 10 35 13 PM" src="https://user-images.githubusercontent.com/111301407/189563942-7f9b69a7-f3d4-40bd-95c6-d9d6deb8dcaf.png">

This code can be easily modified to correct data from multiple sites by adding FOR loop. I had to implement this method to correct missing daily stream flow values from 20 sites. I split data into two separate folders - daily and 15min data. Then I uploaded all files from both folders simultaneously using a following command:

<img width="898" alt="Screen Shot 2022-09-11 at 10 59 55 PM" src="https://user-images.githubusercontent.com/111301407/189566079-674307f6-f3c8-4878-9426-6fdbc2aa2ee4.png">
