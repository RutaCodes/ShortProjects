#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan  2 21:46:17 2023

@author: rutabasijokaite
"""

# PROBLEM

#A Hamming number is a positive integer of the form 2i3j5k, for some non-negative integers i, j, and k.

#Write a function that computes the nth smallest Hamming number.

#Specifically:

#The first smallest Hamming number is 1 = 2^0*3^0*5^0
#The second smallest Hamming number is 2 = 2^1*3^0*5^0
#The third smallest Hamming number is 3 = 2^0*3^1*5^0
#The fourth smallest Hamming number is 4 = 2^2*3^0*5^0
#The fifth smallest Hamming number is 5 = 2^0*3^0*5^1

#The 20 smallest Hamming numbers are given in the Example test fixture.


# SOLUTION

#Finding nth number
#Based on Dijkstra’s paper
#If x is in the sequence, so are 2 * x, 3 * x, and 5 * x

def hamming(n):
    bases = [2, 3, 5]
    expon = [0, 0, 0]
    hamms_seq = [1]
    for _ in range(1, n):
        next_hamms = [bases[i] * hamms_seq[expon[i]] for i in range(3)]
        next_hamm_nr = min(next_hamms)
        hamms_seq.append(next_hamm_nr)
        for i in range(3):
            expon[i] += int(next_hamms[i] == next_hamm_nr)
    return hamms_seq[-1]

