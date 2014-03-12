#
# 'make'        build executable file 'mycc'
# 'make clean'  removes all .o and executable files
#

# define the C compiler to use
CXX = nvcc

# define any compile-time flags
CXXFLAGS = -g

# define any directories containing header files other than /usr/include
#
INCLUDES =

# define library paths in addition to /usr/lib
#   if I wanted to include libraries not in /usr/lib I'd specify
#   their path using -Lpath, something like:
LFLAGS =

# define any libraries to link into executable:
#   if I want to link in libraries (libx.so or libx.a) I use the -llibname 
#   option, something like (this will link in libmylib.so and libm.so:
LIBS =

# define the C source files
SRCS = edge.cu junction.cu lane.cu lane_changer.cu network.cu route.cu sumo_cuda.cu vehicle.cu vehicle_control.cu

# define the C object files 
#
# This uses Suffix Replacement within a macro:
#   $(name:string1=string2)
#         For each word in 'name' replace 'string1' with 'string2'
# Below we are replacing the suffix .c of all words in the macro SRCS
# with the .o suffix
#
OBJS = $(SRCS:.cu=.o)

# define the executable file 
MAIN = sumo-cuda

#
# The following part of the makefile is generic; it can be used to 
# build any executable just by changing the definitions above and by
# deleting dependencies appended to the file from 'make depend'
#

.PHONY: depend clean

all:    $(MAIN)
		@echo  sumo-cuda has finished building

$(MAIN): $(OBJS) 
		$(CXX) $(CXXFLAGS) $(INCLUDES) -o $(MAIN) $(OBJS) $(LFLAGS) $(LIBS)

# this is a suffix replacement rule for building .o's from .c's
# it uses automatic variables $<: the name of the prerequisite of
# the rule(a .c file) and $@: the name of the target of the rule (a .o file) 
# (see the gnu make manual section about automatic variables)
%.o: %.cu
		$(CXX) $(CXXFLAGS) $(INCLUDES) -c $<  -o $@

clean:
		$(RM) *.o *~ $(MAIN)
