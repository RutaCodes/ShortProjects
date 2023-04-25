#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr 24 22:37:43 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

Given an array of bird sightings where every element represents a bird type id, determine the id 
of the most frequently sighted type. If more than 1 type has been spotted that maximum amount, return 
the smallest of their ids.

Example: arr = [1,1,2,2,3]
Return 1

'''
# SOLUTION 

#!/bin/python3

import os

def migratoryBirds(arr):
    return max(set(arr), key = arr.count)

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    arr_count = int(input().strip())

    arr = list(map(int, input().rstrip().split()))

    result = migratoryBirds(arr)

    fptr.write(str(result) + '\n')

    fptr.close()
