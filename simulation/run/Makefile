CXX = g++

CXXFLAGS += -I/usr/share/verilator/include \
            -I/usr/share/verilator/include/vltstd \
            -Iobj_dir

LDFLAGS = -lverilated -pthread

OBJ_FILES = obj_dir/Vtop__ALL.o obj_dir/Vtop.o obj_dir/verilated.o obj_dir/verilated_threads.o

all: verilator_sim verilator_top

verilator_sim: verilator_sim.cpp
	$(CXX) $(CXXFLAGS) -o verilator_sim verilator_sim.cpp

verilator_top: verilator_top.cpp $(OBJ_FILES)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o verilator_top verilator_top.cpp $(OBJ_FILES)

clean:
	rm -f verilator_sim verilator_top obj_dir/*
