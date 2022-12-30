#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Dec 29 21:41:11 2022

@author: rutabasijokaite
"""

# PROBLEM:
    
#Johnny is a farmer and he annually holds a beet farmers convention "Drop the beet".

#Every year he takes photos of farmers handshaking. Johnny knows that no two farmers handshake more than once. 
#He also knows that some of the possible handshake combinations may not happen.

#However, Johnny would like to know the minimal amount of people that participated this year just by counting 
#all the handshakes.

#Help Johnny by writing a function, that takes the amount of handshakes and returns the minimal amount of 
#people needed to perform these handshakes (a pair of farmers handshake only once).    
    
    
# SOLUTION:
    
def get_participants(handshakes):
    handshakes = int(handshakes)
    if handshakes == 0:
        return 0
    elif handshakes == 1:
        return 2
    else:
        n=0
        for i in range(1,handshakes+1):
            n += i
            if n >= handshakes:
                return i+1
                break