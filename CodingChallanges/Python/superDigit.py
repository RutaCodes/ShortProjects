#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Apr  1 22:28:26 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

We define super digit of an integer x using the following rules:

Given an integer, we need to find the super digit of the integer.

If x has only 1 digit, then its super digit is x.
Otherwise, the super digit of x is equal to the super digit of the sum of the digits of x.

Example:
n = '9875'
k = 4

The number p is created by concatenating the string  x k times so the initial
p = 9875987598759875

Find superdigit of p.

'''
# SOLUTION

import os 
 
def superDigit(n, k):
    n = sum([int(n[j]) for j in range(len(n))])
    n *= k
    if n < 10:
        return n
    else:
        return superDigit(str(n), 1)


if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    first_multiple_input = input().rstrip().split()

    n = first_multiple_input[0]

    k = int(first_multiple_input[1])

    result = superDigit(n, k)

    fptr.write(str(result) + '\n')

    fptr.close()

