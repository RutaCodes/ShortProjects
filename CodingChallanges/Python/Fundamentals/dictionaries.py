#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu May  4 22:52:35 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

The provided code stub will read in a dictionary containing key/value pairs of name:[marks] 
for a list of students. Print the average of the marks array for the student name provided, 
showing 2 places after the decimal.

Example:
    marks key:value pairs are
    'alpha':[20,30,40]
    'beta':[30,50,70]
If query_name is 'beta', calculate (30 + 50 + 70) / 3 = 50.00

'''

# SOLUTION

if __name__ == '__main__':
    n = int(input())
    student_marks = {}
    for _ in range(n):
        name, *line = input().split()
        scores = list(map(float, line))
        student_marks[name] = scores
    query_name = input()
    
    aver_score = sum(student_marks[query_name]) / 3
    print("{:.2f}".format(aver_score))