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

        for (int edgeIdx = 0; edgeIdx < edgesLen; ++edgeIdx)
        {
            edges[edgeIdx]->runLanes();
        }

        for (int junctionIdx = 0; junctionIdx < junctionsLen; ++junctionIdx)
        {
            junctions[junctionIdx]->runTimestep();
        }

        ++timeStep;
    }
}
