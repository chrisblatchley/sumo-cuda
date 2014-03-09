/**
 * @file: edge.cpp
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Edge implementation
 */

#include "edge.cuh"

/**
 * Class Constructor
 * @param length    Length of edge in meters
 * @param maxSpeed  Max speed on edge in meters/sec
 * @param laneChanger   Pointer to Lane Changer object
 * @param junction  Terminal junction
 */
Edge::Edge(float length, float maxSpeed, Junction *junction, LaneChanger * laneChanger); {
    this.length = length;
    this.maxSpeed = maxSpeed;
    this.junction = junction;
    this.laneChanger = laneChanger;
}

/**
 * runLanes
 * Runs a timestep for the lanes in an edge
 */
void Edge::runLanes()
{
    for (int laneIdx = 0; laneIdx < laneLen; ++laneIdx)
    {
        lanes[laneIdx]->planMovements();
    }

    laneChanger->planMovements();

    for (int laneIdx = 0; laneIdx < laneLen; ++laneIdx)
    {
        lanes[laneIdx]->executeMovements();
    }
}

/**
 * addVehicle
 * @param vehicle   Vehicle to add to lane
 * @param lane      Lane to add vehicle to
 * @return          Boolean value if vehicle can be added
 */
bool Edge::addVehicle(Vehicle * vehicle, int lane = 0)
{
    return false;
}

/**
 * removeVehicle
 * @param vehicle   Vehicle to be removed
 */
void Edge::removeVehicle(Vehicle * vehicle)
{
    for (thrust::host_vector<Lane *>::iterator it = lanes.begin(); it != lanes.end(); ++it)
    {
        (*it)->removeVehicle(vehicle);
    }
}

/**
 * addLane
 */
void Edge::addLane()
{
    lanes.push_back( new Lane( &this ) );
}
