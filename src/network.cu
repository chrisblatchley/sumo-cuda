/**
 * @file: network.cu
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Network object implementation
 */
// #pragma once
#include <cstdio>
#include "network.cuh"

/**
 * Network Object Constructor
 */
Network::Network(int maxTime)
{
	this->maxTime = maxTime;
    timeStep = 0;
    vehicleController = new VehicleControl();
}

/**
 * Network object desctructor
 */
Network::~Network()
{
}

/**
 * addEdge
 * @param length    Length of edge in meters
 * @param maxSpeed  Max speed on edge in meters/sec
 * @param junction  Terminal junction
 */
Edge * Network::addEdge( float length, float maxSpeed, Junction *junction )
{
    edges.push_back( Edge( length, maxSpeed, junction ) );
    return &edges.back();
}

/**
 * addJunction
 * @param shape Shape of the junctions
 */
Junction * Network::addJunction( Junction::Shape shape)
{
    junctions.push_back( Junction( shape ) );
    return &junctions.back();
}

/**
 * addRoute
 */
Route * Network::addRoute()
{
    routes.push_back( Route() );
    return &routes.back();
}

/**
 * runSimulation
 * Runs the main simulation loop for the number of timesteps. Default 1 hour
 */
void Network::runSimulation()
{
    while(timeStep < maxTime)
    {
        printf("\nTime: %d\n", timeStep);

        vehicleController->refreshTimestep(timeStep);

		for ( thrust::host_vector<Edge>::iterator it = edges.begin(); it != edges.end(); it++ )
		{
			(*it).runLanes();
		}

        for ( thrust::host_vector<Junction>::iterator it = junctions.begin(); it != junctions.end(); it++ )
		{
			(*it).runTimestep();
		}

        ++timeStep;
    }
}
