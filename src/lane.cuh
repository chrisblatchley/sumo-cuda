#pragma once
#include <string>
#include <vector>
#include <thrust/host_vector.h>
#include "edge.cuh"
#include "vehicle.cuh"
using namespace std;

class Lane
{
	public:
		/**
		Constructor for Lane object
		@param uid		The name or unique identifier of this lane
		@param edge	A pointer to the edge to which this lane belongs
		*/
		Lane( string uid, Edge* edge );

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
		void addVehicle(Vehicle* vehicle, bool beginning);

		/**
		Remove a vehicle from the lane
		@param vehicle	The vehicle to find and remove from the lane
		*/
		void removeVehicle(Vehicle* vehicle);

		/**
		Destructor of Lane object
		*/
		~Lane( void );

		//Public properties

		//Name/Unique Identifier
		string uid;

		//Parent edge reference
		Edge* edge;

		//Our vehicle list
		thrust::host_vector<Vehicle*> vehicles;
};

