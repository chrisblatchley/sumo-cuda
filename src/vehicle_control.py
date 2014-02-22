##
# @file vehicle_control.py
# @author Chris Blatchley
# @author Thad Bond
# @date Tues, Jan 7, 2014
# @version 0.1
# ##
# Vehicle controller object implementation.
##

from vehicle import Vehicle
from edge import Edge

class VehicleControl(object):
    """VehicleControl is responsible for building and deleting cars"""

    ##
    # Constructor for VehicleControl
    #
    # @return	Initialized VehicleControl object
    ##
    def __init__(self):
        super(VehicleControl, self).__init__()
        self.vehicles = []
        self.runningVehicles = 0
        self.endedVehicles = 0
        self.discardedVehicles = 0
        self.collisions = 0
        self.teleports = 0

    ##
    # buildVehicle	Builds a vehicle
    #
    # @param route	The vehicle route
    # @param style	The vehicle style
    def buildVehicle(self, route, style):
        print "building vehicle with route", route
        newVehicle = Vehicle(route, style)
        return newVehicle

    ##
    # Add vehicle to structure if non-existent
    #
    # @param uid	String uid for vehicle
    # @param vehicle 	Vehicle object to insert
    def addVehicle(self, vehicle):
        if vehicle not in self.vehicles:
            print "adding vehicle to structure"
            self.vehicles.append(vehicle)
            edge = vehicle.route.begin()
            edge.addVehicle(vehicle)
            return True
        return False


    ##
    # Get a vehicle from the data structure
    #
    # @param uid	Vehicle uid
    ##
    def getVehicle(self, vehicle):
        if vehicle in self.vehicles:
            return vehicle
        else:
            None

    ##
    # Delete a vehicle from the data structure
    #
    # @param vehicle 	The vehicle to discard
    # @param discard	Should discard the vehicle, false is default
    ##
    def deleteVehicle(self, vehicle, discard=False):
        print "Deleting vehicle"
        self.endedVehicles = self.endedVehicles + 1
        self.discardedVehicles = self.discardedVehicles + 1
        self.vehicles.remove(vehicle)
        vehicle.currEdge.removeVehicle(vehicle)


    ##
    # refreshTimestep
    ##
    def refreshTimestep(self):
        for vehicle in self.vehicles:
            if vehicle.currEdge is vehicle.route.end():
                #The vehicle is on the last edge of their route
                if vehicle.pos > vehicle.route.end().length - 10: #Are we within a buffer zone of the end of the edge?
                    print "Removing vehicle from simulation"
                    self.deleteVehicle(vehicle)