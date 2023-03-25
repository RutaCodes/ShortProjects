#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Mar 25 16:29:12 2023

@author: rutabasijokaite
"""

# From HackerRank

# PROBLEM

#Given an array of integers, where all elements but one occur twice, find the unique element.

#Example:
#a = [1,2,3,4,3,2,1]
    
#The unique element is 4.

#Function Description:

#Complete the lonelyinteger function in the editor below.

#lonelyinteger has the following parameter(s):
#int a[n]: an array of integers

#Returns:
#int: the element that occurs only once

#Input Format:

#The first line contains a single integer, n, the number of integers in the array.
#The second line contains  space-separated integers that describe the values in a.


# SOLUTION

import numpy as np
def lonelyinteger(a):
    count = np.array(np.unique(np.array(a), return_counts=True))
    return print(count[0,np.where(count[1,:]==min(count[1,:]))[0]])


import os

def lonelyinteger(a):
    unique = list(set(a))
    for i in range(len(unique)):
        if a.count(unique[i]) == 1:
            return unique[i]
            break

        
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    a = list(map(int, input().rstrip().split()))

    result = lonelyinteger(a)

    fptr.write(str(result) + '\n')

    fptr.close()
