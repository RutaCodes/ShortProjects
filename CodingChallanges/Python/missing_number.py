#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Mar 23 22:21:18 2023

@author: rutabasijokaite
"""
# Source: Interview Query

# PROBLEM:
    
#You have an array of integers, nums of length n spanning 0 to n with one missing. Write a function missing_number that returns the missing number in the array.

#Note: Complexity of O(n) required.

#Example:

#Input:
#nums = [0,1,2,4,5] 
#missing_number(nums) -> 3


# SOLUTION:
    
def missing_number(nums):
    return (len(nums)*(len(nums)+1)/ 2) - sum(nums)
    

