#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 24 20:07:20 2023

@author: rutabasijokaite
"""

# From HackerRank

# PROBLEM 

#Given five positive integers, find the minimum and maximum values that can be calculated by summing exactly 
#four of the five integers. Then print the respective minimum and maximum values as a single line of two 
#space-separated long integers.

#Example:
#arr = [1,3,5,7,9]

#The minimum sum is 1+3+5+7 = 16 and the maximum sum is 3+5+7+9 = 24. The function prints
#16 24

#Function Description:

#Complete the miniMaxSum function in the editor below.

#miniMaxSum has the following parameter(s):

#arr: an array of  integers

#Print two space-separated integers on one line: the minimum sum and the maximum sum of 4 of 5 elements.

#Input Format

#A single line of five space-separated integers.

#Output Format

#Print two space-separated long integers denoting the respective minimum and maximum values that can be 
#calculated by summing exactly four of the five integers. (The output can be greater than a 32 bit integer.)


# SOLUTION

import math
import os
import random
import re
import sys
#import numpy as np

#
# Complete the 'miniMaxSum' function below.
#
# The function accepts INTEGER_ARRAY arr as parameter.
#
#min_s = 0
#max_s = 0
def miniMaxSum(arr):
    # Write your code here
    #sum_arr = sum(arr)
    print(sum(arr) - max(arr), sum(arr) - min(arr))
    
    #min_v_ind = arr.index(min(arr))
    #max_v_ind = arr.index(max(arr))
    #sum_max = np.array(sum(arr[:min_v_ind] + arr[min_v_ind+1:]),dtype=int)
    #sum_min = np.uint64(sum(arr[:max_v_ind] + arr[max_v_ind+1:]))
    
    #max_sum = sum(arr.remove(arr[arr.index(min(arr))]))
    #min_sum = sum(arr.remove(arr[arr.index(max(arr))]))
    #min_s = max_s = 0
    #for i in range(1,len(arr)):
    #    sum_n = sum(arr[:i] + arr[i+1:])
    #    if min_s > sum_n: 
    #        min_s = sum_n
    #    if max_s < sum_n:
    #        max_s = sum_n
    #return sum_max

if __name__ == '__main__':

    arr = list(map(int, input().rstrip().split()))

    miniMaxSum(arr)
