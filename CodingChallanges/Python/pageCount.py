#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar 29 22:56:16 2023

@author: rutabasijokaite
"""
# From HackerRank

'''
# PROBLEM

A teacher asks the class to open their books to a page number. A student can either 
start turning pages from the front of the book or from the back of the book. 
They always turn pages one at a time. When they open the book, page 1 is always 
on the right side.

When they flip page 1, they see pages 2 and 3. Each page except the last page 
will always be printed on both sides. The last page may only be printed on the 
front, given the length of the book. If the book is n pages long, and a student 
wants to turn to page p, what is the minimum number of pages to turn? They can 
start at the beginning or the end of the book.

Given n and p, find and print the minimum number of pages that must be turned 
in order to arrive at page p.

If the student wants to get to page 3, they open the book to page 1, flip 1 page 
and they are on the correct page. If they open the book to the last page, page 5, 
they turn 1 page and are at the correct page. Return 1.

Function Description:

pageCount has the following parameter(s):
- int n: the number of pages in the book
- int p: the page number to turn to

Returns
- int: the minimum number of pages to turn

Input Format

The first line contains an integer n, the number of pages in the book.
The second line contains an integer, p, the page to turn to.

'''

#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'pageCount' function below.
#
# The function is expected to return an INTEGER.
# The function accepts following parameters:
#  1. INTEGER n
#  2. INTEGER p
#

def pageCount(n, p):
    start = [0]
    for i in range(1,(int((n-1)/2))+1):
        val = 2*[i]
        start.extend(val)
#If number of pages is even - last page will be printed on its own
    if n%2 == 0:
        start.append(max(start)+1)
#Calculate number of flips
    front = start[p-1]
    back = max(start)-start[p-1]
    return min(front,back)

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    p = int(input().strip())

    result = pageCount(n, p)

    fptr.write(str(result) + '\n')

    fptr.close()
