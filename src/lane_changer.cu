/**
 * @file: lane_changer.cu
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Lane Changer Inplementation
 */

#pragma once
#include "lane_changer.cuh"

/**
 * Lane changer constructor
 * @param lanes	A pointer to the lanes vector from the parent edge
 */
LaneChanger::LaneChanger(thrust::host_vector<Lane>* lanes)
{
	LaneChanger::lanes = lanes;
}

/**
 * Plan lane changes on this particular edge
 */
void LaneChanger::planMovements()
{
	//Loop through all aggresively changing vehicles
	for ( thrust::host_vector<Vehicle*>::iterator it = accelerateList.begin(); it != accelerateList.end(); it++ )
	{
		//Check for available space in the higher priority lane
	}

	//Loop through all defensively changing vehicles
	for ( thrust::host_vector<Vehicle*>::iterator it = decelerateList.begin(); it != decelerateList.end(); it++ )
	{
		//Check for available space in the lower priority lane
	}
}

/**
 * Execute the previously planned lane changes
 */
void LaneChanger::executeMovements()
{

}

/**
 * Request a lane change for a specific vehicle
 * @param vehicle 		The vehicle which wants to change lanes
 * @param accelerate	Boolean value representing whether the vehicle wants to accelerate or decelerate
 */
void LaneChanger::requestChange(Vehicle* vehicle, bool accellerate)
{
	if(accellerate)
	{
		accelerateList.push_back(vehicle);
	}else{
		decelerateList.push_back(vehicle);
	}
}

/**
 * LaneChanger Object Destructor
 */
LaneChanger::~LaneChanger(void)
{
}
