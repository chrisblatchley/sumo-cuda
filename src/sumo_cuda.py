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

from src.network import Network
from src.edge import Edge
from src.lane import Lane
from src.route import Route
from src.junction import Junction
from src.vehicle import Vehicle

help_string = """SUMO-CUDA
    USAGE: python sumo-cuda.py [options] network.py.netccfg

Authors: Thaddeus Bond, Chris Blatchley
"""


def main():
    print(help_string)

def tests():
    """Run a basic test"""
    network = Network()
    edge = Edge("edgeA", None, 1000, 30)
    route = Route("routeA", [edge, edge], True)
    network.addEdge( edge )
    network.addRoute( route )
    edge.addlane("laneA")
    print(edge.lanes)

    network.runSimulation()

if __name__ == '__main__':
    tests()
