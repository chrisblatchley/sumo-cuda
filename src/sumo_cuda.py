#!/usr/bin/python3
#
# @file: car.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Sun, Jan 5, 2014
# @version: 0.1
# ##
# Car object implementation.
##

from debug import debug
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
    debug(help_string)

def singleRoadSingleVehicleTest():
    network = Network()
    edge = Edge("edgeA", 1000, 30)
    route = Route("routeA", [edge], True)
    network.addEdge( edge )
    network.addRoute( route )
    edge.addLane("laneA")
    vehicle = Vehicle(route, {"length": 5, "speed": 10}, 10)
    network.vehicleController.queueVehicle(vehicle)

    network.runSimulation()

def singleRoadTwoVehicleTest():
    network = Network()
    edge = Edge("edgeA", 1000, 30)
    route = Route("routeA", [edge], True)
    network.addEdge( edge )
    network.addRoute( route )
    edge.addLane("laneA")
    vehicle = Vehicle(route, {"length": 5, "speed": 10}, 10)
    network.vehicleController.queueVehicle(vehicle)
    vehicle2 = Vehicle(route, {"length": 5, "speed": 20}, 10)
    network.vehicleController.queueVehicle(vehicle2)

    network.runSimulation()

def twoRoadTwoVehicleTest():
    network = Network()
    edge = Edge("edgeA", 1000, 30)
    edge2 = Edge("edgeB", 700, 30)
    route = Route("routeA", [edge], True)
    route2 = Route("routeB", [edge2], True)
    network.addEdge( edge )
    network.addEdge( edge2 )
    network.addRoute( route )
    network.addRoute( route2 )
    edge.addLane("laneA")
    edge2.addLane("laneA")
    vehicle = Vehicle(route, {"length": 5, "speed": 10}, 10)
    network.vehicleController.queueVehicle(vehicle)
    vehicle2 = Vehicle(route2, {"length": 5, "speed": 20}, 10)
    network.vehicleController.queueVehicle(vehicle2)

    network.runSimulation()

def tests():
    # singleRoadSingleVehicleTest()
    # singleRoadTwoVehicleTest()
    twoRoadTwoVehicleTest()



if __name__ == '__main__':
    tests()
