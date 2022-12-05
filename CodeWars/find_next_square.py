#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Dec  2 14:16:58 2022

@author: rutabasijokaite
"""

# PROBLEM:
#You might know some pretty large perfect squares. But what about the NEXT one?
#Complete the findNextSquare method that finds the next integral perfect square 
#after the one passed as a parameter. Recall that an integral perfect square is an 
#integer n such that sqrt(n) is also an integer.

#If the parameter is itself not a perfect square then -1 should be returned. 
#You may assume the parameter is non-negative.

#Examples:(Input --> Output)
#121 --> 144
#625 --> 676
#114 --> -1 since 114 is not a perfect square
    
# SOLUTION:
from math import sqrt, pow
def find_next_square(sq):
    if (sqrt(sq)).is_integer():
        next_sq = int(pow((sqrt(sq)+1),2))
    else:
        next_sq = -1 
    return next_sq