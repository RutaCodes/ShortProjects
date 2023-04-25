#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr 24 22:19:14 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

Maria plays college basketball and wants to go pro. Each season she maintains a record of her play. She 
tabulates the number of times she breaks her season record for most points and least points in a game. Points 
scored in the first game establish her record for the season, and she begins counting from there.

Given the scores for a season, determine the number of times Maria breaks her records for most and 
least points scored during the season.

Example: scores = [12,24,10,24] Would return 1,1 

Returns:

int[2]: An array with the numbers of times she broke her records. Index 0 is for breaking most points 
records, and index 1 is for breaking least points records.

'''
# SOLUTION

#!/bin/python3

import os

def breakingRecords(scores):
    min_v = scores[0]
    max_v = scores[0]
    min_c, max_c = 0, 0
    for i in range(1,len(scores)):
        if scores[i] > max_v:
            max_v = scores[i]
            max_c += 1
        elif scores[i] < min_v:
            min_v = scores[i]
            min_c += 1
    return max_c, min_c

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    scores = list(map(int, input().rstrip().split()))

    result = breakingRecords(scores)

    fptr.write(' '.join(map(str, result)))
    fptr.write('\n')

    fptr.close()
