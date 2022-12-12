#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Dec 12 14:26:55 2022

@author: rutabasijokaite
"""

# PROBLEM:

#Given a list of integers and a single sum value, return the first 
#two values (parse from the left please) in order of appearance that add up to form the sum.

#If there are two or more pairs with the required sum, the pair whose 
#second element has the smallest index is the solution.

#Examples:
#sum_pairs([11, 3, 7, 5],         10)
#              ^--^      3 + 7 = 10
#== [3, 7]

#sum_pairs([4, 3, 2, 3, 4],         6)
#          ^-----^         4 + 2 = 6, indices: 0, 2 *
#             ^-----^      3 + 3 = 6, indices: 1, 3
#                ^-----^   2 + 4 = 6, indices: 2, 4
#  * the correct answer is the pair whose second value has the smallest index
#== [4, 2]

#sum_pairs([0, 0, -2, 3], 2)
#  there are no pairs of values that can be added to produce 2.
#== None/nil/undefined (Based on the language)

#sum_pairs([10, 5, 2, 3, 7, 5],         10)
#              ^-----------^   5 + 5 = 10, indices: 1, 5
#                    ^--^      3 + 7 = 10, indices: 3, 4 *
#  * the correct answer is the pair whose second value has the smallest index
#== [3, 7]



# SOLUTION:

def sum_pairs(ints, s):
    myset = set()
    for i, num2 in enumerate(ints):
        num1 = s - num2
        if num1 in myset:
            return [num1, num2]
            break
        myset.add(num2)
    if i == len(ints)-1:
        return None
    
    
# SOLUTION THAT WORKS, BUT TIMES OUT ON LISTS len(List) == 10000000

def sum_pairs2(ints, s):
    sum1 = 0
    for i  in list(range(1,len(ints))):
        comb = [[el, i] for el in list(range(i))]
        for j in comb:
            sum1 = ints[j[0]] + ints[j[1]]
            if sum1 == s:
                break
        else:
            continue
        break
    if sum1 != s:
        return None
    else:
        return [ints[j[0]], ints[j[1]]]
