/**
 * @file: vehicle.h
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Vehicle headers
 */

class Vehicle
{
public:

    const float ACCEL_FACTOR = 5.0;
    const float CRUISE_ACCEL = 0.0;
    const int MIN_CAR_LENGTHS_IN_FRONT = 2;

    struct Style
    {
        float length;
        float speed;
    };

    Vehicle(Route *r, Vehicle:Style style, int depart) : _route(r), _style(style), _depart(depart);
    
    ~Vehicle();

    /**
     * Logic to occur when the vehicle enters a new lane
     * @param lane The lane being entered
     */
    void enterLane(Lane *lane);

    /**
     * Called on each vehicle to plan the next move
     * @param pred     The vehicle infront of this one
     * @param distance The distance between this vehicle and it's predecessor
     */
    void planMove(Vehicle* pred, float distance);

    /**
     * Carry out the movement planned in planMove
     */
    void executeMove();

    /**
     * Accessor for Route
     * @return This vehicle's route
     */
    Route * getRoute();

    /**
     * Accessor for Style
     * @return This vehicle's style
     */
    Vehicle::Style * getStyle();

    /**
     * Accessor for Current Speed
     * @return This vehicle's current speed
     */
    float getSpeed();

    /**
     * Accessor for current position
     * @return This vehicle's current position
     */
    float getPosition();

    /**
     * Accessor for current edge
     * @return This vehicle's current edge
     */
    float getCurrentEdge();

    /**
     * Accessor for departure time
     * @return This vehicle's departure time
     */
    int getDepartureTime();

    /**
     * Setter for Route
     */
    void setRoute(Route * route);

    /**
     * Setter for Style
     */
    void setStyle(Vehicle::Style *style);

    /**
     * Setter for Current Speed
     */
    void setSpeed(float speed);

    /**
     * Setter for current position
     */
    void setPosition(float pos);

    /**
     * Setter for current edge
     */
    void setCurrentEdge(Edge *edge);

    /**
     * Setter for departure time
     */
    void setDepartureTime(int depart);

private:

    Route * _route;
    Vehicle::Style _style;
    float _currSpeed;
    float _pos;
    float _nextPos;
    Edge * _currEdge;
    int _depart;

};
