##
# @file: lane_changer.py
# @author: Chris Blatchley
# @author: Thad Bond
# @date: Mon, Feb 24, 2014
# @version: 0.2
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
    def __init__(self):
        super(LaneChanger, self).__init__()
        self.lanes = []

    ##
    # Add Lanes from edge
    #
    # @param lane   Lane to add to the changer object
    ##
    def addLane(self, lane):
        self.lanes.append(lane)

    ##
    # planMovements
    # Plan movments operation to determine if lane changes can be made
    ##
    def planMovements(self):
        pass

    ##
    # executeMovements
    # Execute the planned lane changes
    ##
    def executeMovements(self):
        pass
