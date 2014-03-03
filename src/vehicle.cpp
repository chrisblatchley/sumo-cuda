/**
 * @file: vehicle.cpp
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Vehicle implementation
 */

#include "vehicle.h"

/**
 * Logic to occur when the vehicle enters a new lane
 * @param lane The lane being entered
 */
void Vehicle::enterLane(Lane *lane);
{
    _pos = 0;
    _currEdge = lane->getEdge();
}

/**
 * Called on each vehicle to plan the next move
 * @param pred     The vehicle infront of this one
 * @param distance The distance between this vehicle and it's predecessor
 */
void Vehicle::planMove(Vehicle* pred, float distance)
{
    return;
}

/**
 * Carry out the movement planned in planMove
 */
void Vehicle::executeMove()
{
    return;
}

/**
 * Accessor for Route
 * @return This vehicle's route
 */
Route * Vehicle::getRoute()
{
    return _route;
}

/**
 * Accessor for Style
 * @return This vehicle's style
 */
Car::Style * Vehicle::getStyle()
{
    return _style;
}

/**
 * Accessor for Current Speed
 * @return This vehicle's current speed
 */
float Vehicle::getSpeed()
{
    return _speed;
}

/**
 * Accessor for current position
 * @return This vehicle's current position
 */
float Vehicle::getPosition()
{
    return _pos;
}

/**
 * Accessor for current edge
 * @return This vehicle's current edge
 */
float Vehicle::getCurrentEdge()
{
    return _currEdge;
}

/**
 * Accessor for departure time
 * @return This vehicle's departure time
 */
int Vehicle::getDepartureTime()
{
    return _depart;
}

/**
 * Setter for Route
 */
void Vehicle::setRoute(Route * route)
{
    _route = route;
}

/**
 * Setter for Style
 */
void Vehicle::setStyle(Vehicle::Style *style)
{
    _style = style;
}

/**
 * Setter for Current Speed
 */
void Vehicle::setSpeed(float speed)
{
    _speed = speed;
}

/**
 * Setter for current position
 */
void Vehicle::setPosition(float pos)
{
    _pos = position;
}

/**
 * Setter for current edge
 */
void Vehicle::setCurrentEdge(Edge *edge)
{
    _currEdge = edge;
}

/**
 * Setter for departure time
 */
void Vehicle::setDepartureTime(int time)
{
    _depart = time;
}
