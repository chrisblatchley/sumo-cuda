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

from edge import Edge
from lane import Lane
from route import Route
from junction import Junction
from vehicle import Vehicle

help_string = """SUMO-CUDA
    USAGE: python sumo-cuda.py [options] network.netccfg

Authors: Thaddeus Bond, Chris Blatchley
"""

def main():
    print help_string

if __name__ == '__main__':
    main()


def tests():

	# single looping road tests
	edgeA = Edge("A", none)
	