##
# @author: Chris Blatchley, Thaddeus Bond
##

class Car(object):
	"""Car Object to simulate a running car in a road network."""
	def __init__(self, destination, speed, length, width):
		super(Car, self).__init__()
		self.destination = destination
		self.speed = speed
		self.length = length
		self.width = width
	
	def honk(self):
		print "Beep Beep!"
		return