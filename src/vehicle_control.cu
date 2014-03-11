/**
 * @file: vehicle_control.cu
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Vehicle controller object implementation
 */
#pragma once
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include "vehicle_control.cuh"
#include "vehicle.cuh"

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

// VehicleControl::~VehicleControl();

/**
 * addVehicle
 * @param vehicle   Pointer to vehicle to add
 * @return  boolean whether vehicle was successfully added to route
 */
bool VehicleControl::addVehicle(Vehicle *vehicle)
{
    Edge *edge = vehicle->route->begin();
    if( edge->addVehicle( vehicle ) )
    {
        vehicles.push_back(vehicle);
        return true;
    }
    return false;
}

/**
 * queueVehicle
 * @param vehicle   The vehicle to add to waiting queue
 */
void VehicleControl::queueVehicle(Vehicle *vehicle)
{
    waiting.push_back(vehicle);
}

/**
 * deleteVehicle
 * @param vehicle   The vehicle to discard
 */
void VehicleControl::deleteVehicle(Vehicle *vehicle)
{
    ++endedVehicles;
    for (thrust::host_vector<Vehicle *>::iterator it = vehicles.begin(); it != vehicles.end(); ++it)
    {
        if( *it == vehicle)
        {
            vehicles.erase(it); 
            break;
        }
    }
    vehicle->currEdge->removeVehicle(vehicle);
}

/**
 * refreshTimestep
 */
void VehicleControl::refreshTimestep(int timeStep)
{
    // Add ready vehicles from the waiting list
    for (thrust::host_vector<Vehicle *>::iterator it = waiting.begin(); it != waiting.end(); ++it)
    {
        if( (*it)->depart >= timeStep )
        {
            if( addVehicle(*it) )
            {
                vehicles.push_back(*it);
                waiting.erase(it);
            }
        }
    }

    // Remove vehicles from the running list
    for (thrust::host_vector<Vehicle *>::iterator it = vehicles.begin(); it != vehicles.end(); ++it)
    {
        if( (*it)->currEdge == (*it)->route->end() )
            if( (*it)->pos >= (*it)->route->end()->length )
                vehicles.erase(it);
    }
}
