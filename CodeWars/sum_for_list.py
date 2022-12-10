#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Dec 10 18:45:26 2022

@author: rutabasijokaite
"""

# PROBLEM:
    
#Given an array of positive or negative integers
# I= [i1,..,in]
#you have to produce a sorted array P of the form:
#[ [p, sum of all ij of I for which p is a prime factor (p positive) of ij] ...]
#P will be sorted by increasing order of the prime numbers. The final result has 
#to be given as a string in Java, C#, C, C++ and as an array of arrays in other languages.

#Example:
#I = [12, 15] # result = [[2, 12], [3, 27], [5, 15]]
#[2, 3, 5] is the list of all prime factors of the elements of I, hence the result.

#Notes:
#It can happen that a sum is 0 if some numbers are negative!
#Example: I = [15, 30, -45] 5 divides 15, 30 and (-45) so 5 appears in the result, 
#the sum of the numbers for which 5 is a factor is 0 so we have [5, 0] in the result amongst others.


# SOLUTION:

from functools import reduce
def sum_for_list(I):
    prime = []
    for i in I:
        if i < 0:
            i *= -1
        #variable to store prime factors 
        N = []
        p = 2
        while i > 1:
            #find first available prime factor in a sequence
            if ((i % p) == 0):   
                #record p value
                N = [*N, p]
                i = i/p
            else:
                p += 1
        #saving all prime factors 
        prime = [*prime, *N]

    #Keep only 'unique' prime factors
    prime_f = sorted(reduce(lambda re, x: re+[x] if x not in re else re, prime, []))

    #Find sums
    answer = []
    for val in prime_f:
        sum1 = 0
        for j in I:
            if (j % val) == 0:
                sum1 += j
        answer.append([val, sum1])
    return answer
