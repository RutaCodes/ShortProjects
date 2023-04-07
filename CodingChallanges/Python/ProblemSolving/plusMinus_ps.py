#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Apr  6 23:02:29 2023

@author: rutabasijokaite
"""

#Given an array of integers, calculate the ratios of its elements that are positive, negative, and zero. 
#Print the decimal value of each fraction on a new line with 6 places after the decimal.

#Example: arr = [1,1,0,-1,-1]
#There are n = 5, two positive, two negative, one zero. Their ratios are 2/5, 2/5, 1/5

def plusMinus(arr):
    pos, neg, zer = 0, 0, 0
    for i in arr:
        if i > 0:
            pos += 1
        elif i < 0:
            neg += 1
        else:
            zer += 1
    print("%.6f" % (pos/len(arr))), print("%.6f" % (neg/len(arr))), print("%.6f" % (zer/len(arr)))