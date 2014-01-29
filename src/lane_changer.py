##
# @file: lane_changer.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Tue, Jan 28, 2014
# @version: 0.1
# ##
# LaneChanger for an edge
##

class LaneChanger(object):
	"""LaneChanger is responsible for coordinating between lanes and vehicles for lane changes"""

	##
	# Constructor for LaneChanger
	# 
	# @return	Initialized LaneChanger object
	##
	def __init__(self, lanes):
		super(LaneChanger, self).__init__()
		self.lanes = lanes

	##
	# checkNeededChanges	Checks if lanes/vehicles are in need of a lane change
	# 
	##
	def checkNeededChanges(self):
		pass

	##
	# performChange	Performs a lane change
	# 
	# @param fromLane	The originating lane
	# @param toLane	The destination lane
	# @param vehicle The vehicle to change lanes
	##
	def performChange(self, fromLane, toLane, vehicle):
		pass
