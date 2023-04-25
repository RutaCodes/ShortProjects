#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr 24 21:40:47 2023

@author: rutabasijokaite
"""

# From HackerRank

'''
# PROBLEM

HackerLand University has the following grading policy:

Every student receives a grade in the inclusive range from 0 to 100.
Any grade less than 40 is a failing grade.
Sam is a professor at the university and likes to round each student's grade according to these rules:

If the difference between the grade and the next multiple of 5 is less than 3, round grade up to the next multiple of 5.
If the value of grade is less than 38, no rounding occurs as the result will still be a failing grade.

'''

# SOLUTION

#!/bin/python3

import math
import os

def gradingStudents(grades):
    for i in range(len(grades)):
        diff = math.ceil(grades[i]/5)*5 - grades[i]
        if (grades[i] >= 38) & (diff < 3):
            grades[i] = math.ceil(grades[i]/5)*5
    return grades      

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    grades_count = int(input().strip())

    grades = []

    for _ in range(grades_count):
        grades_item = int(input().strip())
        grades.append(grades_item)

    result = gradingStudents(grades)

    fptr.write('\n'.join(map(str, result)))
    fptr.write('\n')

    fptr.close()
