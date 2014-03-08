#pragma once
#include <string>
#include <queue>
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
		Junction( string uid, Shape shape );

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

	private:
		//The shape of the junction
		Shape _shape;

		//Identifier of the junction
		string _uid;

		//The waiting queue for the junction
		queue< Vehicle * > _waitQueue;
};

