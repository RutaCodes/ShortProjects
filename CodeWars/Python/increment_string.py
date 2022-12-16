#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Dec  7 23:55:39 2022

@author: rutabasijokaite
"""

# PROBLEM:
    
#Your job is to write a function which increments a string, to create a new string.

#If the string already ends with a number, the number should be incremented by 1.
#If the string does not end with a number. the number 1 should be appended to the new string.

#Examples:
#foo -> foo1
#foobar23 -> foobar24
#foo0042 -> foo0043
#foo9 -> foo10
#foo099 -> foo100

#Attention: If the number has leading zeros the amount of digits should be considered.


# SOLUTION:

def increment_string(st):
    if len(st) == 0:
        return str(1)
    else:
        if st.isdigit():
            return str(int(st)+1).zfill(len(st)) 
        else:
            if st[-1].isdigit():
                i = 0
                while (st[-(i+1)].isdigit()):
                    i += 1   
                st = st[:-i] + str(int(st[-i:])+1).zfill(i) 
            else:
                st = st + str(1)
            return st
