/**
 * @file: vehicle.h
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Vehicle headers
 */
#include "route.cuh"
#include "lane.cuh"

class Vehicle
{
	public:

		/**
		 * Class Constants
		 */
		static const float Vehicle::ACCEL_FACTOR;
		static const float Vehicle::CRUISE_ACCEL;
		static const int Vehicle::MIN_CAR_LENGTHS_IN_FRONT;

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
		Vehicle(Route *r, Vehicle::Style style, int depart);

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
