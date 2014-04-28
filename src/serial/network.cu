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
Network::Network(int timeStep, int maxTime)
{
	this->maxTime = maxTime;
    this->timeStep = timeStep;
    vehicleController = new VehicleControl();
	edges = thrust::host_vector<Edge*>();
	junctions = thrust::host_vector<Junction*>();
	routes = thrust::host_vector<Route*>();
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
	edges.push_back( new Edge( length, maxSpeed, junction ) );
    return edges.back();
}

/**
 * addJunction
 * @param shape Shape of the junctions
 */
Junction * Network::addJunction( Junction::Shape shape)
{
    junctions.push_back( new Junction( shape ) );
    return junctions.back();
}

/**
 * addRoute
 */
Route * Network::addRoute()
{
    routes.push_back( new Route() );
    return routes.back();
}

/**
 * runSimulation
 * Runs the main simulation loop for the number of timesteps. Default 1 hour
 */
void Network::runSimulation()
{
    while(timeStep < maxTime)
    {
        //Start JSON step object
        std::cout << "{";

        //Current timestep JSON property
        std::cout << "\"step\":" << timeStep << ",";

        vehicleController->refreshTimestep(timeStep);

        std::cout << "\"vehicles\": [";
		for ( thrust::host_vector<Edge*>::iterator it = edges.begin(); it != edges.end(); it++ )
		{
			(*it)->runLanes();
		}
        std::cout << "]}," << std::endl;

        for ( thrust::host_vector<Junction*>::iterator it = junctions.begin(); it != junctions.end(); it++ )
		{
			(*it)->runTimestep();
		}

        ++timeStep;
    }
}
