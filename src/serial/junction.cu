/**
 * @file: junction.cu
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Junction implementation
 */

// #pragma once
#include "junction.cuh"

/**
Constructor for Junction object
@param shape	The style of junction logic this junction performs
*/
Junction::Junction( Junction::Shape shape )
{
	this->shape = shape;
}

/**
Perform the junction logic for a timestep
*/
void Junction::runTimestep()
{
	switch ( shape )
	{
		case Throughway:
			while ( !waitQueue.empty() )
			{
				//Retrieve the first vehicle from the waiting queue
				Vehicle * currentVehicle = waitQueue.front();
				//Send the vehicle to the next edge on its route
				currentVehicle->currEdge = currentVehicle->route->getNextEdge( currentVehicle->currEdge );
				//"Pop" the first element of the waiting queue
				waitQueue.erase( waitQueue.begin() );
			}
			break;
		case AllStop:
			if( waitQueue.empty() ) break;
			//Retrieve the first vehicle from the waiting queue
			Vehicle * currentVehicle = waitQueue.front();
			//Send the vehicle to the next edge on its route
			currentVehicle->currEdge = currentVehicle->route->getNextEdge( currentVehicle->currEdge );
			//"Pop" the first element of the waiting queue
			waitQueue.erase( waitQueue.begin() );
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
	waitQueue.push_back( vehicle );
}

/**
Destructor for the junction object
*/
Junction::~Junction( void )
{
}
