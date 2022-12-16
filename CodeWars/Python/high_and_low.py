#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Dec  2 14:14:49 2022

@author: rutabasijokaite
"""

# PROBLEM:

#In this little assignment you are given a string of space separated numbers, and 
#have to return the highest and lowest number.

#Examples:
#high_and_low("1 2 3 4 5")  # return "5 1"
#high_and_low("1 2 -3 4 5") # return "5 -3"
#high_and_low("1 9 3 4 -5") # return "9 -5"

#Notes:
#All numbers are valid Int32, no need to validate them.
#There will always be at least one number in the input string.
#Output string must be two numbers separated by a single space, and highest number is first.
    
    
# SOLUTION:

def high_and_low(numbers):
    chunks = numbers.split(' ')
    for i in range(0,len(chunks)):
        chunks[i] = int(chunks[i])
    high_low = ' '.join([str(max(chunks)), str(min(chunks))])
    return high_low
