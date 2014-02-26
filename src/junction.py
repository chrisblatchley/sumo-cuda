##
# @file: junction.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Sun, Feb 23, 2014
# @version: 0.2
# ##
# Junction object implementation.
##

class Junction(object):
    """Junction object to control behavior in edge junctions"""

    ##
    # Junction Constructor
    # @param id		The string identification
    # @param shape	The shape of the junction
    # @return 	Initialized Junction Object
    ##
    def __init__(self, uid, shape):
        super(Junction, self).__init__()
        self.uid = uid
        self.shape = shape
        self.queue = [] #The vehicles waiting to pass through

    ##
    # runTimestep
    ##
    def runTimestep(self):
        if self.shape is "allstop":
            if self.queue: #We have at least something in the queue
                vehicle = self.queue[0]
                newEdge = vehicle.route.getNextEdge(vehicle.currEdge) #Get the next edge for the vehicle
                print("Junction ", self.uid, " is passing a vehicle to edge ", newEdge.uid)
                newEdge.addVehicle(vehicle) #Add the vehicle to the new edge
                vehicle.currSpeed = 0 #Make the vehicle start at 0 speed from stop
                self.queue.remove(vehicle) #The vehicle has passed through, get rid of it

    ##
    # addToQueue
    # @param vehicle The vehicle to add to the queue
    ##
    def addToQueue(self, vehicle):
        #Add it to our queue list
        self.queue.append(vehicle)
        #Remove the vehicle from its previous edge now that its done there
        vehicle.currEdge.removeVehicle(vehicle)
