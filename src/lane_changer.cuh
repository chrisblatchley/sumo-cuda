/**
 * @file: lane_changer.cuh
 * @author: Chris Blatchley
 * @author: Thad Bond
 *
 * Lane Changer Header
 */

#pragma once
#include <thrust/host_vector.h>

class LaneChanger
{
public:
	void planMovements();
	void executeMovements();
	LaneChanger(void);
	~LaneChanger(void);

};
