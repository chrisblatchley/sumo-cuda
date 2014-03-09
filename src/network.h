/**
 * @file: network.h
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Network header file
 */
#include "edge.h"
#include "junction.h"
#include "route.h"
using namespace std;

class Network
{
public:
    
    // Class constructor and destructor
    Network(int maxTime) : maxTime(maxTime);
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
