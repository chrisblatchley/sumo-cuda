#include "junction.h"
using namespace std;

/**
Constructor for Junction object
@param uid		The name or unique identifier of this junction
@param shape	The style of junction logic this junction performs
*/
Junction::Junction( string uid, Shape shape )
{
	_uid = uid;
	_shape = shape;
}

/**
Perform the junction logic for a timestep
*/
void Junction::runTimestep()
{
	switch ( _shape )
	{
		case Shape::Throughway:
			while ( !_waitQueue.empty() )
			{
				_waitQueue.front(); //TODO: SEND TO NEXT EDGE ON ROUTE
				_waitQueue.pop();
			}
			break;
		case Shape::AllStop:
			_waitQueue.front(); //TODO: SEND TO NEXT EDGE ON ROUTE
			_waitQueue.pop();
			break;
	}
}

/**
Add a vehicle to the junction's queue
@param vehicle	The vehicle to add
*/
void Junction::queueVehicle( Vehicle* vehicle )
{
	//Add the vehicle to the wait queue
	_waitQueue.push( vehicle );
}

/**
Destructor for the junction object
*/
Junction::~Junction( void )
{
}
