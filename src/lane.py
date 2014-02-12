##
# @file: lane.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Tue, Jan 28, 2014
# @version: 0.1
# ##
# Lane object for an edge
##

class Lane(object):
    """Lane is responsible for determining movement of vehicles on an edge"""

    ##
    # Constructor for Lane
    #
    # @param uid	The lane's id
    # @param edge	The edge this lane belongs to
    # @return	Initialized Lane object
    ##
    def __init__(self, uid, edge):
        super(Lane, self).__init__()
        self.vehicles = []
        self.uid = uid
        self.edge = edge

    ##
    # Send off relevant information to the vehicles in the lane to plan movement
    ##
    def planMovements(self):
        #Start off with the "first" vehicle being None, this lets the first car know
        #that there aren't any cars in front of it.
        predVehicle = None
        #For each vehicle in our lane
        for vehicle in self.vehicles:
            #If there are no cars in front, free space is the distance to end of lane
            #otherwise the free space is the pos of the predecessor minus our pos
            if predVehicle is None:
                freeSpace = self.edge.getLength() - vehicle.getPosition()
            else:
                freeSpace = predVehicle.getPosition() - vehicle.getPosition()
            #Send the information to the vehicle, then set it as the predecessor
            vehicle.planMove(predVehicle, freeSpace)
            predVehicle = vehicle

    ##
    # Execute the movements of all vehicles in the lane, updating their position
    ##
    def executeMovements(self):
        for vehicle in self.vehicles:
            #Executes the movement function within the vehicle
            #Also passes the vehicle position object so that the vehicle updates it appropriately
            vehicle.executeMove()

    ##
    # Check whether a lane merge can be done
    #
    # @param vehicle	Vehicle
    # @param fromLane	Lane from which the vehicle is merging
    # @return bool	Lane merge is valid?
    ##
    def checkMerge(self, vehicle, fromLane):
        pass

    ##
    # Merge a vehicle into the lane
    #
    # @param vehicle	Vehicle
    ##
    def mergeVehicle(self, vehicle):
        pass

    ##
    # Remove a vehicle from this lane that has merged or reached the end of the lane
    #
    # @param vehicle 	The vehicle to remove from the lane
    ##
    def removeVehicle(self, vehicle):
        self.vehicles.remove(vehicle)

	
