/**
 * @file: lane.cu
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Lane implementation
 */

#pragma once
#include "lane.cuh"

/**
Constructor for Lane object
@param uid		The name or unique identifier of this lane
@param edge	A pointer to the edge to which this lane belongs
*/
Lane::Lane(Edge* edge)
{
	Lane::edge = edge;
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
	for ( thrust::host_vector<Vehicle*>::iterator it = vehicles.begin(); it != vehicles.end(); it++ )
	{
		if( predecessor == NULL )
		{
			//We don't have anyone in front of us, pass the distance to the end of the edge.
			distance = edge->length - ( *it )->pos;
		}else{
			//We have a car in front of us, get the distance between us.
			distance = predecessor->pos - ( *it )->pos;
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
	for ( thrust::host_vector<Vehicle*>::iterator it = vehicles.begin(); it != vehicles.end(); it++ )
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
		vehicles.push_back(vehicle);
	}else{
		//Find the correct location within the vehicle vector to place us
		for ( thrust::host_vector<Vehicle*>::iterator it = vehicles.begin(); it != vehicles.end(); it++ )
		{
			if ( next( it ) == vehicles.end() )
			{
				//We are at the last element of the vector, so just push the vehicle to the back
				vehicles.push_back(vehicle);
				break;
			}
			if ( ( vehicle->pos > ( *it )->pos ) && ( vehicle->pos < (*next( it ))->pos ) )
			{
				//The next slot is where we are supposed to fit, so lets go there
				vehicles.insert( next( it ), vehicle );
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
	for ( thrust::host_vector<Vehicle*>::iterator it = vehicles.begin(); it != vehicles.end(); it++ )
	{
		if ( *it == vehicle )
		{
			//We found it, remove it from vehicles
			vehicles.erase( it );
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
