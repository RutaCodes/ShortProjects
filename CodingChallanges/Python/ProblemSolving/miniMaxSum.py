#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Apr  6 23:24:11 2023

@author: rutabasijokaite
"""

# Given five positive integers, find the minimum and maximum values that can be calculated by summing 
# exactly four of the five integers. Then print the respective minimum and maximum values as a single 
# line of two space-separated long integers.

def miniMaxSum(arr):
    arr.sort()
    print(sum(arr[:-1]),  sum(arr[1:])) 