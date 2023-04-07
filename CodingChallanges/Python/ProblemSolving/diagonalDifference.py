#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Apr  6 22:48:43 2023

@author: rutabasijokaite
"""

# Given a square matrix, calculate the absolute difference between the sums of its diagonals.

arr = [[11,2,4],[4,5,6],[10,8,-12]]

def diagonalDifference(arr):
    diag1, diag2 = 0, 0
    for i in range(len(arr)):
        diag1 += arr[i][i]
        diag2 += arr[i][len(arr)-i-1]
    return abs(diag1 - diag2)