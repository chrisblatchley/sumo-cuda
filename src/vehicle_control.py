##
# @file vehicle_control.py
# @author Chris Blatchley
# @author Thad Bond
# @date Tues, Jan 7, 2014
# @version 0.1
# ##
# Vehicle controller object implementation.
##

from debug import debug
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
    # Add vehicle to list of running vehicles
    #
    # @param vehicle 	Vehicle object to insert
    # @return   boolean whether vehicle was successfully added
    def addVehicle(self, vehicle):
        edge = vehicle.route.begin()
        if edge.addVehicle(vehicle):
            self.vehicles.append(vehicle)
            return True
        return False

    ##
    # queueVehicle
    # Add a vehicle object to a queue waitinig to be initialized
    # @param vehicle The vehicle to add to waiting queue
    ##
    def queueVehicle(self, vehicle):
        self.waiting.append(vehicle)

    ##
    # Delete a vehicle from the data structure
    #
    # @param vehicle    The vehicle to discard
    # @param discard    Should discard the vehicle, false is default
    ##
    def deleteVehicle(self, vehicle, discard=False):
        self.endedVehicles = self.endedVehicles + 1
        self.discardedVehicles = self.discardedVehicles + 1
        self.vehicles.remove(vehicle)
        vehicle.currEdge.removeVehicle(vehicle)
        debug("ALERT: Deleted vehicle", str(id(vehicle))[-4:])


    ##
    # refreshTimestep
    ##
    def refreshTimestep(self, timeStep):

        # Add ready vehicles from waiting list
        toRemove = []
        for vehicle in self.waiting:
            debug("Vehicle in queue:", str(id(vehicle))[-4:], "departure:", vehicle.depart)
            if vehicle.depart <= timeStep:
                if self.addVehicle(vehicle):
                    toRemove.append(vehicle)
                    debug("\tALERT: Adding vehicle", str(id(vehicle))[-4:])
            debug()

        for vehicle in toRemove:
            self.waiting.remove(vehicle)

        # Remove vehicles from running list
        for vehicle in self.vehicles:
            if vehicle.currEdge is vehicle.route.end():
                #The vehicle is on the last edge of their route
                if vehicle.pos >= vehicle.route.end().length - vehicle.currSpeed: #Are we within a buffer zone of the end of the edge?
                    self.deleteVehicle(vehicle)
