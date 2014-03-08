/**
 * @file: network.cpp
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Network implementation
 */

 #include "network.h"

/**
 * Network Object Constructor
 */
Network::Network(int maxTime) : maxTime(maxTime);

/**
 * Network object desctructor
 */
Network::~Network();

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

        for (int junctionIdx = 0; junctionIdx < junL; ++junctionIdx)
        {
            junctions[junctionIdx]->runTimestep();
        }

        ++timeStep;
    }
}
