#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Apr 26 22:47:36 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

There is a large pile of socks that must be paired by color. Given an array of 
integers representing the color of each sock, determine how many pairs of socks 
with matching colors there are.

Example:
n = 7
ar = [1,2,1,2,1,3,2]

There is one pair of color 1 and one of color 2. There are three odd socks left, 
one of each color. The number of pairs is 2.

'''

# SOLUTION

import os

def sockMerchant(n, ar):
    pairs = 0
    colors = list(set(ar))
    for i in colors:
        pairs += (ar.count(i)/2)//1
    return int(pairs)


if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    ar = list(map(int, input().rstrip().split()))

    result = sockMerchant(n, ar)

    fptr.write(str(result) + '\n')

    fptr.close()
