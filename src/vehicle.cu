/**
 * @file: vehicle.cpp
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Vehicle implementation
 */

#pragma once
#include "vehicle.cuh"
#include "route.cuh"

Vehicle::Vehicle( Route* route, Vehicle::Style style, int depart )
{
	Vehicle::route = route;
	Vehicle::style = style;
	Vehicle::depart = depart;
}

/**
 * Logic to occur when the vehicle enters a new lane
 * @param lane The lane being entered
 */
void Vehicle::enterLane(Lane *lane)
{
    pos = 0;
    currEdge = lane->edge;
}

/**
 * Called on each vehicle to plan the next move
 * @param pred     The vehicle infront of this one
 * @param distance The distance between this vehicle and it's predecessor
 */
void Vehicle::planMove(Vehicle* pred, float distance)
{
    return;
}

/**
 * Carry out the movement planned in planMove
 */
void Vehicle::executeMove()
{
    pos = nextPos;
}
