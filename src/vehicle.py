##
# @file: vehicle.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Sun, Jan 5, 2014
# @version: 0.1
# ##
# Vehicle object implementation.
##

class Vehicle(object):
    """Vehicle Object to simulate a running Vehicle in a road network.py."""

    ##
    # Contructor for Vehicle
    #
    # @param route	route for vehicle to take
    # @param style	the vehicle's type
    # @param speed	max speed a vehicle will drive
    # @return Initialized Vehicle object
    ##
    def __init__(self, route, style):
        super(Vehicle, self).__init__()
        self.route = route
        self.style = style
        self.currSpeed = 0
        self.pos = 0
        self.nextPos = 0
        self.currEdge = self.route.begin()

    ##
    # enterLane
    # @param lane   The lane being entered into
    ##
    def enterLane(self, lane):
        self.pos = 0
        self.currEdge = lane.edge

    ##
    # planMove
    # @brief public method called on each running vehicle
    #
    # @param pred	the vehicle that is infront
    # @param distance	the distance a vehicle is ahead
    ##
    def planMove(self, pred, distance):
        if not pred:
            distanceToStop = distance
        else:
            distanceToStop = self.currEdge.length - self.pos
        approachingStop = distanceToStop < 200  # Braking distance in meters

        #find acceleration factor
        if approachingStop or (pred.currSpeed < self.currSpeed and distance < self.style["length"] * 2):
            accelFactor = -2.5
        elif self.currSpeed < self.speed:
            accelFactor = 2.5
        else:
            accelFactor = 0

        proposedNewPosition = self.pos + (self.speed + accelFactor)

        self.nextPos = proposedNewPosition
        print("Pos: ", self.pos)

    ##
    # executeMove
    # @brief executes the move planned by planMove
    ##
    def executeMove(self):
        self.pos = self.nextPos
        self.nextPos = self.pos
