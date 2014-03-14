/**
 * @file: sumo_cuda.cu
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Main entry point for sumo-cuda
 */
#include <cstdio>
#include "network.cuh"
#include "junction.cuh"
#include "edge.cuh"
#include "route.cuh"
#include "vehicle_control.cuh"

void printHelpString()
{
    printf("SUMO-CUDA\n");
    printf("    USAGE: sumo-cuda [options] network.netccfg\n");
    printf("\n");
    printf("Authors: Thaddeus Bond, Chris Blatchley\n");
}

void test()
{
    Network network = Network(150);
    Junction * j1 = network.addJunction( Junction::AllStop );
    Edge *e1 = network.addEdge( 1000.00, 30.0, j1 );
    Route *r1 = network.addRoute();
    r1->addEdge(e1);
    Vehicle::Style style = {5.0, 30.0};
    (network.vehicleController)->queueVehicle(r1, style, 5);
    network.runSimulation();
}

int main(int argc, char const *argv[])
{
    test();
    return 0;
}
