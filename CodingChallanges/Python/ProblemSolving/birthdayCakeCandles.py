#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Apr  6 23:35:24 2023

@author: rutabasijokaite
"""

# You are in charge of the cake for a child's birthday. You have decided the cake will have one candle 
# for each year of their total age. They will only be able to blow out the tallest of the candles. 
# Count how many candles are tallest.

# Examples: candles = [4,4,2,1]
# The maximum height of candles are 4. There are 2 of them, so return 2.

def birthdayCakeCandles(candles):
    return candles.count(max(candles))