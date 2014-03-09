/**
 * @file: vehicle_control.h
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Vehicle Controller headers
 */

#pragma once
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>

class VehicleControl
{
public:

    /**
     * Class Constructor and Destructor
     */
    VehicleControl();
    ~VehicleControl();

    /**
     * addVehicle
     * @param vehicle   Pointer to vehicle to add
     * @return  boolean whether vehicle was successfully added to route
     */
    bool addVehicle(Vehicle *vehicle);

    /**
     * queueVehicle
     * @param vehicle   The vehicle to add to waiting queue
     */
    void queueVehicle(Vehicle *vehicle);

    /**
     * deleteVehicle
     * @param vehicle   The vehicle to discard
     * @param discard   Should discard the vehicle, default:false
     */
    void deleteVehicle(Vehicle *vehicle, bool discard = false);

    /**
     * refreshTimestep
     */
    void refreshTimestep(int timeStep);
    
    // vehicles : Thrust vector of Vehicle pointers
    thrust::host_vector<Vehicle *> vehicles;

    // waiting : Thrust vector
    thrust::host_vector<Vehicle *> waiting;

    int endedVehicles;

    int discardedVehicles;

};
