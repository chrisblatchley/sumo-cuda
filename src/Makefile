DIRS	= serial parallel
EXE	= sumo-cuda
OBJS	= 
OBJLIBS	= 
LIBS	= 

.PHONY: parallel serial

all : $(EXE)

$(EXE) : parallel serial
	-for d in $(DIRS); do (cp $$d/sumo-cuda ./sumo-cuda-$$d); done

parallel:
	$(MAKE) -C parallel

serial:
	$(MAKE) -C serial

clean :
	$(RM) -f sumo-cuda-parallel sumo-cuda-serial
	-for d in $(DIRS); do ($(MAKE) -C $$d clean ); done

