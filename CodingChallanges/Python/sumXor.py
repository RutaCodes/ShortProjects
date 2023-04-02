#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Apr  1 23:43:09 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

Given an integer n, find each x such that:
    
0 <= x <= n
n + x = n XOR x

About XOR: https://en.wikipedia.org/wiki/Bitwise_operation#XOR

'''
# SOLUTION

#!/bin/python3

import os

def sumXor(n):
    if n == 0:
        return 1
    return 2**(bin(n)[2:].count('0'))

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    result = sumXor(n)

    fptr.write(str(result) + '\n')

    fptr.close()



'''
# Times out with large n

def sumXor(n):
    cnt = 0
    for i in range(n+1):
        x = (len(bin(n))-len(bin(i)))*'0' + bin(i)[2:]
        n_bi = bin(n)[2:]
        xor_sum = ''
        for j in range(len(x)):
            if x[j] != n_bi[j]:
                xor_sum += '1'
            else:
                xor_sum += '0'
        if int(('0b' + xor_sum),2) == (n + i):
            cnt += 1
    return cnt
'''
