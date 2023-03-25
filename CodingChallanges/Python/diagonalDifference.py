#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Mar 25 18:59:06 2023

@author: rutabasijokaite
"""

# From HackerRank

# PROBLEM

#Given a square matrix, calculate the absolute difference between the sums of its diagonals.

#For example, the square matrix arr is shown below:
#1 2 3
#4 5 6
#9 8 9  

#The left-to-right diagonal 1+5+9=15. 
#The right to left diagonal 3+5+9=17. 
#Their absolute difference is |15-17|=2.

#Function description:

#Complete function in the editor below.
#diagonalDifference takes the following parameter:
#int arr[n][m]: an array of integers

#Return:
#int: the absolute diagonal difference

#Input Format:
#The first line contains a single integer, n, the number of rows and columns in the square matrix arr.
#Each of the next n lines describes a row, arr[i], and consists of n space-separated integers arr[i][j].


# SOLUTION

import os
def diagonalDifference(arr):
    Diag1 = []
    Diag2 = []
    for i in range(len(arr)):
        Diag1.append(arr[i][i])
        Diag2.append(arr[i][len(arr)-i-1])
    return abs(sum(Diag1) - sum(Diag2))


if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    arr = []

    for _ in range(n):
        arr.append(list(map(int, input().rstrip().split())))

    result = diagonalDifference(arr)

    fptr.write(str(result) + '\n')

    fptr.close()


#%%
# Also possible using numpy
import numpy as np
def diagonalDifference(arr):
    Sum1 = sum(arr.diagonal())
    Sum2 = sum(np.fliplr(arr).diagonal())
    return abs(Sum1 - Sum2)
