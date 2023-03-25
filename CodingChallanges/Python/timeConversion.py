#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 24 20:34:20 2023

@author: rutabasijokaite
"""

# From HackerRank

# PROBLEM

#Given a time in 12-hour AM/PM format, convert it to military (24-hour) time.

#Note: - 12:00:00AM on a 12-hour clock is 00:00:00 on a 24-hour clock.
#- 12:00:00PM on a 12-hour clock is 12:00:00 on a 24-hour clock.

#Example: 
#s='12:01:00PM'
#Return '12:01:00'.

#s='12:01:00AM'
#Return '00:01:00'.

#Function Description:

#Complete the timeConversion function in the editor below. It should return a new string representing 
#the input time in 24 hour format.

#timeConversion has the following parameter(s):

#string s: a time in 12 hour format

#Returns:

#string: the time in  24 hour format

#Input Format:

#A single string s that represents a time in 12-hour clock format (i.e.: hh:mm:ssAM or hh:mm:ssPM).


# SOLUTION
import os 

def timeConversion(s):
    if (s[-2:] == 'PM') & (int(s[:2]) != 12):
        return str(int(s[:2]) + 12) + s[2:8]
    elif (s[-2:] == 'AM') & (int(s[:2]) == 12):
        return '00' + s[2:8]
    else:
        return s[:-2]


if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    s = input()

    result = timeConversion(s)

    fptr.write(result + '\n')

    fptr.close()
