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



'''
The polyval tool evaluates the polynomial at specific value:
print numpy.polyval(P, x)

You are given the coefficients of a polynomial P
You task is to find the value of P at point x.

Example: print numpy.polyval([1, -2, 0, 2], 4)

'''

import numpy

P = numpy.array(input().split(), float)
x = int(input())

print(numpy.polyval(P, x))



'''
You are given a square matrix A with dimensions N x N. Your task is to find the determinant. 
Note: Round the answer to 2 places after the decimal.

Input format:
The first line contains the integer N.
The next N lines contains the N space separated elements of array A.

Print the determinants of A.

'''

import numpy

N = int(input())
A = numpy.array([input().split() for _ in range(N)], float)

print(round(numpy.linalg.det(A), 2))
