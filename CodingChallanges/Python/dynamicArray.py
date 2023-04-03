#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Apr  2 21:36:26 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

Declare a 2-dimensional array, arr, of n empty arrays. All arrays are zero indexed.
Declare an integer, lastAnswer, and initialize it to 0.

There are 2 types of queries, given as an array of strings for you to parse:
    
1. Query: 1 x y
- Let idx = (x XOR lastAnswer) % n
- Append the integer y to arr[idx]

2. Query: 2 x y
- Let idx = (x XOR lastAnswer) % n
- Assign the value arr[idx][y % size(arr[idx])] to lastAnswer
- Store the new value to lastAnswer to an answer array

Returns:
- int[]: the results of each type 2 query in the order they are presented

'''

# SOLUTION

import os

def dynamicArray(n, queries):
    arr = [[] for i in range(n)]
    lastAnwser = 0
    anwsers = []
    for query in queries:
        idx = (query[1]^lastAnwser)%n
        if query[0] == 1:
            arr[idx].append(query[2])
        elif query[0] == 2:
            lastAnswer = arr[idx][int(query[2]) % len(arr[idx])]
            anwsers.append(lastAnswer)
    return anwsers


if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    first_multiple_input = input().rstrip().split()

    n = int(first_multiple_input[0])

    q = int(first_multiple_input[1])

    queries = []

    for _ in range(q):
        queries.append(list(map(int, input().rstrip().split())))

    result = dynamicArray(n, queries)

    fptr.write('\n'.join(map(str, result)))
    fptr.write('\n')

    fptr.close()
