#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Dec  7 22:44:33 2022

@author: rutabasijokaite
"""

# PROBLEM:

#Write an algorithm that takes an array and moves all of the zeros to the end, 
#preserving the order of the other elements.

#move_zeros([1, 0, 1, 2, 0, 1, 3]) # returns [1, 1, 2, 1, 3, 0, 0]


#SOLUTION:
    
def move_zeros(lst):
    non_zero = [value for i, value in enumerate(lst) if value != 0]
    zeros = [value for i, value in enumerate(lst) if value == 0]
    return [*non_zero, *zeros]
