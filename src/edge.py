##
# @file: edge.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Sun, Jan 5, 2014
# @version: 0.1
# ##
# Edge object from one junction to another.
##

from src.lane import Lane
from src.lane_changer import LaneChanger

class Edge(object):
    """Edge is a road"""

    ##
    # Edge Contructor
    # @param uid 			unique string identification
    # @param numericalID	Numerical identification number
    # @param function		Basic type of the edge
    # @param streetName		Street name of edge
    # @param length			The length of the edge
    # @param maxSpeed		The maximum speed that may be traveled on the edge
    ##
    def __init__(self, uid, function, length, maxSpeed):
        super(Edge, self).__init__()
        self.uid = uid
        self.function = function
        self.length = length
        self.maxSpeed = maxSpeed
        self.lanes = []
        self.laneChanger = None
        self.isRotary = False

    ##
    # Add a lane to the edge
    # @param uid	The lane's unique identifier
    ##
    def addlane(self, uid):
        newLane = Lane(uid, self)
        self.lanes.append(newLane)

    ##
    # Once all lanes have been loaded for this edge, we can init the lane changer for it
    ##
    def initChanger(self):
        self.laneChanger = LaneChanger(self.lanes)

    ##
    # runLane
    ##
    def runLanes(self):
        for lane in self.lanes:
            lane.planMovements()
            lane.executeMovements()

    ##
    # addVehicle
    # Add a vehicle that is coming from a junction
    # @param vehicle The vehicle to add
    ##
    def addVehicle(self, vehicle):
        self.lanes[ len(self.lanes) - 1 ].addVehicle( vehicle )