#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 31 22:07:17 2023

@author: rutabasijokaite
"""

# From HackerRank
'''
# PROBLEM

Given a square grid of characters in the range ascii[a-z], rearrange elements 
of each row alphabetically, ascending. Determine if the columns are also in 
ascending alphabetical order, top to bottom. Return YES if they are or 
NO if they are not.

Example:
grid = ['abc', 'ade', 'efg']

The rows are already in alphabetical order. The columns a a e, b d f and 
c e g are also in alphabetical order, so the answer would be YES. Only 
elements within the same row can be rearranged. They cannot be moved to a 
different row.

Function Description

gridChallenge has the following parameter(s):
- string grid[n]: an array of strings

Returns
- string: either YES or NO

Input Format

The first line contains t, the number of testcases.

Each of the next t sets of lines are described as follows:
- The first line contains n, the number of rows and columns in the grid.
- The next n lines contains a string of length n.

Output Format

For each test case, on a separate line print YES if it is possible to 
rearrange the grid alphabetically ascending in both its rows and columns, 
or NO otherwise.

'''
# SOLUTION

import os

def gridChallenge(grid):
    #Alphabetizing rows
    for i in range(len(grid)):
        grid[i] = ''.join(sorted([*grid[i]])) 
    #Checking columns
    col = []
    for i in range(len(grid[0])):
        vl = []
        for j in range(len(grid)):
            vl.append(grid[j][i])
        col.append(vl == sorted(vl))
    
    if all(col):
        return 'YES'
    else:
        return 'NO'
        
    
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    t = int(input().strip())

    for t_itr in range(t):
        n = int(input().strip())

        grid = []

        for _ in range(n):
            grid_item = input()
            grid.append(grid_item)

        result = gridChallenge(grid)

        fptr.write(result + '\n')

    fptr.close()
