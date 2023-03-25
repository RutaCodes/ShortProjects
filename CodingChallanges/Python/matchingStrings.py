#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 24 21:00:08 2023

@author: rutabasijokaite
"""

# From HackerRank

# PROBLEM

#There is a collection of input strings and a collection of query strings. For each query string, 
#determine how many times it occurs in the list of input strings. Return an array of the results.

#Example:
#string = ['ab','ab','abc']
#queries = ['ab','abc','bc']

#There are 2 instances of 'ab', 1 of 'abc' and 0 of 'bc'. For each query, add an element to the return array, 
#results = [2,1,0].

#Function Description:

#Complete the function matchingStrings in the editor below. The function must return an array of integers 
#representing the frequency of occurrence of each query string in strings.

#matchingStrings has the following parameters:

#string strings[n] - an array of strings to search
#string queries[q] - an array of query strings

#Returns:
#int[q]: an array of results for each query


# SOLUTION

import os

# The function is expected to return an INTEGER_ARRAY.
# The function accepts following parameters:
#  1. STRING_ARRAY strings
#  2. STRING_ARRAY queries
#

def matchingStrings(strings, queries):
    results = []
    for i in range(len(queries)):
       results.append(strings.count(queries[i]))
    return results


if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    strings_count = int(input().strip())

    strings = []

    for _ in range(strings_count):
        strings_item = input()
        strings.append(strings_item)

    queries_count = int(input().strip())

    queries = []

    for _ in range(queries_count):
        queries_item = input()
        queries.append(queries_item)

    res = matchingStrings(strings, queries)

    fptr.write('\n'.join(map(str, res)))
    fptr.write('\n')

    fptr.close()
