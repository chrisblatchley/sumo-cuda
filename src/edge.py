##
# @file: edge.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Mon, Feb 24, 2014
# @version: 0.2
# ##
# Edge object from one junction to another.
##

from lane import Lane
from lane_changer import LaneChanger

class Edge(object):
    """Edge is a road"""

    ##
    # Edge Contructor
    # @param uid 			unique string identification
    # @param numericalID	Numerical identification number
    # @param streetName		Street name of edge
    # @param length			The length of the edge
    # @param maxSpeed		The maximum speed that may be traveled on the edge
    # @param junction       Ending junction to the edge
    ##
    def __init__(self, uid, length, maxSpeed, junction = None):
        super(Edge, self).__init__()
        self.uid = uid
        self.length = length
        self.maxSpeed = maxSpeed
        self.junction = junction
        self.lanes = []
        self.laneChanger = LaneChanger()

    ##
    # Add a lane to the edge
    # @param uid	The lane's unique identifier
    ##
    def addLane(self, uid):
        newLane = Lane(uid, self)
        self.lanes.append(newLane)
        self.laneChanger.addLane(newLane)

    ##
    # runLane
    ##
    def runLanes(self):
        #Figure out new velocities/positions of cars
        for lane in self.lanes:
            lane.planMovements()
        #Now that we know where cars are moving, we can plan merging
        self.laneChanger.planMovements()
        #Lets make all the moves now
        for lane in self.lanes:
            lane.executeMovements()
        self.laneChanger.executeMovements()

    ##
    # addVehicle
    # Add a vehicle that is coming from a junction
    # @param vehicle The vehicle to add
    ##
    def addVehicle(self, vehicle):
        self.lanes[ len(self.lanes) - 1 ].addVehicle( vehicle )

    ##
    # removeVehicle
    # Ensure a vehicle is removed from the lane lists
    # @param vehicle The vehicle to remove
    ##
    def removeVehicle(self, vehicle):
        for lane in self.lanes:
            lane.removeVehicle(vehicle)