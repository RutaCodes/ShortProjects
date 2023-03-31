#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Mar 30 21:43:12 2023

@author: rutabasijokaite
"""
# From HackerRank
'''
# PROBLEM

You will be given a list of integers, arr, and a single integer k. You must create an array of length k 
from elements of arr such that its unfairness is minimized. Call that array arr'. Unfairness of an array 
is calculated as:
    max(arr') - min(arr')

Where:
- max denotes the largest integer in arr'
- min denotes the smallest integer in arr'

Example
arr = [1,4,7,2]
k = 2

Pick any two elements, say arr' = [4,7]
unfairmess = max(4,7) - min(4,7) = 7 - 4 = 3

Testing for all pairs, the solution [1,2] provides the minimum unfairness.

Note: Integers in arr may not be unique.

Function Description

maxMin has the following parameter(s):
- int k: the number of elements to select
- int arr[n]:: an array of integers

Returns
- int: the minimum possible unfairness

Input Format

The first line contains an integer n, the number of elements in array arr.
The second line contains an integer k.
Each of the next n lines contains an integer arr[i] where 0 <= i < n.

'''
# SOLUTION

#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'maxMin' function below.
#
# The function is expected to return an INTEGER.
# The function accepts following parameters:
#  1. INTEGER k
#  2. INTEGER_ARRAY arr
#


def maxMin(k, arr):
    arr.sort()
    diff = arr[-1]
    for i in range(len(arr)-k+1):
        if (arr[i+k-1] - arr[i]) < diff:
            diff = arr[i+k-1] - arr[i]
            vals = arr[i:(i+k)]
    return max(vals) - min(vals)    
    

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    k = int(input().strip())

    arr = []

    for _ in range(n):
        arr_item = int(input().strip())
        arr.append(arr_item)

    result = maxMin(k, arr)

    fptr.write(str(result) + '\n')

    fptr.close()

'''            
# Times out

def maxMin(k, arr):
    arr.sort()
    for i in range(len(arr)-k+1):
        if i == 0:
            #diff = max(arr[i:(i+k)]) - min(arr[i:(i+k)])
            diff = arr[i+k] - arr[i]
            vals = arr[i:(i+k)]
        else:
            #if (max(arr[i:(i+k)]) - min(arr[i:(i+k)]) < diff ):
            if (arr[i+k] - arr[i]) < diff
                #diff = max(arr[i:(i+k)]) - min(arr[i:(i+k)])
                diff = arr[i+k] - arr[i]
                vals = arr[i:(i+k)]
    return max(vals) - min(vals)
'''  

'''
arr = [1,4,7,2]
k = 2
res = []
for i in range(k):
    res.append(arr.pop(arr.index(min(arr)))) #won't work if there is a min combination in the middle [1,4,5,9]

arr.sort()
for i in range(len(arr)-k+1):
    if i == 0:
        diff = max(arr[i:(i+k)]) - min(arr[i:(i+k)])
        vals = arr[i:(i+k)]
    else:
        if (max(arr[i:(i+k)]) - min(arr[i:(i+k)]) < diff ):
            diff = max(arr[i:(i+k)]) - min(arr[i:(i+k)])
            vals = arr[i:(i+k)]
    

diff = []
for i in range(1,len(arr)):
    diff.append(arr[i]-arr[i-1])
    
for i in range(len(diff)-k+1):
    if i == 0:
        vl = diff[i:(i+k-1)]
    else:
        vl = min(vl, diff[i:(i+k-1)])
   