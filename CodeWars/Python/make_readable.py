#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Dec 10 23:26:03 2022

@author: rutabasijokaite
"""

# PROBLEM:

#Write a function, which takes a non-negative integer (seconds) as 
#input and returns the time in a human-readable format (HH:MM:SS)

#HH = hours, padded to 2 digits, range: 00 - 99
#MM = minutes, padded to 2 digits, range: 00 - 59
#SS = seconds, padded to 2 digits, range: 00 - 59
#The maximum time never exceeds 359999 (99:59:59)


# SOLUTION:
    
def make_readable(sec):
    HH = sec // (60*60)
    MM = (sec - (HH * 60 * 60)) // 60
    SS = sec - HH * 60 * 60 - MM * 60
    return "%s:%s:%s" % (str(HH).zfill(2), str(MM).zfill(2), str(SS).zfill(2))
