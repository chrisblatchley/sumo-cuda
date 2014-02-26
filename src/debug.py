##
# @file: vehicle.py
# @author: Chris Blatchley
# ##
# Debugging Utility functions and helpers
##

# DEBUGGING ELEMENTS
global DEBUG
DEBUG = True
# Debug function which will debug out relevant information
# if the DEBUG global variable is set to true only.
def debug(*args):
    if DEBUG: print(*args)
