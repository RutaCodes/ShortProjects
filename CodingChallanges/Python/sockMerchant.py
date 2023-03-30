#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar 29 22:35:26 2023

@author: rutabasijokaite
"""

# From HackerRank

'''
# PROBLEM

There is a large pile of socks that must be paired by color. Given an array of integers representing 
the color of each sock, determine how many pairs of socks with matching colors there are.

Example:
n = 7
ar = [1,2,1,2,1,3,2]

There is one pair of color 1 and one of color 2. There are three odd socks left, one of each color. 
The number of pairs is 2.

Function Description

sockMerchant has the following parameter(s):

- int n: the number of socks in the pile
- int ar[n]: the colors of each sock

Returns

- int: the number of pairs

Input Format

The first line contains an integer n, the number of socks represented in ar.
The second line contains n space-separated integers, ar[i], the colors of the socks in the pile.


'''

# SOLUTION

#!/bin/python3

import os

#
# Complete the 'sockMerchant' function below.
#
# The function is expected to return an INTEGER.
# The function accepts following parameters:
#  1. INTEGER n
#  2. INTEGER_ARRAY ar
#

def sockMerchant(n, ar):
    un_col = list(set(ar))
    un_col.sort()
    res = 0
    for i in un_col:
        res += ar.count(i) // 2
    return res
        

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    ar = list(map(int, input().rstrip().split()))

    result = sockMerchant(n, ar)

    fptr.write(str(result) + '\n')

    fptr.close()