##
# @file: vehicle.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Mon, Feb 24, 2014
# @version: 0.2
# ##
# Vehicle object implementation.
##

from debug import debug

class Vehicle(object):
    """Vehicle Object to simulate a running Vehicle in a road network.py."""

    ##
    # Class Constants
    ##
    ACCEL_FACTOR = 5.0
    CRUISE_ACCEL_FACTOR = 0.0
    WITHIN_STOP_DISTANCE = 100.0
    MIN_CAR_LENGTHS_IN_FRONT = 2

    ##
    # Contructor for Vehicle
    #
    # @param route  route for vehicle to take
    # @param style  the vehicle's type
    # @param speed  max speed a vehicle will drive
    # @return Initialized Vehicle object
    ##
    def __init__(self, route, style, depart):
        super(Vehicle, self).__init__()
        self.route = route
        self.style = style
        self.currSpeed = 0
        self.pos = 0
        self.nextPos = 0
        self.currEdge = self.route.begin()
        self.depart = depart

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
    # @param pred   the vehicle that is infront
    # @param distance   the distance a vehicle is ahead 
    ##
    def planMove(self, pred, distance):

        # Find distance to stop
        distanceToStop      = self.currEdge.length - self.pos
        timeToStop          = self.currSpeed / self.ACCEL_FACTOR
        stoppingDistance    = timeToStop * (timeToStop + 1) * self.currSpeed / 2

        # Calculate predicates
        approachingStop     = distanceToStop < stoppingDistance
        approchingPred      = pred and pred.currSpeed <= self.currSpeed
        predIsSlower        = pred and pred.style["speed"] < self.style["speed"]
        withinCarBuffer     = distance <= self.style["length"] * self.MIN_CAR_LENGTHS_IN_FRONT
        canStopNow          = self.currSpeed <= self.ACCEL_FACTOR
        wantsToAccel        = self.currSpeed < self.style["speed"]

        # find acceleration factor
        if approachingStop and not canStopNow or (approchingPred and approchingPred):
            if predIsSlower:
                accelFactor = pred.currSpeed - self.currSpeed
            else:
                accelFactor = -1 * self.ACCEL_FACTOR
        elif wantsToAccel and not approachingStop:
            accelFactor = self.ACCEL_FACTOR
        else:
            accelFactor = self.CRUISE_ACCEL_FACTOR

        # Update speed and set next position
        self.currSpeed = self.currSpeed + accelFactor
        proposedNewPosition = self.pos + self.currSpeed

        # Update next position
        self.nextPos = proposedNewPosition

        # Get vehicle position at timestep
        debug("Vehicle: ", str(id(self))[-4:])
        debug("\tPos: ", self.pos, " Speed: ", self.currSpeed)
        debug()

    ##
    # executeMove
    # @brief executes the move planned by planMove
    ##
    def executeMove(self):
        self.pos = self.nextPos
        self.nextPos = self.pos
        assert self.pos >= 0, "Vehicle position is negative!"
        assert self.pos <= self.currEdge.length, "Vehicle position is beyond edge!"
