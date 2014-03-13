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

class Edge;
class Junction;
class Route;
class VehicleControl;

class Network
{
public:
    
    // Class constructor and destructor
    Network( int maxTime );
    ~Network();

    /**
     * runSimulation
     * Runs the main loop of the simulation
     */
    void runSimulation();

    /**
     * addEdge
     * @param length    Length of edge in meters
     * @param maxSpeed  Max speed on edge in meters/sec
     * @param junction  Terminal junction
     */
    Edge * addEdge( float length, float maxSpeed, Junction *junction );
    
    /**
     * addJunction
     * @param shape Shape of the junctions
     */
    Junction * addJunction( Junction::Shape shape);
    
    /**
     * addRoute
     */
    Route * addRoute();
    
    // edges : Pointer to array of edges
    thrust::host_vector<Edge> edges;
    
    // junctions : Pointer to array of junctions
    thrust::host_vector<Junction> junctions;

    // routes : Pointer to array of routes
    thrust::host_vector<Route> routes;

    // timeStep : Integer representing the current timestep of the simulation.
    //            Measured in SECONDS
    int timeStep;

    // maxTime : Integer value for the maximum number of seconds a simulation will run
    int maxTime;

    // vehicleController : Pointer to the vehicle control class to build vehicles
    VehicleControl * vehicleController;
};
