##
# @file: vehicle.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Sun, Jan 5, 2014
# @version: 0.1
# ##
# Vehicle object implementation.
##

class Vehicle(object):

	"""Vehicle Object to simulate a running Vehicle in a road network."""

	##
	# Contructor for Vehicle
	# 
	# @param route	route for vehicle to take
	# @param style	the vehicle's type
	# @param speed	max speed a vehicle will drive
	# @return Initialized Vehicle object
	##
	def __init__(self, route, style, speed):
		super(Vehicle, self).__init__()
		self.route = route
		self.style = style
		self.speed = speed
		self.currEdge = self.route.begin()

	def isOnRoad(self):
		return True

	def planMove(self, predecessor, lengthsInFront):
		pass

	def executeMove(self):
		pass
