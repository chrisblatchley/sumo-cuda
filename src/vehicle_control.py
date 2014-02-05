##
# @file vehicle_control.py
# @author Chris Blatchley
# @author Thad Bond
# @date Tues, Jan 7, 2014
# @version 0.1
# ##
# Vehicle controller object implementation.
##

class VehicleControl(object):
	"""VehicleControl is responsible for building and deleting cars"""

	##
	# Constructor for VehicleControl
	# 
	# @return	Initialized VehicleControl object
	##
	def __init__(self):
		super(VehicleControl, self).__init__()
		self.loadedVehicles = []
		self.loadedVehicleNo = 0
		self.runningVehicleNo = 0
		self.endedVehicleNo
		self.discardedVehiclesNo = 0
		self.collisions = 0
		self.teleports = 0

	##
	# buildVehicle	Builds a vehicle
	# 
	# @param route	The vehicle route
	# @param style	The vehicle style
	def buildVehicle(self, route, style):
		self.loadedVehicleNo = self.loadedVehicleNo + 1
		newVehicle = new Vehicle(route, style, style.speed)
		return newVehicle

	##
	# Add vehicle to structure if non-existent
	# 
	# @param uid	String uid for vehicle
	# @param vehicle 	Vehicle object to insert
	def addVehicle(self, uid, vehicle):
		if uid not in self.loadedVehicles:
			self.loadedVehicles[uid] = vehicle
			return True
		return False


	##
	# Get a vehicle from the data structure
	# 
	# @param uid	Vehicle uid
	##
	def getVehicle(self, uid):
		return self.loadedVehicles[uid]

	##
	# Delete a vehicle from the data structure
	# 
	# @param vehicle 	The vehicle to discard
	# @param discard	Should discard the vehicle, false is default
	##
	def deleteVehicle(self, vehicle, discard = False):
		self.endedVehiclesNo = self.endedVehiclesNo + 1
		if discard:
			self.discardedVehicles = self.discardedVehicles + 1
		try:
			self.loadedVehicles.pop(vehicle.uid)
		except KeyError, e:
			print "Tried to remove a non-existent vehicle"


	##
	# addWaiting
	# 
	# @param edge	Edge to insert a waiting vehicle for
	# @param vehicle 	vehicle to add to waiting queue
	##
	def addWaiting(self, edge, vehicle):
		pass

	##
	# removeWaiting
	# 
	# @param edge 	Edge to remove waiting vehicle from
	# @param vehicle 	Vehicle to remove
	def removeWaiting(self, edge, vehicle):
		pass
