/**
 * @file: edge.cpp
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Edge implementation
 */
#pragma once
#include "junction.cuh"
#include "vehicle.cuh"

class Edge
{
public:

    /**
     * Class Constructor
     * @param length    Length of edge in meters
     * @param maxSpeed  Max speed on edge in meters/sec
     * @param junction  Terminal junction
     * @param laneChanger   Pointer to Lane Changer object
     */
    Edge(float length, float maxSpeed, Junction *junction, LaneChanger* laneChanger);

    /**
     * runLanes
     * Runs a timestep for the lanes in an edge
     */
    void runLanes();

    /**
     * addVehicle
     * @param vehicle   Vehicle to add to lane
     * @param lane      Lane to add vehicle to
     * @return          Boolean value if vehicle can be added
     */
    bool addVehicle(Vehicle * vehicle, int lane = 0);

    /**
     * removeVehicle
     * @param vehicle   Vehicle to be removed
     */
    void removeVehicle(Vehicle * vehicle);

    /**
     * addLane
     */
    void addLane();
    
    // length : Floating point value of length in meters
    float length;

    // maxSpeed : Float value of maximum speed in meters per second
    float maxSpeed;

    // junction : Pointer to junction at terminal end of edge
    Junction * junction;

    // lanes : Thrust vector of lanes
    thrust::host_vector<Lane *>lanes;

    // laneChanger : Pointer to Lane Changer Object
    LaneChanger * laneChanger;
};