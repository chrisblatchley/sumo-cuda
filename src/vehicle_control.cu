/**
 * @file: vehicle_control.cu
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Vehicle controller object implementation
 */
// #pragma once
#include "vehicle_control.cuh"
#include <thrust/remove.h>

/**
 * Class Constructor and Destructor
 */
VehicleControl::VehicleControl()
{
    // Note: These are allocated exactly the same way
    // when the object is created. I think... -Chris
    // vehicles = thrust::host_vector<Vehicle *>(0);
    // waiting = thrus::host_vector<Vehicle *>(0);
    endedVehicles = 0;
}

VehicleControl::~VehicleControl()
{
}

/**
 * addVehicle
 * @param vehicle   Pointer to vehicle to add
 * @return  boolean whether vehicle was successfully added to route
 */
bool VehicleControl::addVehicle(Vehicle vehicle)
{
    Edge *edge = vehicle.route->begin();
    vehicles.push_back(vehicle);
    Vehicle newVeh = vehicles.back();
	//STATICALLY ADDING VEHICLE TO LANE 0, CHANGE ME LATER. I AM BAD FORM.
    if( edge->addVehicle( &newVeh, 0 ) )
    {
        return true;
    }
    vehicles.pop_back();
    return false;
}

/**
 * queueVehicle
 * @param r     The Route to add the new vehicle to
 * @param style The style of the new vehicle
 * @param depart    Timestep when the new vehicle is supposed to start
 */
void VehicleControl::queueVehicle(Route *r, Vehicle::Style style, int depart)
{
    waiting.push_back( Vehicle(r, style, depart) );
}

/**
 * deleteVehicle
 * @param vehicle   The vehicle to discard
 */
void VehicleControl::deleteVehicle(Vehicle *vehicle)
{
    ++endedVehicles;

    // for (thrust::host_vector<Vehicle>::iterator it = vehicles.begin(); it != vehicles.end(); ++it)
    // {
    //     if( &(*it) == vehicle)
    //     {
    //         it = vehicles.erase(it); 
    //         break;
    //     }
    // }
    
    vehicle->currEdge->removeVehicle(vehicle);
}

/**
 * refreshTimestep
 */
void VehicleControl::refreshTimestep(int timeStep)
{
    readyToAdd pred(timeStep, this);
    waiting.erase( thrust::remove_if( waiting.begin(), waiting.end(), pred ), waiting.end() );
    vehicles.erase( thrust::remove_if( vehicles.begin(), vehicles.end(), readyToRemove() ), vehicles.end() );
}
