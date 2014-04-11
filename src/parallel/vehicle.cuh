/**
 * @file: vehicle.cuh
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Vehicle header file
 */
#pragma once
#include "route.cuh"
#include "lane.cuh"
#include "edge.cuh"
class Lane;
class Edge;
class Route;
class Vehicle
{
	public:

		/**
		 * Class Constants
		 */
		static const float ACCEL_FACTOR;
		static const float CRUISE_ACCEL;
		static const int MIN_CAR_LENGTHS_IN_FRONT;

		/**
		 * Struct Style
		 * length : float   represents length of car in meters
		 * speed  : float   max speed a car will drive in meters per second
		 */
		struct Style
		{
			float length;
			float speed;
		};

		/**
		 * Class Constructor and Destructor
		 */
		__host__ __device__ Vehicle();
		__host__ __device__ Vehicle(Route *r, Vehicle::Style style, int depart);

		__host__ __device__ ~Vehicle();

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
		 * Class Properties
		 */
    
		// route : Pointer to a route object which the vehicle will take
		Route * route;

		// style : A style containing the attributes of how the vehicle will drive
		Vehicle::Style style;

		// currSpeed : A floating point current speed
		float currSpeed;

		// pos : A floating point position on the vehicle's current edge
		float pos;

		// nextPos : a floating point position of where the vehicle plans to be at the
		//           beginning of the next time step
		float nextPos;

		// currEdge : A pointer to the current edge object the vehicle is on
		Edge * currEdge;

		// depart : A timestep for when the vehicle is supposed to depart.
		int depart;
};

class planMoveFunctor
{
public:
    const float edgeLength;
    planMoveFunctor(float egdeLength) : edgeLength(edgeLength) {}

    __host__ __device__
    Vehicle operator()(Vehicle pred, Vehicle vehicle)
    {
        const float ACCEL_FACTOR = 5.0; 
        const float CRUISE_ACCEL = 0.0;
        const int MIN_CAR_LENGTHS_IN_FRONT = 2;

        float accelFactor = ACCEL_FACTOR;
        float distanceToStop = edgeLength - vehicle.pos;
        float timeToStop = vehicle.currSpeed / accelFactor;
        float stoppingDistance = timeToStop * (timeToStop + 1) * vehicle.currSpeed / 2.0;

        bool approachingStop = distanceToStop < stoppingDistance;
        bool approachingPred = pred.currSpeed <= vehicle.currSpeed;
        bool predIsSlower = pred.style.speed < vehicle.style.speed;
        bool withinCarBuffer = (distanceToStop <= vehicle.style.length * MIN_CAR_LENGTHS_IN_FRONT);
        bool canStopNow = vehicle.currSpeed <= accelFactor;
        bool wantsToAccel = vehicle.currSpeed < vehicle.style.speed;

        if( approachingStop && !canStopNow || approachingPred)
        {
            if(predIsSlower)
                accelFactor = pred.currSpeed - vehicle.currSpeed;
            else
                accelFactor = -1 * ACCEL_FACTOR;
        }
        else if( wantsToAccel && !approachingStop)
        {
            accelFactor = ACCEL_FACTOR;
        }

        vehicle.currSpeed = vehicle.currSpeed + accelFactor;
        vehicle.nextPos = vehicle.pos + vehicle.currSpeed;

        return vehicle;
    }
};
