##
# @file: junction.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Sun, Jan 5, 2014
# @version: 0.1
# ##
# Junction object implementation.
##

class Junction(object):
    """Junction object to control behavior in edge junctions"""

    ##
    # Junction Constructor
    # @param id		The string identification
    # @param postition	The position of the junction
    # @param shape	The shape of the junction
    # @return 	Initialized Junction Object
    ##
    def __init__(self, uid, position, shape):
        super(Junction, self).__init__()
        self.uid = uid
        self.position = position
        self.shape = shape
        self.queue = [] #The vehicles waiting to pass through

    ##
    # runTimestep
    ##
    def runTimestep(self):
        if self.shape = "throughway":
            for vehicle in self.queue:
                #Get vehicle route
                #edge.addVehicle(vehicle)
                self.queue.remove(vehicle) #The vehicle has passed through, get rid of it

    ##
    # addToQueue
    # @param vehicle The vehicle to add to the queue
    ##
    def addToQueue(self, vehicle):
        self.queue.append(vehicle)