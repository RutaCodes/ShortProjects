#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Dec  4 22:47:08 2022

@author: rutabasijokaite
"""

# PROBLEM:
#Digital root is the recursive sum of all the digits in a number.
#Given n, take the sum of the digits of n. If that value has more than one digit, 
#continue reducing in this way until a single-digit number is produced. The input 
#will be a non-negative integer.

#Examples
#    16  -->  1 + 6 = 7
#   942  -->  9 + 4 + 2 = 15  -->  1 + 5 = 6
#132189  -->  1 + 3 + 2 + 1 + 8 + 9 = 24  -->  2 + 4 = 6
#493193  -->  4 + 9 + 3 + 1 + 9 + 3 = 29  -->  2 + 9 = 11  --> 1 + 1 = 2


# SOLUTION:
def digital_root(n):
    while (len(str(n))>1):
        nr_sum = 0
        for digit in str(n):
            nr_sum += int(digit) 
        n = nr_sum
    return(n)
