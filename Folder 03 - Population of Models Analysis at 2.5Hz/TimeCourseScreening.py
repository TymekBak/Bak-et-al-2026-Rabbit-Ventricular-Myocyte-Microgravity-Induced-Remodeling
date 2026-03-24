import pathlib
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate
import pandas

#Analyze the results of each simulation.
j = 0
while(j <= 1000):
    #Load the time course data file
    path = "Outcomes_t/Baseline_P" + str(j) + ".txt"
    a = pathlib.Path(path)
    Cn = np.loadtxt(a)
    Cn = np.transpose(Cn)

    #Extract the AP traces
    Vm1 = Cn[9][(len(Cn[9])-801):(len(Cn[9])-400)]
    Vm2 = Cn[9][(len(Cn[9])-401):len(Cn[9])]
    Cai1 = Cn[12][(len(Cn[12])-801):(len(Cn[12])-400)]
    Cai2 = Cn[12][(len(Cn[12])-401):len(Cn[12])]

    #Load the first output data file
    path = "Outcomes_n/Baseline_P" + str(j) + ".txt"
    a = pathlib.Path(path)
    Cn = np.loadtxt(a)
    Cn = np.transpose(Cn)

    #Extract the necessary parameters
    APD1 = Cn[1][(len(Cn[1]) - 2)]
    APD2 = Cn[1][(len(Cn[1]) - 1)]
    TTP1 = Cn[9][(len(Cn[1]) - 2)]
    TTP2 = Cn[9][(len(Cn[1]) - 1)]

    #Confirm all parameters are imported and computed correctly
    """print(APD1)
    print(TTP1)

    print(APD2)
    print(TTP2)

    plt.figure()
    plt.subplot(1,2,1)
    plt.plot(Vm1)
    plt.plot(Vm2)
    plt.axhline(min(Vm1) + 0.1*(max(Vm1) - min(Vm1)))
    plt.axhline(min(Vm2) + 0.1*(max(Vm2) - min(Vm2)))
    plt.subplot(1,2,2)
    plt.plot(Cai1)
    plt.plot(Cai2)
    plt.axhline(max(Cai1))
    plt.axhline(max(Cai2))
    plt.axhline(min(Cai1))
    plt.axhline(min(Cai2))
    plt.show()"""

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

        plt.figure()
        plt.subplot(1,2,1)
        plt.plot(Vm1)
        plt.plot(Vm2)
        plt.subplot(1,2,2)
        plt.plot(Cai1)
        plt.plot(Cai2)
        plt.show()
    """else:
        print("Success in Individual " + str(j))
        print(APD1)
        print(TTP1)

        print(APD2)
        print(TTP2)"""
    j = j + 1