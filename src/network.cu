/**
 * @file: network.cu
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Network object implementation
 */
#pragma once
#include "network.cuh"

/**
 * Network Object Constructor
 */
Network::Network(int maxTime)
{
	Network::maxTime = maxTime;
}

/**
 * Network object desctructor
 */
Network::~Network()
{
}

/**
 * runSimulation
 * Runs the main simulation loop for the number of timesteps. Default 1 hour
 */
void Network::runSimulation()
{
    while(timeStep < maxTime)
    {
        vehicleController->refreshTimestep(timeStep);

		for ( thrust::host_vector<Edge*>::iterator it = edges.begin(); it != edges.end(); it++ )
		{
			(*it)->runLanes();
		}

        for ( thrust::host_vector<Junction*>::iterator it = junctions.begin(); it != junctions.end(); it++ )
		{
			(*it)->runTimestep();
		}

        ++timeStep;
    }
}
