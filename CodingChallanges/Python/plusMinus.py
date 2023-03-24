#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 24 13:48:54 2023

@author: rutabasijokaite
"""

# From HackerRank

# PROBLEM

#Given an array of integers, calculate the ratios of its elements that are positive, negative, and zero. Print the 
#decimal value of each fraction on a new line with  places after the decimal.

#Note: This challenge introduces precision problems. The test cases are scaled to six decimal places, 
#though answers with absolute error of up to  are acceptable.

#Example:

#There are  elements, two positive, two negative and one zero. Their ratios are ,  and . Results are printed as:
#0.400000
#0.400000
#0.200000

#Function Description:

#Complete the plusMinus function in the editor below.

#plusMinus has the following parameter(s):

#int arr[n]: an array of integers

#Print the ratios of positive, negative and zero values in the array. Each value should be printed on a separate 
#line with  digits after the decimal. The function should not return a value.

#Input Format:

#The first line contains an integer, , the size of the array.
#The second line contains  space-separated integers that describe.

#Output Format

#Print the following  lines, each to  decimals:
#proportion of positive values
#proportion of negative values
#proportion of zeros


# SOLUTION

def plusMinus(arr):
    return print('%.6f' % (sum(1 for i in range(len(arr)) if arr[i]> 0 ) / len(arr))), print('%.6f' % (sum(1 for i in range(len(arr)) if arr[i]< 0 ) / len(arr))), print('%.6f' % (sum(1 for i in range(len(arr)) if arr[i]== 0 ) / len(arr)))

if __name__ == '__main__':
    n = int(input().strip())

    arr = list(map(int, input().rstrip().split()))

    plusMinus(arr)
