/**
 * @file: lane.cu
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Lane implementation
 */

// #pragma once
#include "lane.cuh"

/**
Constructor for Lane object
@param uid		The name or unique identifier of this lane
@param edge	A pointer to the edge to which this lane belongs
*/
Lane::Lane(Edge * edge)
{
	this->edge = edge;
}

/**
Call the planMove method for all vehicles belonging to this lane
*/
void Lane::planMovements()
{
	//Pointer used for passing the vehicle ahead
	
	thrust::host_vector<Vehicle> copy_vehicles;

	thrust::host_vector<Vehicle*>::iterator vit = vehicles.begin();

	while(vit != vehicles.end())
	{
		Vehicle copy = **vit;
		copy_vehicles.push_back(copy);
		++vit;
	}

	thrust::device_vector<Vehicle> d_vehicles;
	d_vehicles = copy_vehicles;

	thrust::device_vector<Vehicle> d_predecessors(vehicles.size());

	Vehicle::Style dummyStyle = {0.0, 999999.00};
	Vehicle dummyPred(NULL, dummyStyle, 0);
	dummyPred.currSpeed = 999999.00;

	d_predecessors[0] = dummyPred; //First in lane is null

	thrust::copy(d_vehicles.begin(), d_vehicles.end(), d_predecessors.begin()++);

	planMoveFunctor planMove(edge->length);
	thrust::transform( d_predecessors.begin(), d_predecessors.end(), d_vehicles.begin(), d_vehicles.begin(), planMove );
	
	copy_vehicles = d_vehicles;

	// Reset the simulation vehicles with results from CUDA transformation.
	vit = vehicles.begin();
	thrust::host_vector<Vehicle>::iterator lvit = copy_vehicles.begin();

	while(vit != vehicles.end())
	{
		(*vit)->nextPos = (*lvit).nextPos;
		(*vit)->currSpeed = (*lvit).currSpeed;
		++vit;
		++lvit;
	}

	// //The clear distance in front of a vehicle
	// float distance;
	// for ( thrust::host_vector<Vehicle*>::iterator it = vehicles.begin(); it != vehicles.end(); it++ )
	// {
	// 	if( predecessor == NULL )
	// 	{
	// 		//We don't have anyone in front of us, pass the distance to the end of the edge.
	// 		distance = edge->length - ( *it )->pos;
	// 	}else{
	// 		//We have a car in front of us, get the distance between us.
	// 		distance = predecessor->pos - ( *it )->pos;
	// 	}
	// 	//Pass the information along to the car to plan
	// 	( *it )->planMove( predecessor, distance ); //Call planMovements on the vehicle 
	// }
}

/**
 * Destructor
 */
Lane::~Lane(void)
{}

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
bool Lane::addVehicle(Vehicle* vehicle, bool beginning = false)
{
	if ( beginning == true )
	{
		//We are at the start of the lane, so we'll just push the vehicle to the beginning of the vector
		if( vehicles.empty() || vehicles.back()->pos > 5 )
		{
			vehicles.push_back( vehicle );
			vehicle->enterLane( this );
			return true;
		}
		return false;
	}else{
		//Find the correct location within the vehicle vector to place us
		for ( thrust::host_vector<Vehicle*>::iterator it = vehicles.begin(); it != vehicles.end(); it++ )
		{
			if ( it+1 == vehicles.end() )
			{
				//We are at the last element of the vector, so just push the vehicle to the back
				vehicles.push_back(vehicle);
				return true;
			}
			if ( ( vehicle->pos > ( *it )->pos ) && ( vehicle->pos < (*it+1)->pos ) )
			{
				//The next slot is where we are supposed to fit, so lets go there
				vehicles.insert( it+1, vehicle );
				return true;
			}
		}
		return false;
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
