##
# @file: edge.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Sun, Jan 5, 2014
# @version: 0.1
# ##
# Edge object from one junction to another.
##

class Edge(object):
	"""Edge is a road"""

	##
	# Edge Contructor
	# @param uid 			unique string identification
	# @param numericalID	Numerical identification number
	# @param function		Basic type of the edge
	# @param streetName		Street name of edge
	# @param length			The length of the edge
	# @param maxSpeed		The maximum speed that may be traveled on the edge
	##
	def __init__(self, uid, function, length, maxSpeed):
		super(Edge, self).__init__()
		self.uid = uid
		self.function = function
		self.length = length
		self.maxSpeed = maxSpeed
		self.lanes = []
		self.laneChanger = none
		self.isRotary = false

	##
	# Add a lane to the edge
	# @param uid		The lane's unique identifier
	##
	def addlane(self, uid):
		newLane = Lane(uid, self)

	##
	# Once all lanes have been loaded for this edge, we can init the lane changer for it
	##
	def initChanger(self):
		self.laneChanger = LaneChanger(self.lanes)
