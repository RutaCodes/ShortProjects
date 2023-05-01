#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May  1 18:26:32 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

An avid hiker keeps meticulous records of their hikes. During the last hike that took exactly 'steps' steps, 
for every step it was noted if it was an uphill, U, or a downhill, D, step. Hikes always start and end at sea 
level, and each step up or down represents a  unit change in altitude. We define the following terms:

-A mountain is a sequence of consecutive steps above sea level, starting with a step up from sea level 
and ending with a step down to sea level.
-A valley is a sequence of consecutive steps below sea level, starting with a step down from sea level 
and ending with a step up to sea level.

Given the sequence of up and down steps during a hike, find and print the number of valleys walked through.

Example: steps = 8
         path = 'DDUUUUDD'
Hiker starts at sea level, then goes into valley, hikes up for 4 steps, and then goes down again finishing 
at sea level. Hiker traversed 1 valley.

'''

# SOLUTION

#!/bin/python3

import os

def countingValleys(steps, path):
    sea_level = 0
    valley = 0
    for i in path: 
        if i == 'U':
            sea_level += 1
        else:
            sea_level -= 1
        
        if (sea_level == 0) & (i == 'U'):
            valley += 1
    return valley
    

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    steps = int(input().strip())

    path = input()

    result = countingValleys(steps, path)

    fptr.write(str(result) + '\n')

    fptr.close()
