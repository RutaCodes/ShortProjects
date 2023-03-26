#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Mar 25 23:10:10 2023

@author: rutabasijokaite
"""

# From HackerRank

'''
# PROBLEM

A pangram is a string that contains every letter of the alphabet. Given a sentence determine whether it is 
a pangram in the English alphabet. Ignore case. Return either pangram or not pangram as appropriate.

Example:

s = 'The quick brown fox jumps over the lazy dog'

The string contains all letters in the English alphabet, so return pangram.

Function Description:

Complete the function pangrams in the editor below. It should return the string pangram if the input string is a pangram. Otherwise, it should return not pangram.

pangrams has the following parameter(s):

string s: a string to test

Returns:

string: either pangram or not pangram

Input Format:

A single line with string s.


'''

# SOLUTION

def pangrams(s):
    # 1)removing uppercase letters and spaces
    # 2)checking if number of unique values are equal to the number of letters in english alphabet
    if len(set(s.lower().replace(' ',''))) == 26:
        return 'pangram'
    else:
        return 'not pangram'