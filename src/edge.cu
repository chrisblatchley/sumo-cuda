/**
 * @file: edge.cuh
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Edge implementation
 */

#pragma once
#include "edge.cuh"

/**
Constructor for Edge object
@param length	The length of the edge
@param maxSpeed The speed limit of the edge
@param junction The junction at which the edge terminated
*/
Edge::Edge(float length, float maxSpeed, Junction *junction)
{
		Edge::length = length;
		Edge::maxSpeed = maxSpeed;
		Edge::junction = junction;
}

Edge::~Edge()
{}

/**
 * runLanes
 * Runs a timestep for the lanes in an edge
 */
void Edge::runLanes()
{

	for ( thrust::host_vector<Lane*>::iterator it = lanes.begin(); it != lanes.end(); it++ )
	{
		(*it)->planMovements();
	}

    laneChanger->planMovements();

    for ( thrust::host_vector<Lane*>::iterator it = lanes.begin(); it != lanes.end(); it++ )
	{
		(*it)->executeMovements();
	}
}

/**
 * addVehicle
 * @param vehicle   Vehicle to add to lane
 * @param lane      Lane to add vehicle to
 * @return          Boolean value if vehicle can be added
 */
bool Edge::addVehicle(Vehicle * vehicle, int lane = 0)
{
    return true;
}
