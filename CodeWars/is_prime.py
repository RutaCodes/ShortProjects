#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec  6 15:40:00 2022

@author: rutabasijokaite
"""

# PROBLEM:
#Define a function that takes an integer argument and returns a logical value true 
#or false depending on if the integer is a prime.

#Per Wikipedia, a prime number ( or a prime ) is a natural number greater than 1 that 
#has no positive divisors other than 1 and itself.

#Requirements:
#You can assume you will be given an integer input.
#You can not assume that the integer will be only positive. You may be given 
#negative numbers as well ( or 0 ).
#NOTE on performance: There are no fancy optimizations required, but still the most 
#trivial solutions might time out. Numbers go up to 2^31 ( or similar, depending on language ). 
#Looping all the way up to n, or n/2, will be too slow.

#Example:
#is_prime(1)  /* false */
#is_prime(2)  /* true  */
#is_prime(-1) /* false */


# SOLUTION:
#Solution without FOR or WHILE loops
import numpy as np
def is_prime(num):
    #We know that if number ends with 0,2,4,5,6,8, it will not be prime number since
    #it will be able to be divided by 2 and 5 - great shortcut for large numbers
    #Number also has to be larger than 1
    vl = (0,2,4,5,6,8)
    if (((num%10 in vl) & (num != 2) & (num != 5)) | (num < 2)):
        return False
    else:
        #Create a vector with sequence 2:sqrt(n)//1
        #Don't need to check all numbers, as anything above sqrt(num) will have decimal point
        B = np.array(list(range(2,int((num**0.5)//1 +1))))
        #Divide the number by vector B and count how many times division%1 == 0
        #If it is equal to 0, then that means it only can get divided by 1 and itself - hence it's a prime number 
        return True if ((num > 1) & ((len(np.where(np.divide(num,B)%1 == 0)[0])) == 0)) else False