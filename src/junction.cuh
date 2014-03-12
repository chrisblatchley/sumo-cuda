/**
 * @file: junction.cuh
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Junction Header
 */

#pragma once
#include <thrust/host_vector.h>
#include "vehicle.cuh"

class Vehicle;

class Junction
{
	public:
		/**
		An enumeration class for different types of junction logic
		*/
		enum Shape { Throughway, AllStop };

		/**
		Constructor for Junction object
		@param shape	The style of junction logic this junction performs
		*/
		Junction( Junction::Shape shape );

		/**
		Perform the junction logic for a timestep
		*/
		void runTimestep();

		/**
		Add a vehicle to the junction's queue
		@param vehicle	The vehicle to add
		*/
		void queueVehicle( Vehicle* vehicle );

		/**
		Destructor for the junction object
		*/
		~Junction( void );

		//The shape of the junction
		Shape shape;

		//The waiting queue for the junction
		thrust::host_vector< Vehicle * > waitQueue;
};

