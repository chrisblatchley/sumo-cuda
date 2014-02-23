#!/usr/bin/python
#
# @file: car.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Sun, Jan 5, 2014
# @version: 0.1
# ##
# Car object implementation.
##

from network import Network
from edge import Edge
from lane import Lane
from route import Route
from junction import Junction
from vehicle import Vehicle

help_string = """SUMO-CUDA
    USAGE: python sumo-cuda.py [options] network.py.netccfg

Authors: Thaddeus Bond, Chris Blatchley
"""


def main():
    print(help_string)

def tests():
    network = Network()
    edge = Edge("edgeA", None, 1000, 30)
    route = Route("routeA", [edge], True)
    network.addEdge( edge )
    network.addRoute( route )
    edge.addlane("laneA")
    vehicle = network.vehicleController.buildVehicle(network.routes[0], {"length": 5, "speed": 10}, 2)
    network.vehicleController.queueVehicle(vehicle)
    vehicle2 = network.vehicleController.buildVehicle(network.routes[0], {"length": 5, "speed": 20}, 4)
    network.vehicleController.queueVehicle(vehicle2)
    print(edge.lanes)

    network.runSimulation()

if __name__ == '__main__':
    tests()
