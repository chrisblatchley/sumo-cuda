#include "lane.h"

/**
Constructor for Lane object
@param uid		The name or unique identifier of this lane
@param edge	A pointer to the edge to which this lane belongs
*/
Lane::Lane(string uid, Edge* edge)
{
	_uid = uid;
	_edge = edge;
}

/**
Call the planMove method for all vehicles belonging to this lane
*/
void Lane::planMovements()
{
	//Pointer used for passing the vehicle ahead
	Vehicle* predecessor = NULL;
	//The clear distance in front of a vehicle
	float distance;
	for ( vector<Vehicle*>::iterator it = _vehicles.begin(); it != _vehicles.end(); it++ )
	{
		if( predecessor == NULL )
		{
			//We don't have anyone in front of us, pass the distance to the end of the edge.
			distance = _edge->getLength() - ( *it )->getPosition();
		}else{
			//We have a car in front of us, get the distance between us.
			distance = predecessor->getPosition() - ( *it )->getPosition();
		}
		//Pass the information along to the car to plan
		( *it )->planMove( predecessor, distance ); //Call planMovements on the vehicle 
	}
}

/**
Call the executeMove method for all vehicles belonging to this lane
*/
void Lane::executeMovements()
{
	for ( vector<Vehicle*>::iterator it = _vehicles.begin(); it != _vehicles.end(); it++ )
	{
		//Perform the execution of the previously planned movement.
		( *it )->executeMove();
	}
}

/**
Add a vehicle to the lane
@param vehicle		The vehicle to add
@param beginning	Indicator as to whether the vehicle can simply be added to beginning of lane
*/
void Lane::addVehicle(Vehicle* vehicle, bool beginning = false)
{
	if ( beginning == true )
	{
		//We are at the start of the lane, so we'll just push the vehicle to the beginning of the vector
		_vehicles.push_back(vehicle);
	}else{
		//Find the correct location within the vehicle vector to place us
		for ( vector<Vehicle*>::iterator it = _vehicles.begin(); it != _vehicles.end(); it++ )
		{
			if ( next( it ) == _vehicles.end() )
			{
				//We are at the last element of the vector, so just push the vehicle to the back
				_vehicles.push_back(vehicle);
				break;
			}
			if ( ( vehicle->getPosition() > ( *it )->getPosition() ) && ( vehicle->getPosition() < (*next( it ))->getPosition() ) )
			{
				//The next slot is where we are supposed to fit, so lets go there
				_vehicles.insert( next( it ), vehicle );
				break;
			}
		}
	}
}

/**
Remove a vehicle from the lane
@param vehicle	The vehicle to find and remove from the lane
*/
void Lane::removeVehicle(Vehicle* vehicle)
{
	for ( vector<Vehicle*>::iterator it = _vehicles.begin(); it != _vehicles.end(); it++ )
	{
		if ( *it == vehicle )
		{
			//We found it, remove it from vehicles
			_vehicles.erase( it );
			break;
		}
	}
}

/**
Destructor of Lane object
*/
Lane::~Lane(void)
{
}
