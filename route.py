##
# @file: route.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Sun, Jan 5, 2014
# @version: 0.1
# ##
# Route Object describing a path of edges
##

class Route(object):
	"""A Route on which a vehicle travels"""

	##
	# Route contructor
	# @param id		Identification string
	# @param edges	Ordered list of edges in route
	# @param isPermanent	True if the route persists
	# @return 		Initialized Route Object
	##
	def __init__(self, id, edges, isPermanent):
		super(Route, self).__init__()
		self.id = id
		self.edges = edges
		self.isPermanent = isPermanent

	def begin(self):
		pass

	def end(self):
		pass