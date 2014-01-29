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
	# @return	Initialized Lane object
	##
	def __init__(self, id, maxSpeed, length):
		super(VehicleControl, self).__init__()
		self.vehicles = []
		self.id = id
		self.maxSpeed = maxSpeed
		self.length = length

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
	# Process vehicle movements for the lane
	# 
	##
	def processMove(self):
		pass
