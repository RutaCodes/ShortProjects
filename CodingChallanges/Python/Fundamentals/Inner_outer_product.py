#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May  1 19:23:31 2023

@author: rutabasijokaite
"""


'''

import numpy
A = numpy.array([0, 1])
B = numpy.array([3, 4])

The inner tool returns the inner product of two arrays:
print numpy.inner(A, B)        # Output: 4

The outer tool returns the outer product of two arrays:
print numpy.outer(A, B)        # Output: [[0 0] [3 4]]

'''

import numpy

A = numpy.array(input().split(), int) 
B = numpy.array(input().split(), int)

print(numpy.inner(A, B)) 
print(numpy.outer(A, B))
