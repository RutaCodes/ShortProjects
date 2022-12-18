#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Dec  2 14:07:30 2022

@author: rutabasijokaite
"""

# PROBLEM:

#Usually when you buy something, you're asked whether your credit card number, phone number 
#or answer to your most secret question is still correct. However, since someone could look over your 
#shoulder, you don't want that shown on your screen. Instead, we mask it.
#Your task is to write a function maskify, which changes all but the last four characters into '#'.


# SOLUTION:

def maskify(cc):
    
    #input - cc - is a string that needs to be masked 
    #all characters except 4 last ones should become #
    
    #Get number of characters in input string
    if (len(cc)<5):
        #if string has less than 5 characters - there is nothing to mask
        masked_cc = cc
    else:
        #otherwise:
        #Select all characters but the last 4
        #Assign them new value '#'
        masked_cc = cc.replace(cc[0:len(cc)-4],"#"*(len(cc)-4))
    
    return(masked_cc)
