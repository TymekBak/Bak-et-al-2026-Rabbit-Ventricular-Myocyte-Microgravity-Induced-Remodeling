import pathlib
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate
import pandas

#Create an array of strings that is used to locate the necessary data.
j = 0
Individuals = np.array(["Baseline.txt","BaselineAPC.txt","Manuscript.txt"])
i = 1
while(i <= 6):
    Individuals = np.append(Individuals, ("Baseline_V" + str(i) + ".txt"))
    Individuals = np.append(Individuals, ("Manuscript_V" + str(i) + ".txt"))
    i = i + 1

while(j <= 14):
    #Load the time course data file
    path = "Outcomes_t/" + Individuals[j]
    a = pathlib.Path(path)
    Cn = np.loadtxt(a)
    Cn = np.transpose(Cn)
    Index = Cn[0] == 400

    #Remove all data that does not correspond to pacing at 2.5Hz.
    Cn = np.transpose(Cn)
    Cn = Cn[Index]
    Cn = np.transpose(Cn)

    #Extract the voltage traces
    Vm1 = Cn[10][(len(Cn[9])-801):(len(Cn[9])-400)]
    Vm2 = Cn[10][(len(Cn[9])-401):len(Cn[9])]

    #Load the output data file
    path = "Outcomes_n/" +  Individuals[j]
    a = pathlib.Path(path)
    Cn = np.loadtxt(a)
    Cn = np.transpose(Cn)
    Index = Cn[0] == 400

    Cn = np.transpose(Cn)
    Cn = Cn[Index]
    Cn = np.transpose(Cn)

    #Extract the necessary parameters
    APD1 = Cn[2][(len(Cn[1]) - 2)]
    APD2 = Cn[2][(len(Cn[1]) - 1)]
    TTP1 = Cn[10][(len(Cn[1]) - 2)]
    TTP2 = Cn[10][(len(Cn[1]) - 1)]

    """     #Confirm all parameters are imported correctly
    print(APD1)
    print(TTP1)

    print(APD2)
    print(TTP2)

    plt.figure()
    plt.plot(Vm1)
    plt.plot(Vm2)
    plt.show() """

    #Apply the tests for individual exclusion
    Test = np.zeros(7)

    #AP upstroke exceeds Vm=0mV
    if((max(Vm1) > 0) and (max(Vm2) > 0)):
        Test[0] = 1
    #Resting Membrane Potential below -85mV
    if((min(Vm1) < -85) and (min(Vm2) < -85)):
        Test[1] = 1
    #Calcium transient TTP is less than 50% of BCL
    if((TTP1 < 200) and (TTP2 < 200)):
        Test[5] = 1
    #APD is between 0ms and the BCL.
    if((APD1 < 400) and (APD1 > 0) and (APD2 < 400) and (APD2 > 0)):
        Test[6] = 1

    #Print the results of the analysis and some potentially relevant data
    if(int(sum(Test)) < 4):
        print("Failure in  " + Individuals[j])
        print(APD1)
        print(TTP1)
        print(APD2)
        print(TTP2)
    else:
        print("Success in  " + Individuals[j])
    j = j + 1
