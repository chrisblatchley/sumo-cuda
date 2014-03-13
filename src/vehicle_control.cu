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
	//STATICALLY ADDING VEHICLE TO LANE 0, CHANGE ME LATER. I AM BAD FORM.
    if( edge->addVehicle( &vehicle, 0 ) )
    {
        vehicles.push_back(vehicle);
        return true;
    }
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

    // // Add ready vehicles from the waiting list
    // for (thrust::host_vector<Vehicle>::iterator it = waiting.begin(); it != waiting.end(); ++it)
    // {
    //     if( timeStep >= (*it).depart && addVehicle( (*it) ) )
    //     {
    //         if ( it == waiting.back())
    //         {
    //             waiting.pop_back();
    //             break;
    //         }
    //         else
    //         {
    //             it = waiting.erase(it);
    //         }
    //     }
    // }


    // // Remove vehicles from the running list
    // for (thrust::host_vector<Vehicle>::iterator it = vehicles.begin(); it != vehicles.end(); ++it)
    // {
    //     if( (*it).currEdge == (*it).route->end() && (*it).pos >= (*it).route->end()->length )
    //     {
    //         // it = vehicles.erase(it);
    //         if ( it == vehicles.back())
    //         {
    //             vehicles.pop_back();
    //             break;
    //         }
    //         else
    //         {
    //             it = vehicles.erase(it);
    //         }
    //     }
    // }
}
