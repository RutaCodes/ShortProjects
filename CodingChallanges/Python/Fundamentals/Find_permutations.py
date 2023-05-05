#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu May  4 22:11:46 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

Let's learn about list comprehensions! You are given three integers x,y and z representing the 
dimensions of a cuboid along with an integer n. Print a list of all possible coordinates 
given by (i,j,k) on a 3D grid where the sum of i + j + k is not equal to n. Here, 0 <= i <= x;
0 <= j <= y; 0 <= k <= z. Please use list comprehensions rather than multiple loops, as 
a learning exercise.

Example:
x = 1
y = 1
z = 2
n = 3

All permutations of [i,j,k] that do not sum to n = 3:
[[0,0,0],[0,0,1],[0,0,2],[0,1,0],[0,1,1],[1,0,0],[1,0,1],[1,1,0],[1,1,2]]

'''

# SOLUTION

if __name__ == '__main__':
    x = int(input())
    y = int(input())
    z = int(input())
    n = int(input())
    
    perm = []
    for i in range(x+1):
        for j in range(y+1):
            for k in range(z+1):
                if i + j + k != n:
                    perm.append([i, j, k])
    
    print(perm)