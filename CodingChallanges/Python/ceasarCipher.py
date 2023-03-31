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
    new_msg = ''
    for i in s:
        if i in abc:
            new_msg += abc[(abc.index(i)+k)%26]
        elif i in abc.upper():
            new_msg += abc[(abc.index(i.lower())+k)%26].upper()
        else:
            new_msg += i
    return new_msg
    

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    s = input()

    k = int(input().strip())

    result = caesarCipher(s, k)

    fptr.write(result + '\n')

    fptr.close()



'''
# SOLUTION TRIES

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
    #abc = [chr(i) for i in range(ord('a'),ord('z')+1)]
    abc = 'abcdefghijklmnopqrstuvwxyz'
    #abc_cipher = abc[k:] + abc[:k]
    #abc_upper = abc.upper()
    #abc_cipher_upper = abc_cipher.upper()
    
    new_msg = ''
    for i in s:
        if i in abc:
            #new_msg += abc_cipher[abc.index(i)]
            new_msg += abc[(abc.index(i)+k)%26]
        elif i in abc.upper():
            #new_msg += abc_cipher_upper[abc_upper.index(i)]
            new_msg += abc[(abc.index(i.lower())+k)%26].upper()
        else:
            new_msg += i
    return new_msg
            


def caesarCipher(s, k):
    #abc = [chr(i) for i in range(ord('a'),ord('z')+1)]
    abc = 'abcdefghijklmnopqrstuvwxyz'
    abc_cipher = abc[k:] + abc[:k]
    
    new_msg = ''
    for i in s:
        if i in abc:    
            new_msg += abc_cipher[abc.index(i)]
        elif i in abc.upper():
            new_msg += abc_cipher[abc.index(i.lower())].upper()
        else:
            new_msg += i
       # elif i.isupper():
       #     new_msg += abc_cipher[abc.index(i.lower())].upper()
       # else:
       #     new_msg += abc_cipher[abc.index(i)]
    return new_msg



def caesarCipher(s, k):
    abc = [chr(i) for i in range(ord('a'),ord('z')+1)]
    abc = 'abcdefghijklmnopqrstuvwxyz'
    abc_cipher = abc[k:] + abc[:k]
    
    new_msg = ''
    for i in s:
        if i in ['-','`','!','?','.',',']:    
            new_msg += i
        elif i.isupper():
            new_msg += abc_cipher[abc.index(i.lower())].upper()
        else:
            new_msg += abc_cipher[abc.index(i)]
    return new_msg
    

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    s = input()

    k = int(input().strip())

    result = caesarCipher(s, k)

    fptr.write(result + '\n')

    fptr.close()

'''

'''

# Works, but it's too slow

def caesarCipher(s, k):
    abc = [chr(i) for i in range(ord('a'),ord('z')+1)]
    abc_cipher = abc[k:] + abc[:k]
    
    s_list = list(s)
    #Just lower case letters
    s_low = list(s.lower())
    new_msg = []
    for i in s_low:
        if i in ['-','`','!','?','.',',']:    
            new_msg.append(i)
        else:
            new_msg.append(abc_cipher[abc.index(i)])
    
    #Capitalize any letters if needed
    for i,val in enumerate(s_list):
        if val.isupper():
            new_msg[i] = new_msg[i].upper()

    #Convert back to string
    return ''.join(new_msg)  


'''

'''

# From others:
    
def caesarCipher(s, k):
    dic_l = "abcdefghijklmnopqrstuvwxyz"
    dic_u = dic_l.upper()
    w = ""
    for i in s:
        if i in dic_l:
            w+=dic_l[(dic_l.index(i)+k)%26]
        elif i in dic_u:
            w+=dic_u[(dic_u.index(i)+k)%26]
        else:
            w+=i 
    return w
    
    
def caesarCipher(s, k):
    # Write your code here
    alpha_lower = "abcdefghijklmnopqrstuvwxyz"
    alpha_upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    result = ""

    for i in s:
        if i.isupper():
            a = alpha_upper
        else:
            a = alpha_lower

        index = a.find(i)
        if index >= 0:
            if (index + k)/len(a) < 1:
                result += a[index+k]
            else:
                result += a[(index + k) % len(a)]
        else:
            result += i
    
    return(result) 

'''

'''
Trial and error


        if i in ['-','`','!','?','.',',']:  
            new_msg += i  
        #if i.islower():
            #new_msg += abc_cipher[abc.index(i)]
        elif i.isupper():
            #ind = abc.index(i.lower())
            #new_msg += abc_cipher[ind].upper()
            #new_msg += abc_cipher[abc.index(i.lower())].upper()
            new_msg += abc_cipher_upper[abc_upper.index(i)]
        else:
            new_msg += abc_cipher[abc.index(i)]
            #new_msg += i
    return new_msg


new_msg[i] = new_msg[i].upper() if  val in isupper(val) for i, val in enumerate (list(s))

s_list = list(s)
for i,val in enumerate(s_list):
    if isupper(val):
        new_msg[i] = new_msg[i]

s = 'There`s-a-starman-waiting-in-the-sky'
k =3

abc = [chr(i) for i in range(ord('a'),ord('z')+1)]
abc_cipher = abc[k:] + abc[:k]

#Just lower case letters
s_low = list(s.lower())
new_msg = []
cnt = 0
for i in list(s_low):
    #if (i == '-') | (i == '`'):
    if i in ['-','`','!','?','.',',']:
        new_msg.append(i)
        #cnt += 1
    else:
        new_msg.append(abc_cipher[abc.index(i)])
    
#Capitalize first letter
new_msg[0] = new_msg[0].upper()
#Convert back to string
final = ''.join(new_msg)
