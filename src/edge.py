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
	# @param id 	string identification
	# @param numericalID	Numerical identification number
	# @param function		Basic type of the edge
	# @param streetName		Street name of edge
	##
	def __init__(self, id, numericalID, function, streetName):
		super(Edge, self).__init__()
		self.id = id
		self.numericalID = numericalID
		self.function = function
		self.streetName = streetName
		self.lanes = 0
		self.laneChanger = none
		self.isRotary = false
