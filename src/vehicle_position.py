##
# @file: vehicle_position.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Fri, Jan 31, 2014
# @version: 0.1
# ##
# Object to contain vehicle position within a lane
##

class VehiclePosition(object):
	"""VehiclePosition is an object that stores a vehicle within a lane"""

	##
	# Constructor for VehiclePosition
	#
	# @param vehicle 	The vehicle that is within the lane
	# @param position	The position at which the vehicle is currently located
	def __init__(self, vehicle, position):
		self.vehicle = vehicle
		self.position = position

	##
	# Vehicle accessor method
	##
	def getVehicle(self):
		return self.vehicle

	##
	# Position accessor method
	##
	def getPosition(self):
		return position

	##
	# Position mutator method
	##
	def setPosition(self, position):
		self.position = position