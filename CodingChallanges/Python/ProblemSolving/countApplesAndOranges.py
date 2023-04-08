#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Apr  8 14:37:53 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

Sam's house has an apple tree and an orange tree that yield an abundance of fruit. Using the information given 
below, determine the number of apples and oranges that land on Sam's house.

In the diagram below:
- The red region denotes the house, where s is the start point, and t is the endpoint. The apple tree is to 
the left of the house, and the orange tree is to its right.
- Assume the trees are located on a single point, where the apple tree is at point a, and the orange tree is at point b.
- When a fruit falls from its tree, it lands d units of distance from its tree of origin along the x-axis. 
*A negative value of d means the fruit fell d units to the tree's left, and a positive value of d means it falls d units to the tree's right.*

'''
# SOLUTION

def countApplesAndOranges(s, t, a, b, apples, oranges):
    a_ct, o_ct = 0, 0
    for i in range(len(apples)):
        if (a + apples[i] >= s) & (a + apples[i] <= t):
            a_ct += 1 
    for i in range(len(oranges)):
        if (b + oranges[i] >= s) & (b + oranges[i] <= t):
            o_ct += 1    
    print(a_ct), print(o_ct)