/**
 * @file: vehicle_control.cuh
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Vehicle Controller headers
 */
#pragma once
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/remove.h>
#include <thrust/device_ptr.h> 
#include <thrust/device_malloc.h> 
#include <thrust/device_free.h> 
#include "vehicle.cuh"
#include "edge.cuh"
#include "route.cuh"

class Edge;
class Route;
class Vehicle;

class VehicleControl
{
public:

    /**
     * Class Constructor and Destructor
     */
    VehicleControl();
    ~VehicleControl();

    /**
     * queueVehicle
     * @param vehicle   The vehicle to add to waiting queue
     */
    void queueVehicle(Route *r, Vehicle::Style style, int depart);

    /**
     * refreshTimestep
     */
    void refreshTimestep(int timeStep);
    
    /**
     * addVehicle
     * @param vehicle   Vehicle to add
     * @return  boolean whether vehicle was successfully added to route
     */
    bool addVehicle(Vehicle *vehicle);

private:

    /**
     * deleteVehicle
     * @param vehicle   The vehicle to discard
     */
    void deleteVehicle(Vehicle *vehicle);
    
    // vehicles : Thrust vector of Vehicle pointers
    thrust::device_vector<thrust::device_ptr<Vehicle>> vehicles;

    // waiting : Thrust vector
    thrust::device_vector<device_ptr<Vehicle>> waiting;

    int endedVehicles;

};

/**
 * readyToAdd
 * Functor for adding vehicle from waiting queue to active queue
 * @attribute timeStep  timestep state of when vehicle is called
 * @attribute vc        reference to vehicleController when called
 */
class readyToAdd {
private:
    int timeStep;
    VehicleControl *vc;
public:
    __host__ __device__ readyToAdd(int time, VehicleControl *v)
    {
        timeStep = time;
        vc = v;
    }
    __host__ __device__ bool operator()( Vehicle *v )
    {
        return ( timeStep >= v->depart && vc->addVehicle( v ) );
    };
};

/**
 * readyToRemove
 * Functor for removing a completed vehicle from active queue
 */
struct readyToRemove {
public:
    __host__ __device__ bool operator()( Vehicle *v )
    {
		bool readyToRemove = ( v->currEdge == v->route->end() && v->pos >= v->route->end()->length );
		if(readyToRemove)
		{
			v->currEdge->removeVehicle(v);
		}
        return readyToRemove;
    };
};
