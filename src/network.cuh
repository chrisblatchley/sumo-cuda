/**
 * @file: network.cuh
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Network header file
 */
#pragma once
#include "edge.cuh"
#include "junction.cuh"
#include "route.cuh"
#include "vehicle_control.cuh"

class Network
{
public:
    
    // Class constructor and destructor
    Network(int maxTime);
    ~Network();

    /**
     * runSimulation
     * Runs the main loop of the simulation
     */
    void runSimulation();
    
    
    // edges : Pointer to array of edges
    Edge * edges;
    // edgesLen : Integer length of edges array
    int edgesLen;
    
    // junctions : Pointer to array of junctions
    Junction * junctions;
    // junctionsLen : Integer length of junctions array
    int junctionsLen;

    // routes : Pointer to array of routes
    Route * routes;
    // routesLen : Integer length of routes array
    int routesLen;

    // timeStep : Integer representing the current timestep of the simulation.
    //            Measured in SECONDS
    int timeStep;

    // maxTime : Integer value for the maximum number of seconds a simulation will run
    int maxTime;

    // vehicleController : Pointer to the vehicle control class to build vehicles
    VehicleControl * vehicleController;
};
