/**
 * @file: lane_changer.cuh
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Lane Changer Header
 */

#pragma once
#include <thrust/host_vector.h>
#include "vehicle.cuh"
#include "lane.cuh"
class Vehicle;
class Lane;
class LaneChanger
{
public:
	/**
	 * Lane changer constructor
	 * @param lanes	A pointer to the lanes vector from the parent edge
	 */
	LaneChanger(thrust::host_vector<Lane>* lanes);

	/**
	 * Plan lane changes on this particular edge
	 */
	void planMovements();

	/**
	 * Execute the previously planned lane changes
	 */
	void executeMovements();

	/**
	 * Request a lane change for a specific vehicle
	 * @param vehicle 		The vehicle which wants to change lanes
	 * @param accellerate	Boolean value representing whether the vehicle wants to accellerate or decelerate
	 */
	void requestChange(Vehicle* vehicle, bool accelerate);

	/**
	 * LaneChanger Object Destructor
	 */
	~LaneChanger(void);

	//Pointers to vehicles who would like to accellerate into a passing lane
	thrust::host_vector<Vehicle*> accelerateList;

	//Pointers to vehicles who can/want to decellerate into a normal lane
	thrust::host_vector<Vehicle*> decelerateList;

	//Pointer to the parent edge's lanes vector
	thrust::host_vector<Lane> * lanes;
};
