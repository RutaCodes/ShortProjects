#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Mar 25 17:34:45 2023

@author: rutabasijokaite
"""

# From HackerRank

# PROBLEM

#You will be given a list of 32 bit unsigned integers. Flip all the bits (1 to 0 and 0 to 1) and return the result 
#as an unsigned integer.

#Example

#n = 9(in10)
#9(in10) = 1001(in2). We're working with 32 bits, so:
#0000000000 0000000000 0000000010 01 (in2) = 9(in10)
#1111111111 1111111111 1111111101 10 (in2) = 4294967286(in10)

#Return 4294967286.

#Function Description:

#Complete the flippingBits function in the editor below.

#flippingBits has the following parameter(s):
#int n: an integer

#Returns:
#int: the unsigned decimal integer result

#Input Format:

#The first line of the input contains q, the number of queries.
#Each of the next q lines contain an integer, n, to process.


# SOLUTION

import os

def flippingBits(n):
    Num1 = (32-len(bin(n)[2:]))*'0' + bin(n)[2:]
    Num_sep = [*Num1]
    swap = {'0': '1', '1': '0'}
    for i in range(len(Num_sep)):
        Num_sep[i]=swap[Num_sep[i]]
    return int('0b'+''.join(Num_sep),2)
    

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    q = int(input().strip())

    for q_itr in range(q):
        n = int(input().strip())

        result = flippingBits(n)

        fptr.write(str(result) + '\n')

    fptr.close()
