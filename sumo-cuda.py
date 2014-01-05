#!/usr/bin/python
##
# @file: car.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Sun, Jan 5, 2014
# @version: 0.1
# ##
# Car object implementation.
##

from car import Car

help_string = """SUMO-CUDA
    USAGE: python sumo-cuda.py [options] network.netccfg

Authors: Thaddeus Bond, Chris Blatchley
"""

def main():
    miata = Car(0, 60, 5, 2)
    miata.honk()

if __name__ == '__main__':
    main()