##
# @file: lane.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Tue, Jan 28, 2014
# @version: 0.1
# ##
# Lane object for an edge
##

class Network(object):
    """Network Object to contain and run the edges, junctions, and the main simulation loop
    """

    ##
    # Network Contructor
    ##
    def __init__(self, maxTime = 3600):
        self.edges = []
        self.junctions = []
        self.timeStep = 0
        self.maxTime = maxTime
        self.vehicleController =

    ##
    # runSimulation
    ##
    def runSimulation(self):
        while self.timeStep < self.maxTime:

            # Simulate movement through each edge
            for edge in self.edges:
                edge.runLanes()

            # Simulate movement through each junction
            for junction in self.junctions:
                junction.runTimestep()

            # Cleanup vehicles and start new ones coming in
            self.vehicleController.refreshTimestep()