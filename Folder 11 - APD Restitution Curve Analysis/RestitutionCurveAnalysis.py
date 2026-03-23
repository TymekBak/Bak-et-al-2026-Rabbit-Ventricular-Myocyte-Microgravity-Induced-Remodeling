import pathlib
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate
import pandas

#Load the time course trace data for a particular model.
def LoadData(ModelName):
    path = "Outcomes_t/" + ModelName + ".txt"
    Data = pathlib.Path(path)
    Data = np.transpose(np.loadtxt(Data))
    return(Data)

#Seperate out the data from a specific trial BCL from the rest of the time course trace data variable.
def ExtractBCL(C,BCL):
    indexing_array1 = ((np.transpose(C[0]) == BCL))
    C = np.transpose(C)
    C = C[indexing_array1]
    C = np.transpose(C)
    return(C[10])

#Plot the action potential waveform from a specific trial BCL.
def PlotBCL(C,BCL):
    Vm = ExtractBCL(C,BCL)
    plt.plot(Vm)

#Compute the APD and DI from the action potential waveform at a specific BCL.
#This code uses a more accurate computation method than the one used during the main simulation.
def EstimateAPD_and_DI(Vm):
    #Compute the threshold and prepare for the analysis.
    Vm_thresh = min(Vm) + 0.1*(max(Vm) - min(Vm))
    i = 1
    inAPD = Vm[0] > Vm_thresh
    t1 = 0
    APD1 = 0
    APD2 = 0
    DI1 = 0
    DI2 = 0
    #Cycle through the action potential waveform and record the last two action potential and diastolic interval durations.
    while(i < len(Vm)):
        if(inAPD and (Vm[i] < Vm_thresh)):
            APD2 = APD1
            t2 = (i - 1) + (Vm_thresh - Vm[i - 1])/(Vm[i] - Vm[i-1])
            APD1 = t2 - t1
            inAPD = False
            t1 = t2
        elif(not(inAPD) and (Vm[i] > Vm_thresh)):
            DI2 = DI1
            t2 = (i - 1) + (Vm_thresh - Vm[i - 1])/(Vm[i] - Vm[i-1])
            DI1 = t2 - t1
            inAPD = True
            t1 = t2
        i = i + 1
    return(np.array([APD1,DI1,APD2,DI2,inAPD]))

#Create a plot that compares the different trials of the simulation.
"""plt.figure()
j = 0
BCL = 600
C1 = LoadData("Baseline")
while(j < 16):
    if(BCL == 400):
        BCL = 401
    PlotBCL(C1,BCL)
    j = j + 1
    BCL = BCL - 25
plt.xlabel("Time (ms)")
plt.ylabel("Vm (mV)")
plt.show()"""

#Load the data and prepare the data processing variables.
C1 = LoadData("Baseline")
C2 = LoadData("Manuscript")
title = "S1 = 400ms"
BCL = 600
Result1 = np.zeros((401,4))
Result2 = np.zeros((401,4))
Result3 = np.zeros((401,4))

#Analyze the results for each trial in the baseline and microgravity models.
a = 0
while(a <= 400):
    b = EstimateAPD_and_DI(ExtractBCL(C1,BCL))
    if(b[4] == 1):
        Result1[a][0] = b[1]
        Result1[a][1] = b[2]
        Result1[a][2] = b[3]
        Result1[a][3] = b[0]
    else:
        Result1[a][0] = b[1]
        Result1[a][1] = b[0]
        Result1[a][2] = b[3]
        Result1[a][3] = b[2]
    b = EstimateAPD_and_DI(ExtractBCL(C2,BCL))
    if(b[4] == 1):
        Result2[a][0] = b[1]
        Result2[a][1] = b[2]
        Result2[a][2] = b[3]
        Result2[a][3] = b[0]
    else:
        Result2[a][0] = b[1]
        Result2[a][1] = b[0]
        Result2[a][2] = b[3]
        Result2[a][3] = b[2]
    BCL = BCL - 1
    a = a + 1

Result1 = np.transpose(Result1)
Result2 = np.transpose(Result2)
Result3 = np.transpose(Result3)

#Plot the results
"""plt.figure()
plt.scatter(Result1[0][Result1[0] > 5],Result1[1][Result1[0] > 5],color=(0,0,0), label="Baseline")
plt.scatter(Result2[0][Result2[0] > 5],Result2[1][Result2[0] > 5],color=(1,0,0), label="Microgravity")
plt.xlabel("DI_n (ms)")
plt.ylabel("APD_{n+1} (ms)")
plt.title(title)
plt.legend()
plt.show()"""

#Save the data and remove cases where the diastolic interval is less than 5ms.
np.savetxt("Baseline_DI_BCL400.txt", Result1[0][Result1[0] > 5])
np.savetxt("Baseline_APD_BCL400.txt", Result1[1][Result1[0] > 5])
np.savetxt("Microgravity_DI_BCL400.txt", Result2[0][Result2[0] > 5])
np.savetxt("Microgravity_APD_BCL400.txt", Result2[1][Result2[0] > 5])