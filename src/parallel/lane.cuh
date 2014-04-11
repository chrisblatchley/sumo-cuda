/**
 * @file: lane.cuh
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Lane header
 */

#pragma once
#include <thrust/host_vector.h>
#include "edge.cuh"
#include "vehicle.cuh"

class Edge;
class Vehicle;

class Lane
{
	public:
		/**
		Constructor for Lane object
		@param uid		The name or unique identifier of this lane
		@param edge	A pointer to the edge to which this lane belongs
		*/
		Lane( Edge* edge );

		/**
		Call the planMove method for all vehicles belonging to this lane
		*/
		void planMovements();

		/**
		Call the executeMove method for all vehicles belonging to this lane
		*/
		void executeMovements();

		/**
		Add a vehicle to the lane
		@param vehicle		The vehicle to add
		@param beginning	Indicator as to whether the vehicle can simply be added to beginning of lane
		*/
		bool addVehicle(Vehicle* vehicle, bool beginning);

		/**
		Remove a vehicle from the lane
		@param vehicle	The vehicle to find and remove from the lane
		*/
		void removeVehicle(Vehicle* vehicle);

		/**
		Destructor of Lane object
		*/
		~Lane( void );

		/**
		 * Public properties
		 */

		//Parent edge reference
		Edge * edge;

		//Our vehicle list
		thrust::host_vector<Vehicle*> vehicles;
};

