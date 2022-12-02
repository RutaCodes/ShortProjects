#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Dec  2 14:12:37 2022

@author: rutabasijokaite
"""

# PROBLEM:
#Implement a function that adds two numbers together and returns their sum in 
#binary. The conversion can be done before, or after the addition.
#The binary number returned should be a string.

#Examples:(Input1, Input2 --> Output (explanation)))
#1, 1 --> "10" (1 + 1 = 2 in decimal or 10 in binary)
#5, 9 --> "1110" (5 + 9 = 14 in decimal or 1110 in binary)

# SOLUTION:
def add_binary(a,b):
    return bin(a+b)[2:]