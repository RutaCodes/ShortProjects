MAIN CODE - *Sub_data.R*

Streamflow data that can be found on USGS website can be 'approved' or 'preliminary'. As stream flow data is reported on the website in real time (preliminary data), it takes some time for the agency to verify the observations (approved data). Before data gets approved, some daily values can be missing due to malfunctioning equipment, storm events etc. These missing values can be estimated to do preliminary analysis if daily as well as 15 min data is recorded. In that case, averaged 15 min values could be used to substitute missing daily values. This method allows the user to calculate daily streamflow estimates before USGS provides data corrections and releases approved data. 

As an example, approved and provisional stream flow data from USGS01338000 ORISKANY CREEK NEAR ORISKANY NY is provided.

<img width="621" alt="Screen Shot 2022-09-11 at 10 35 13 PM" src="https://user-images.githubusercontent.com/111301407/189563942-7f9b69a7-f3d4-40bd-95c6-d9d6deb8dcaf.png">

*Sub_data.R* code substitutes averaged 15 min values to replace missing daily values. This code can be easily modified to correct data from multiple sites by adding FOR loop. I had to implement this method to estimate missing daily stream flow values for 20 sites. To do this, I split data into two separate folders - daily and 15min data. Then I uploaded all files from both folders simultaneously using the following command:

<img width="898" alt="Screen Shot 2022-09-11 at 10 59 55 PM" src="https://user-images.githubusercontent.com/111301407/189566079-674307f6-f3c8-4878-9426-6fdbc2aa2ee4.png">
