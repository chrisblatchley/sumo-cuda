##
# @file: lane.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Tue, Jan 28, 2014
# @version: 0.1
# ##
# Lane object for an edge
##

from vehicle_control import VehicleControl
from vehicle import Vehicle

try:  # do not edit! added by PythonBreakpoints
    from ipdb import set_trace as _breakpoint
except ImportError:
    from pdb import set_trace as _breakpoint


class Network(object):
    """Network Object to contain and run the edges, junctions, and the main simulation loop
    """

    ##
    # Network Contructor
    ##
    def __init__(self, maxTime = 150):
        self.edges = []
        self.junctions = []
        self.routes = []
        self.timeStep = 0
        self.maxTime = maxTime
        self.vehicleController = VehicleControl()

    ##
    # addEdge
    ##
    def addEdge(self, edge):
        self.edges.append(edge)

    ##
    # addJunction
    ##
    def addJunction(self, junction):
        self.junctions.append(junction)

    ##
    # addRoute
    ##
    def addRoute(self, route):
        self.routes.append(route)
    ##
    # runSimulation
    ##
    def runSimulation(self):

        while self.timeStep < self.maxTime:            
            print("Timestep"  + str(self.timeStep))
            # Simulate movement through each edge
            for edge in self.edges:
                edge.runLanes()

            # Simulate movement through each junction
            for junction in self.junctions:
                junction.runTimestep()

            # Cleanup vehicles and start new ones coming in
            self.vehicleController.refreshTimestep(self.timeStep)

            # Next Time Step!
            self.timeStep = self.timeStep + 1