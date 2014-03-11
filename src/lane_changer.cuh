#pragma once
#include <thrust\host_vector.h>
class LaneChanger
{
public:
	void planMovements();
	void executeMovements();
	LaneChanger(void);
	~LaneChanger(void);
};
