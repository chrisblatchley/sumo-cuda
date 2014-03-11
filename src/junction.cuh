#pragma once
#include <string>
#include <queue>
#include <thrust/host_vector.h>
#include "vehicle.h"
class Junction
{
	public:
		/**
		An enumeration class for different types of junction logic
		*/
		static enum class Shape { Throughway, AllStop };

		/**
		Constructor for Junction object
		@param uid		The name or unique identifier of this junction
		@param shape	The style of junction logic this junction performs
		*/
		Junction( std::string uid, Shape shape );

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

		//Identifier of the junction
		std::string uid;

		//The waiting queue for the junction
		thrust::host_vector< Vehicle * > waitQueue;
};

