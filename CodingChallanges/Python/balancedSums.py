#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Apr  1 20:24:37 2023

@author: rutabasijokaite
"""
# From HackerRank

'''
# PROBLEM

Watson gives Sherlock an array of integers. His challenge is to find an element of the array such 
that the sum of all elements to the left is equal to the sum of all elements to the right.

Example: arr = [5,6,8,11]

8 is between two subarrays that sum to 11.

arr = [1]

The answer is [1] since left ans right sum to 0.

You will be given arrays of integers and must determine whether there is an element that meets the 
criterion. If there is, return YES. Otherwise, return NO.

Function Description

balancedSums has the following parameter(s):
- int arr[n]: an array of integers

Returns

- string: either YES or NO

Input Format

The first line contains T, the number of test cases.

The next T pairs of lines each represent a test case.
- The first line contains n, the number of elements in the array arr.
- The second line contains n space-separated integers arr[i] where 0 <= i < n.

'''
# SOLUTION 

import os

def balancedSums(arr):
    total = sum(arr)
    left = 0
    for nr in arr:
        if left == total - nr - left:
            return 'YES'
        left += nr
    return 'NO'


if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    T = int(input().strip())

    for T_itr in range(T):
        n = int(input().strip())

        arr = list(map(int, input().rstrip().split()))

        result = balancedSums(arr)

        fptr.write(result + '\n')

    fptr.close()


'''
Times out with large arrays:
    
def balancedSums(arr):
    for i in range(len(arr)):
        if (sum(arr[:i]) == sum(arr[(i+1):])):
            return 'YES'
            break
    return 'NO'

'''
