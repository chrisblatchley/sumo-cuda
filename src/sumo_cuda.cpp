/**
 * @file: sumo_cuda.cpp
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Main entry point for sumo-cuda
 */

#include <string>
#include <fstream>
#include <iostream>

void printHelpString()
{
    printf("SUMO-CUDA\n");
    printf("    USAGE: sumo-cuda [options] network.netccfg\n");
    printf("\n");
    printf("Authors: Thaddeus Bond, Chris Blatchley\n");
}

void test()
{
}

int int main(int argc, char const *argv[])
{
    if (argc > 1)
    {
        if ( argv[1] == "test" )
        {
            test();
            return 0;
        }
    }
    printHelpString();
    return 0;
}
