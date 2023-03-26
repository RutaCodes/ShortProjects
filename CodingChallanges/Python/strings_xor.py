#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Mar 26 15:13:23 2023

@author: rutabasijokaite
"""

# From HackerRank

'''

# PROBLEM

Given two strings consisting of digits 0 and 1 only, find the XOR of the two strings.

Debug the given function strings_xor to find the XOR of the two given strings appropriately.

Note: You can modify at most three lines in the given code and you cannot add or remove lines to the code.

To restore the original code, click on the icon to the right of the language selector.

Input Format

The input consists of two lines. The first line of the input contains the first string, s, and the second 
line contains the second string, t.

'''

# SOLUTION

def strings_xor(s, t):
    res = ''
    for i in range(len(s)):
        if s[i] == t[i]:
            res += '0'
        else:
            res += '1'
    return res
    
s = input()
t = input()
print(strings_xor(s, t))
