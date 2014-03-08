#pragma once
#include <string>
#include <vector>
#include "edge.h"
#include "vehicle.h"
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
	private:
		//Name/Unique Identifier
		string _uid;

		//Parent edge reference
		Edge* _edge;

		//Our vehicle list
		vector<Vehicle*> _vehicles;
};

