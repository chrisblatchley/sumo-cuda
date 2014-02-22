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

try:  # do not edit! added by PythonBreakpoints
    from ipdb import set_trace as _breakpoint
except ImportError:
    from pdb import set_trace as _breakpoint


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
        self.waiting = []
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
    def buildVehicle(self, route, style, depart):
        newVehicle = Vehicle(route, style, depart)
        return newVehicle

    ##
    # Add vehicle to structure if non-existent
    #
    # @param uid	String uid for vehicle
    # @param vehicle 	Vehicle object to insert
    def addVehicle(self, vehicle):
        self.vehicles.append(vehicle)
        edge = vehicle.route.begin()
        edge.addVehicle(vehicle)

    ##
    # queueVehicle
    # Add a vehicle object to a queue waitinig to be initialized
    # @param vehicle The vehicle to add to waiting queue
    ##
    def queueVehicle(self, vehicle):
        self.waiting.append(vehicle)

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
    # @param vehicle    The vehicle to discard
    # @param discard    Should discard the vehicle, false is default
    ##
    def deleteVehicle(self, vehicle, discard=False):
        print("Deleting vehicle")
        self.endedVehicles = self.endedVehicles + 1
        self.discardedVehicles = self.discardedVehicles + 1
        self.vehicles.remove(vehicle)
        vehicle.currEdge.removeVehicle(vehicle)


    ##
    # refreshTimestep
    ##
    def refreshTimestep(self, timeStep):
        for vehicle in self.vehicles:
            if vehicle.currEdge is vehicle.route.end():
                #The vehicle is on the last edge of their route
                if vehicle.pos > vehicle.route.end().length - 10: #Are we within a buffer zone of the end of the edge?
                    print "Removing vehicle from simulation"
                    self.deleteVehicle(vehicle)

        print "waiting queue:", self.waiting
        for vehicle in self.waiting:        
            if vehicle.depart <= timeStep:
                print "Vehicle:", vehicle
                self.waiting.remove(vehicle)
                self.addVehicle(vehicle)