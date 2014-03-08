#include "Route.h"

/**
Constructor for Route object
@param uid	The name or unique identifier of this route
*/
Route::Route( string uid )
{
	_uid = uid;
}

/**
Get the next edge in order on this Route
@param edge	The last edge relative to the one requested
*/
Edge* Route::getNextEdge( Edge* edge )
{
	for ( vector<Edge*>::iterator it = _edges.begin(); it != _edges.end(); it++ )
	{
		//If we found the current edge...
		if( *it == edge )
		{
			//Return the std::next edge
			return *next(it);
		}
	}
}

/**
Retrieve the first edge on the Route
*/
Edge* Route::begin()
{
	return _edges.front();
}

/**
Retrieve the last edge on the Route
*/
Edge* Route::end()
{
	return _edges.back();
}

/**
Add an edge to the end of the Route
@param edge	The edge to be added to the Route
*/
void Route::addEdge( Edge* edge )
{
	//Add the edge to the back of the route
	_edges.push_back( edge );
}

/**
Destructor for the Route object
*/
Route::~Route( void )
{
}
