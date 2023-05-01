#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May  1 19:05:52 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

A person wants to determine the most expensive computer keyboard and USB drive that can be purchased 
with a give budget. Given price lists for keyboards and USB drives and a budget, find the cost to buy 
them. If it is not possible to buy both items, return -1.

Example: b = 60
         keyboards = [40,50,60]
         drives = [5,8,12]
         
The person can buy 40 keyboard + 12 drive, or 50 keyboard + 8 drive. Choose the latter as the more 
expensive option and return 58.

'''

# SOLUTION

#!/bin/python3

import os
import sys


def getMoneySpent(keyboards, drives, b):
    comb = []
    for i in keyboards:
        for j in drives:
            if i + j <= b:
                comb.append(i + j)
    if len(comb) > 0:
        return max(comb)
    else:
        return -1
  

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    bnm = input().split()

    b = int(bnm[0])

    n = int(bnm[1])

    m = int(bnm[2])

    keyboards = list(map(int, input().rstrip().split()))

    drives = list(map(int, input().rstrip().split()))

    #
    # The maximum amount of money she can spend on a keyboard and USB drive, or -1 if she can't purchase both items
    #

    moneySpent = getMoneySpent(keyboards, drives, b)

    fptr.write(str(moneySpent) + '\n')

    fptr.close()

    
