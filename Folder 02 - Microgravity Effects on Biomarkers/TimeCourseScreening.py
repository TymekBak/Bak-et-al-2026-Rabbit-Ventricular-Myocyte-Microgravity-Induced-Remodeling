import pathlib
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate
import pandas

#Define the array of file names that will be used to identify the locations where the data is stored.
Individuals = np.array(["Baseline.txt","Manuscript.txt"])

#Analyze the results of each simulation.
j = 0
while(j <= 1):
    #Load the time course data file
    path = "Outcomes_t/" + Individuals[j]
    a = pathlib.Path(path)
    Cn = np.loadtxt(a)
    Cn = np.transpose(Cn)

    #Extract the AP traces
    Vm1 = Cn[9][(len(Cn[9])-801):(len(Cn[9])-400)]
    Vm2 = Cn[9][(len(Cn[9])-401):len(Cn[9])]

    #Load the first output data file
    path = "Outcomes_n/" +  Individuals[j]
    a = pathlib.Path(path)
    Cn = np.loadtxt(a)
    Cn = np.transpose(Cn)

    #Extract the necessary parameters
    APD1 = Cn[1][(len(Cn[1]) - 2)]
    APD2 = Cn[1][(len(Cn[1]) - 1)]

    #Load the second output data file
    path = "ValidationVariables/" +  Individuals[j]
    a = pathlib.Path(path)
    Cn = np.loadtxt(a)
    Cn = np.transpose(Cn)

    #Extract the necessary parameters
    TTP1 = Cn[10][(len(Cn[1]) - 2)]
    TTP2 = Cn[10][(len(Cn[1]) - 1)]

    #Apply the tests for individual exclusion
    Test = np.zeros(4)

    #AP upstroke exceeds Vm=0mV
    if((max(Vm1) > 0) and (max(Vm2) > 0)):
        Test[0] = 1
    #Resting Membrane Potential below -85mV
    if((min(Vm1) < -85) and (min(Vm2) < -85)):
        Test[1] = 1
    #Calcium transient TTP is less than 50% of BCL
    if((TTP1 < 200) and (TTP2 < 200)):
        Test[2] = 1
    #APD is between 0ms and the BCL.
    if((APD1 < 400) and (APD1 > 0) and (APD2 < 400) and (APD2 > 0)):
        Test[3] = 1

    #Print the results of the analysis and some potentially relevant data
    if(int(sum(Test)) < 4):
        print("Failure in Individual " + str(j))
        print(APD1)
        print(TTP1)

        print(APD2)
        print(TTP2)
    else:
        print("Success in Individual " + str(j))
        print(APD1)
        print(TTP1)

        print(APD2)
        print(TTP2)
    j = j + 1