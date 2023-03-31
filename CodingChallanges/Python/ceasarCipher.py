#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Mar 30 12:20:30 2023

@author: rutabasijokaite
"""
# From HackerRank

'''
# PROBLEM

Julius Caesar protected his confidential information by encrypting it using a cipher. 
Caesar's cipher shifts each letter by a number of letters. If the shift takes you past 
the end of the alphabet, just rotate back to the front of the alphabet. In the case of a 
rotation by 3, w, x, y and z would map to z, a, b and c.

Example:
s = 'There`s-a-starman-waiting-in-the-sky'
k =3

The alphabet is rotated by 3, matching the mapping above. The encrypted string is 
Wkhuh`v-d-vwdupdq-zdlwlqj-lq-wkh-vnb.

Note: The cipher only encrypts letters; symbols, such as -, remain unencrypted.

Function Description:

caesarCipher has the following parameter(s):
- string s: cleartext
- int k: the alphabet rotation factor

Returns
- string: the encrypted string

Input Format

The first line contains the integer, n, the length of the unencrypted string.
The second line contains the unencrypted string, s.
The third line contains k, the number of letters to rotate the alphabet by.

'''
# SOLUTION 

#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'caesarCipher' function below.
#
# The function is expected to return a STRING.
# The function accepts following parameters:
#  1. STRING s
#  2. INTEGER k
#

def caesarCipher(s, k):
    abc = 'abcdefghijklmnopqrstuvwxyz'
    abc_cipher = abc[(k%26):] + abc[:(k%26)]
    new_msg = ''
    for i in s:
        if i in abc:
            new_msg += abc_cipher[abc.index(i)]
        elif i in abc.upper():
            new_msg += abc_cipher[abc.index(i.lower())].upper()
        else:
            new_msg += i
    return new_msg

'''
# OR

def caesarCipher(s, k):
    abc = 'abcdefghijklmnopqrstuvwxyz'
    new_msg = ''
    for i in s:
        if i in abc:
            new_msg += abc[(abc.index(i)+k)%26]
        elif i in abc.upper():
            new_msg += abc[(abc.index(i.lower())+k)%26].upper()
        else:
            new_msg += i
    return new_msg
'''   

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    s = input()

    k = int(input().strip())

    result = caesarCipher(s, k)

    fptr.write(result + '\n')

    fptr.close()
