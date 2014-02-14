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
    def __init__(self, uid, edges, isPermanent):
        super(Route, self).__init__()
        self.uid = uid
        self.edges = edges
        self.isPermanent = isPermanent

    ##
    # getNextEdge
    # @param edge   The last edge that the vehicle resided in
    ## 
    def getNextEdge(self, edge):
        return self.edges[ self.edges.getIndex( edge ) + 1 ] #Gets the index for the passed edge, then returns the edge object for the next edge

    def begin(self):
        pass

    def end(self):
        pass
