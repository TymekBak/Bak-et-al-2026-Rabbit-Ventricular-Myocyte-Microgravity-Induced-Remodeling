import pathlib
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate
import pandas

#Load the data from Folder 5
path = "D:/Manuscript Code/Folder 5 - Bifurcation Diagram Generation (Stage 2)/Outcomes_t/BaselineAPC.txt"
a = pathlib.Path(path)
Cn = np.transpose(np.loadtxt(a))

#Cycle through each BCL and extract the AP waveform.
PCLs = np.unique(Cn[0])
i = 0
while(i < len(PCLs)):
    #Isolate the results for a specific BCL
    PCL = int(PCLs[i])
    BCL = Cn[0]
    Cni = np.transpose(Cn)
    Cni = Cni[BCL == PCL]
    Cni = np.transpose(Cni)

    #Extract the last two beats.
    t = Cni[1]
    Cni = np.transpose(Cni)
    Cni = Cni[t >= (max(t - PCL*2))]
    Cni = np.transpose(Cni)

    #Seperate the last two beats
    AP1 = Cni[10][0:PCL]
    AP2 = Cni[10][PCL:(PCL*2)]

    #Compare the APDs of the two beats
    print(len(AP1))
    print(len(AP2))
    APD1 = len(AP1[AP1 > (min(AP1) + 0.1*(max(AP1) - min(AP1)))])
    APD2 = len(AP2[AP2 > (min(AP2) + 0.1*(max(AP2) - min(AP2)))])

    #If different APDs are obtained in the analysis, make sure beat A is long and beat B is short.
    if(APD1 >= APD2):
        np.savetxt("Baseline APs/" + str(PCL) + "A.txt", AP1)
        np.savetxt("Baseline APs/" + str(PCL) + "B.txt", AP2)
    else:
        np.savetxt("Baseline APs/" + str(PCL) + "B.txt", AP1)
        np.savetxt("Baseline APs/" + str(PCL) + "A.txt", AP2)
    i = i + 1
