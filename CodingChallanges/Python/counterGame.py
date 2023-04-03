#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Apr  2 22:10:14 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

Louise and Richard have developed a numbers game. They pick a number and check to see 
if it is a power of 2. If it is, they divide it by 2. If not, they reduce it by the next 
lower number which is a power of 2. Whoever reduces the number to 1 wins the game. Louise always starts.

Given an initial value, determine who wins the game.

Example n = 132

It's Louise's turn first. She determines that 132 is not a power of 2. The next lower 
power of 2 is 128, so she subtracts that from 132 and passes 4 to Richard. 4 is a power 
of 2, so Richard divides it by 2 and passes 2 to Louise. Likewise, 2 is a power so she 
divides it by 2 and reaches 1. She wins the game.

'''

# SOLUTION

import os 
import math

def counterGame(n):
    cnt = 0
    while n > 1:
        if ((n & (n-1) == 0) and n != 0):
            n = int(n / 2)
        else:
            n -= 2**int(math.log(n,2))
        cnt += 1
    return 'Richard' if cnt % 2 == 0 else 'Louise'
    
    
    
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    t = int(input().strip())

    for t_itr in range(t):
        n = int(input().strip())

        result = counterGame(n)

        fptr.write(result + '\n')

    fptr.close()
   
    
'''
# There is a pattern when n is square
def counterGame(n):
    if ((n & (n-1) == 0) and n != 0):
        if (int(n**0.5) % 2) == 0:
            return 'Richard'
        else:
            return 'Luise'
    else:
        return 'Not square'





# Works, but takes too long

def counterGame(n):
    if ((n & (n-1) == 0) and n != 0):
        if (int(n**0.5) % 2) == 0:
            return 'Richard'
        else:
            return 'Luise'
    else:
        cnt = 0
        while n > 1:
            for i in range(1,int(n/2)+1):
                n1 = n - i
                if ((n1 & (n1-1) == 0) and n1 != 0):
                    n = n - n1
                    break
            cnt += 1
        return 'Richard' if cnt % 2 == 0 else 'Luise'
  
    



# Does not take into account when n is not square and it becomes one after subtraction 
def counterGame(n):
    if ((n & (n-1) == 0) and n != 0):
        if (int(n**0.5) % 2) == 0:
            return 'Richard'
        else:
            return 'Luise'
    else:
        cnt = 0
        while n > 1:
            n -= 2**int(math.log(n,2))
            cnt += 1
        return 'Richard' if cnt % 2 == 0 else 'Luise'

    
  
    
n=7
for i in range(1,int(n/2)+1):
    n1 = n - i
    if ((n1 & (n1-1) == 0) and n1 != 0):
        n = n - n1
        break
    
'''