#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Apr  2 21:09:13 2023

@author: rutabasijokaite
"""

'''
# PROBLEM

Two players are playing a game of Tower Breakers! Player 1 always moves first, and 
both players always play optimally.The rules of the game are as follows:

Initially there are n towers.
Each tower is of height m.
The players move in alternating turns.
In each turn, a player can choose a tower of height x and reduce its height to y, 
where 1 <= y < x and y evenly divides x.
If the current player is unable to make a move, they lose the game.

Given the values of n and m, determine which player will win. If the first 
player wins, return 1. Otherwise, return 2.    

'''
# SOLUTION

#Player 1 always wins when num of towers is odd. Player 2 always 
#wins when num of towers is even and when the height of towers is 1.

import os

def towerBreakers(n, m):
    if (m == 1) | (n%2 == 0):
        return 2
    else:
        return 1
    
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    t = int(input().strip())

    for t_itr in range(t):
        first_multiple_input = input().rstrip().split()

        n = int(first_multiple_input[0])

        m = int(first_multiple_input[1])

        result = towerBreakers(n, m)

        fptr.write(str(result) + '\n')

    fptr.close()
