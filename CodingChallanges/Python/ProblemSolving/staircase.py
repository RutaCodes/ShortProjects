#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Apr  6 23:17:31 2023

@author: rutabasijokaite
"""

# This is a staircase of size n. Its base and height are both equal to n. It is drawn using # symbols and spaces. 
# The last line is not preceded by any spaces.

def staircase(n):
    for i in range(1,n+1):
        print(f"{' '*(n - i) + '#'*i}")
