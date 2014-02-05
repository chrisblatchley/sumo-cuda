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
		self.pos   = 0
		self.currEdge = self.route.begin()

	##
	# isOnRoad
	# @brief true if vehicle is driving rather than waiting
	##
	def isOnRoad(self):
		return True

	##
	# hasArrived
	# @brief true if the vehicle is at the final position
	##
	def hasArrived(self):
		pass

	# ##
	# # _planMove
	# # @brief This method does the heavy lifting for moving a vehicle
	# # 
	# # @param pred 	The vehicle's predecessor
	# ##
	# def _planMove(self, pred):
	# 	pass

	# ##
	# # _executeMove
	# # @brief does the moving execution 
	# ##
	# def _executeMove(self):
	# 	pass


	##
	# planMove
	# @brief public method called on each running vehicle
	# 
	# @param pred	the vehicle that is infront
	# @param lengthsInFront	the lengths that a vehicle is ahead
	##
	def planMove(self, pred, lengthsInFront):
		# self._planMove(pred)
		length = self.style.length
		
		

	##
	# executeMove
	# @brief executes the move planned by planMove
	##
	def executeMove(self):
		pass
