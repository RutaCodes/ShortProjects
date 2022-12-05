#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Dec  4 22:45:54 2022

@author: rutabasijokaite
"""

#Deoxyribonucleic acid (DNA) is a chemical found in the nucleus of cells 
#and carries the "instructions" for the development and functioning of living organisms.

#In DNA strings, symbols "A" and "T" are complements of each other, as "C" and "G". 
#Your function receives one side of the DNA (string, except for Haskell); you need to 
#return the other complementary side. DNA strand is never empty or there is no DNA at all 
#(again, except for Haskell).

#Example: (input --> output)
#"ATTGC" --> "TAACG"
#"GTAT" --> "CATA"

import numpy as np
def DNA_strand(dna):
    new_dna = np.array([*dna])
    T_ind = np.where(new_dna == "T")[0]
    A_ind = np.where(new_dna == "A")[0]
    C_ind = np.where(new_dna == "C")[0]
    G_ind = np.where(new_dna == "G")[0]
    new_dna[T_ind] = "A"
    new_dna[A_ind] = "T"
    new_dna[C_ind] = "G"
    new_dna[G_ind] = "C"
    return ''.join(new_dna)