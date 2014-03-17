/**
 * @file: route.cu
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Route object implementation
 */
// #pragma once
#include "route.cuh"

/**
Constructor for Route object
*/
Route::Route()
{}

/**
Get the next edge in order on this Route
@param edge	The last edge relative to the one requested
*/
Edge* Route::getNextEdge( Edge* edge )
{
	for ( thrust::host_vector<Edge*>::iterator it = edges.begin(); it != edges.end(); it++ )
	{
		//If we found the current edge...
		if( *it == edge )
		{
			//Return the std::next edge
			return *it++;
		}
	}
	return NULL;
	//TODO OTHERWISE WERE TOTALLY SCREWED
}

/**
Retrieve the first edge on the Route
*/
Edge* Route::begin()
{
	return edges.front();
}

/**
Retrieve the last edge on the Route
*/
Edge* Route::end()
{
	return edges.back();
}

/**
Add an edge to the end of the Route
@param edge	The edge to be added to the Route
*/
void Route::addEdge( Edge* edge )
{
	//Add the edge to the back of the route
	edges.push_back( edge );
}

/**
Destructor for the Route object
*/
Route::~Route( void )
{
}
