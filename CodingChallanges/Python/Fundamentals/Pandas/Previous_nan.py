#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu May 25 12:14:32 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

Given a dataframe with 3 columns:
    - client_id
    - ranking
    - value
    
Write a function to fill the NaN values in the value column with the previous non-NaN value 
from the same client_id ranked in ascending order. If there doesn’t exist a previous client_id 
then return the previous value.

'''

# SOLUTION

import pandas as pd
import numpy as np
import math
     
#Example dataframe
Data_t = pd.DataFrame(data = {'client_id': [1001,1001,1001,1002,1002,1002,1003,1003],
                              'ranking': [1,2,3,1,2,3,1,2],
                              'value': [1000,np.nan,1200,1500,1250,np.nan,1100,np.nan]})

#Finding Nan values and replacing them with the closest previous non-NaN value
for i in np.array(Data_t.loc[Data_t['value'].isnull()].index):
    for j in range(1,i+1):
        if math.isnan(Data_t['value'].loc[i-j]) == False:
            Data_t.loc[i,'value'] = Data_t['value'].loc[i-j]
            break

#Sorting dataframe by client ranking
Data_t = Data_t.sort_values(by=['ranking'])    
