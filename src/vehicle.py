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
        if not pred:
            distanceToStop = distance
        else:
            distanceToStop = self.currEdge.length - self.pos

        approachingStop = distanceToStop < self.WITHIN_STOP_DISTANCE


        #find acceleration factor
        if (approachingStop and self.currSpeed > self.ACCEL_FACTOR ) or (pred and pred.currSpeed <= self.currSpeed and distance <= self.style["length"] * self.MIN_CAR_LENGTHS_IN_FRONT):
            if (pred and pred.style["speed"] < self.style["speed"]):
                #We are faster than the car in front of us, and within their buffer area
                accelFactor = self.CRUISE_ACCEL_FACTOR
                self.currSpeed = pred.currSpeed
                #Request a lane change if possible here
            else:
                accelFactor = -1 * self.ACCEL_FACTOR
        elif self.currSpeed < self.style["speed"]:
            accelFactor = self.ACCEL_FACTOR
        else:
            accelFactor = self.CRUISE_ACCEL_FACTOR

        # Update speed and position
        self.currSpeed = self.currSpeed + accelFactor
        proposedNewPosition = self.pos + self.currSpeed

        # Update next position
        self.nextPos = proposedNewPosition

    ##
    # executeMove
    # @brief executes the move planned by planMove
    ##
    def executeMove(self):
        self.pos = self.nextPos
        self.nextPos = self.pos
        debug("Pos: ", self.nextPos, " Speed: ", self.currSpeed)
        debug()
