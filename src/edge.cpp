/**
 * @file: edge.cpp
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Edge implementation
 */

// *
//  * Class constructor and destructor
 
// Edge::Edge() {

// }

// Edge::~Edge()
// {

// }

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
