/**
 * @file: vehicle.cu
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Vehicle object implementation
 */
// #pragma once
#include "vehicle.cuh"
#include "route.cuh"
#include <cstdio>
#include <sstream>
#include <string>

const float Vehicle::ACCEL_FACTOR = 5.0;
const float Vehicle::CRUISE_ACCEL = 0.0;
const int Vehicle::MIN_CAR_LENGTHS_IN_FRONT = 2;

/**
 * Class Constructor and Destructor
 */
__host__ __device__ Vehicle::Vehicle()
{
}

__host__ __device__ Vehicle::Vehicle( Route* route, Vehicle::Style style, int depart )
{
	this->route = route;
	this->style = style;
	this->depart = depart;
	//this->currEdge = route->begin();
	currSpeed = 0;
    pos = 0;
    nextPos = 0;
}

__host__ __device__ Vehicle::~Vehicle()
{
}

/**
 * Logic to occur when the vehicle enters a new lane
 * @param lane The lane being entered
 */
void Vehicle::enterLane(Lane *lane)
{
    pos = 0;
    nextPos = 0;
    currEdge = lane->edge;
}

/**
 * Carry out the movement planned in planMove
 */
void Vehicle::executeMove()
{
    pos = nextPos;
    const void * address = static_cast<const void*>(this);
    std::stringstream ss;
    ss << address;
    std::string name = ss.str();
    pos = nextPos;
    std::cout << "{ \"vehicle\": \"" << name << "\", \"position\": " << pos << " }";
    //Check if we are done with this edge
    if(pos >= currEdge->length)
    {
        currEdge->junction->queueVehicle(this);
        currEdge->removeVehicle(this);
    }
}

/**
 * Called on each vehicle to plan the next move
 * @param pred     The vehicle infront of this one
 * @param distance The distance between this vehicle and it's predecessor
 */
