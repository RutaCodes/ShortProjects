#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Dec  5 19:11:15 2022

@author: rutabasijokaite
"""

# PROBLEM:

#Move the first letter of each word to the end of it, then add "ay" to the 
#end of the word. Leave punctuation marks untouched.

#Examples
#pig_it('Pig latin is cool') # igPay atinlay siay oolcay
#pig_it('Hello world !')     # elloHay orldway !


# SOLUTION:

import string
def pig_it(text):
    return ' '.join([(i if i in string.punctuation else i[1:] + i[0] + 'ay')  for i in text.split(' ')])
