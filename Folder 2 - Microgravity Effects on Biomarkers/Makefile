CXX=g++
CXXFLAGS=-O3


MahajanRecorder: cell.o MahajanRecorder.o
	$(CXX) -o $@ $(CXXFLAGS) MahajanRecorder.cpp cell.o

.cc.o:
	$(CXX) -c -MMD -MP $< $(CXXFLAGS)

clean:
	rm *.o
