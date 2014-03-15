/**
 * @file: sumo_cuda.cu
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Main entry point for sumo-cuda
 */
#include <cstdio>
#include <hash_map>
#include <string>
#include <stdlib.h>
#include <sstream>
#include "network.cuh"
#include "junction.cuh"
#include "edge.cuh"
#include "route.cuh"
#include "vehicle_control.cuh"
#include "tinyxml2.h"

//Helper functions for splitting a delimited string
//Source: http://stackoverflow.com/a/236803
std::vector<std::string> &split(const std::string &s, char delim, std::vector<std::string> &elems) {
    std::stringstream ss(s);
    std::string item;
    while (std::getline(ss, item, delim)) {
        elems.push_back(item);
    }
    return elems;
}


std::vector<std::string> split(const std::string &s, char delim) {
    std::vector<std::string> elems;
    split(s, delim, elems);
    return elems;
}

void printHelpString()
{
    printf("SUMO-CUDA\n");
    printf("    USAGE: sumo-cuda [options] network.netccfg\n");
    printf("\n");
    printf("Authors: Thaddeus Bond, Chris Blatchley\n");
}

void test()
{
    Network network = Network(0,150);
    Junction * j1 = network.addJunction( Junction::AllStop );
    Edge *e1 = network.addEdge( 1000.00, 30.0, j1 );
    Route *r1 = network.addRoute();
    r1->addEdge(e1);
    Vehicle::Style style = {5.0, 30.0};
    (network.vehicleController)->queueVehicle(r1, style, 5);
    network.runSimulation();
}

void runFile(const char * cfgFile)
{
	tinyxml2::XMLDocument cfgDoc;
	cfgDoc.LoadFile(cfgFile);

	//Get the cfg node
	tinyxml2::XMLNode * cfgNode = cfgDoc.FirstChildElement();

	const char * netFile = cfgNode->FirstChildElement("input")->FirstChildElement("net-file")->Attribute("value");
	const char * routeFile = cfgNode->FirstChildElement("input")->FirstChildElement("route-files")->Attribute("value");
	int startTime = strtol(cfgNode->FirstChildElement("time")->FirstChildElement("begin")->Attribute("value"), NULL, 10);
	int endTime = strtol(cfgNode->FirstChildElement("time")->FirstChildElement("end")->Attribute("value"), NULL, 10);
	//Define the network object. "You are an amazing object, Network, good to have you!"
	Network network = Network(startTime, endTime);

	tinyxml2::XMLDocument netDoc;
	netDoc.LoadFile(netFile);

	//Get the "net" node
	tinyxml2::XMLNode * netNode = netDoc.FirstChildElement();

	//Create a junction map so we can set up the network via the proper ids
	std::hash_map<std::string, Junction*> junctionMap;
	//Loop through and create all the junction objects
	for(tinyxml2::XMLElement * j = netNode->FirstChildElement("junction"); j != NULL; j = j->NextSiblingElement("junction"))
	{
		//Default shape Throughway
		Junction::Shape shape = Junction::Throughway;
		if(j->Attribute("type") == "allway_stop")
		{
			shape = Junction::AllStop;
		}else if(j->Attribute("type") == "unregulated")
		{
			shape = Junction::Throughway;
		}

		//Create junction and store it
		Junction * junction = network.addJunction( shape );
		junctionMap.insert( std::pair<std::string, Junction*>(j->Attribute("id"), junction) );
	}

	//Create our edge map so we can find edges by id for setup
	std::hash_map<std::string, Edge*> edgeMap;
	//Loop through all the edge nodes
	for(tinyxml2::XMLElement * e = netNode->FirstChildElement("edge"); e != NULL; e = e->NextSiblingElement("edge"))
	{
		//Create the edge node with the appropriate values and junction ending
		if(e->Attribute("to") == NULL)
		{
			//This is an internal edge, skip it.
			continue;
		}
		Edge * edge = network.addEdge(e->FirstChildElement()->FloatAttribute("length"), e->FirstChildElement()->FloatAttribute("speed"), junctionMap[e->Attribute("to")]);

		for(tinyxml2::XMLElement * l = e->FirstChildElement("lane"); l != NULL; l = l->NextSiblingElement("lane"))
		{
			if(l != e->FirstChildElement("lane"))
			{
				//If we aren't the first lane, add another
				edge->addLane();
			}
		}

		//Insert the edge into our map for further use
		edgeMap.insert( std::pair<std::string, Edge*>(e->Attribute("id"), edge) );
	}

	tinyxml2::XMLDocument routeDoc;
	routeDoc.LoadFile(routeFile);

	//Get the "net" node
	tinyxml2::XMLNode * routeNode = routeDoc.FirstChildElement();

	//Create a map so we can find routes by ids for setup
	std::hash_map<std::string, Route*> routeMap;
	//First, create all our routes within the network
	for(tinyxml2::XMLElement * r = routeNode->FirstChildElement("route"); r != NULL; r = r->NextSiblingElement("route"))
	{
		//Create a route object
		Route * route = new Route();
		std::vector<std::string> edgeList = split( r->Attribute("edges"), ' ' );
		for(std::vector<std::string>::iterator it = edgeList.begin(); it != edgeList.end(); ++it) {
			//Add that edge to the route
			route->addEdge(edgeMap[*it]);
		}

		routeMap.insert( std::pair<std::string, Route*>(r->Attribute("id"), route) );
	}

	//Create a map of vehicle styles to be used in vehicle queueing
	std::hash_map<std::string, Vehicle::Style> styleMap;
	//Loop through all the vehicle styles
	for(tinyxml2::XMLElement * s = routeNode->FirstChildElement("vType"); s != NULL; s = s->NextSiblingElement("vType"))
	{
		Vehicle::Style style = {std::strtod(s->Attribute("length"), NULL), std::strtod(s->Attribute("maxSpeed"), NULL)};
		styleMap.insert( std::pair<std::string, Vehicle::Style>(s->Attribute("id"), style) );
	}

	for(tinyxml2::XMLElement * v = routeNode->FirstChildElement("vehicle"); v != NULL; v = v->NextSiblingElement("vehicle"))
	{
		(network.vehicleController)->queueVehicle(routeMap[v->Attribute("route")], styleMap[v->Attribute("type")], v->IntAttribute("depart"));
	}

	network.runSimulation();
	
}

int main(int argc, char const *argv[])
{
	if(argc == 2)
	{
		runFile(argv[1]);
	}else{
		test();
	}
    return 0;
}



