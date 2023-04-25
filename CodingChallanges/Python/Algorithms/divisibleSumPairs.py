#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr 24 22:30:46 2023

@author: rutabasijokaite
"""

'''
# PROBLEM 

Given an array of integers and a positive integer k, determine the number of (i,j) pairs where i < j and  ar[i] + ar[j] is divisible by k.

Example: ar = [1,2,3,4,5,6]
k = 5
Three pairs meet the criteria: [1,4], [2,3], and [4,6]
    
'''

# SOLUTION

#!/bin/python3

import os

def divisibleSumPairs(n, k, ar):
    nr = 0
    for i in range(n-1):
        for j in range(i+1,n):
            if (ar[i] + ar[j])%k == 0:
                nr += 1
    return nr

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    first_multiple_input = input().rstrip().split()

    n = int(first_multiple_input[0])

    k = int(first_multiple_input[1])

    ar = list(map(int, input().rstrip().split()))

    result = divisibleSumPairs(n, k, ar)

    fptr.write(str(result) + '\n')

    fptr.close()
