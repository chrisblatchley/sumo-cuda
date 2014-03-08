/**
 * @file: edge.cpp
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Edge implementation
 */

class Edge
{
public:

    /**
     * Class Constructor and Destructor
     */
    Edge(float length, float maxSpeed, Junction *junction) : length(length), maxSpeed(maxSpeed), junction(junction);
    ~Edge();

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
    
    // length : Floating point value of length in meters
    float length;

    // maxSpeed : Float value of maximum speed in meters per second
    float maxSpeed;

    // junction : Pointer to junction at terminal end of edge
    Junction * junction;

    // lanes : Pointer to array of lanes
    Lane * lanes;
    // laneLen : Integer length of lanes array
    int laneLen;

    // laneChanger : Pointer to Lane Changer Object
    LaneChanger * laneChanger;
};
