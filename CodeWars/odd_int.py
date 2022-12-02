#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Dec  2 14:10:19 2022

@author: rutabasijokaite
"""

# PROBLEM:
#Given an array of integers, find the one that appears an odd number of times.
#There will always be only one integer that appears an odd number of times.

#Examples
#[7] should return 7, because it occurs 1 time (which is odd).
#[0] should return 0, because it occurs 1 time (which is odd).
#[1,1,2] should return 2, because it occurs 1 time (which is odd).
#[0,1,0,1,0] should return 0, because it occurs 3 times (which is odd).
#[1,2,2,3,3,3,4,3,3,3,2,2,1] should return 4, because it appears 1 time (which is odd).
    
# SOLUTION:
import numpy 
def find_it(seq):
    #finding unique values and counting them
    unique, counts = numpy.unique(seq, return_counts=True)
    return unique[numpy.where(counts%2 != 0)]
