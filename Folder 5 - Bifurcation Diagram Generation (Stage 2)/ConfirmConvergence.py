import pathlib
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate
import pandas

#This function is meant to compare the first value in an array to all other values in an array.
def PercentChange(C):
    i = 0
    C0 = C[0]
    while(i < len(C)):
        C[i] = abs((C[i] - C0)/C0*100)
        i = i + 1
    return(C)

def CheckConvergence_APD_BFD(version):
    #Load the file of interest
    path = "Outcomes_n/" + version + ".txt"
    a = pathlib.Path(path)
    outcomes_n_ref = np.transpose(np.loadtxt(a))

    PCLs = np.unique(outcomes_n_ref[0])
    outputfile = np.zeros((len(PCLs), 8))
    i_BCL = 0

    while(i_BCL < len(PCLs)):
        BCL = PCLs[i_BCL]
        #Select the last 100 beats
        iterations = round(max((outcomes_n_ref[1][outcomes_n_ref[0] == BCL])))
        index = np.logical_and((outcomes_n_ref[1] >= (iterations-99)),(outcomes_n_ref[0] == BCL))
        outcomes_n = np.transpose(outcomes_n_ref)
        outcomes_n = outcomes_n[index]
        outcomes_n = np.transpose(outcomes_n)

        #Extract the parameters used for defining convergence
        n = np.transpose(np.reshape(outcomes_n[1], shape=(100,-1)))
        APD = np.transpose(np.reshape(outcomes_n[2], shape=(100,-1)))
        Cai_max = np.transpose(np.reshape(outcomes_n[3], shape=(100,-1)))
        Cai_min = np.transpose(np.reshape(outcomes_n[4], shape=(100,-1)))
        CaSR_max = np.transpose(np.reshape(outcomes_n[5], shape=(100,-1)))
        CaSR_min = np.transpose(np.reshape(outcomes_n[6], shape=(100,-1)))
        Nai_max = np.transpose(np.reshape(outcomes_n[7], shape=(100,-1)))
        Nai_min = np.transpose(np.reshape(outcomes_n[8], shape=(100,-1)))
        D50 = np.transpose(np.reshape(outcomes_n[9], shape=(100,-1)))

        #Compute the maximum percent change in each parameter after accounting for the existence of alternans. Then, store the results.
        PercentChangeArray1 = np.array([np.max(PercentChange(APD[(n%2) == 0])),np.max(PercentChange(Cai_max[(n%2) == 0])),np.max(PercentChange(Cai_min[(n%2) == 0])),np.max(PercentChange(CaSR_max[(n%2) == 0])),np.max(PercentChange(CaSR_min[(n%2) == 0])),np.max(PercentChange(Nai_max[(n%2) == 0])),np.max(PercentChange(Nai_min[(n%2) == 0])),np.max(PercentChange(D50[(n%2) == 0]))])
        PercentChangeArray2 = np.array([np.max(PercentChange(APD[(n%2) == 1])),np.max(PercentChange(Cai_max[(n%2) == 1])),np.max(PercentChange(Cai_min[(n%2) == 1])),np.max(PercentChange(CaSR_max[(n%2) == 1])),np.max(PercentChange(CaSR_min[(n%2) == 1])),np.max(PercentChange(Nai_max[(n%2) == 1])),np.max(PercentChange(Nai_min[(n%2) == 1])),np.max(PercentChange(D50[(n%2) == 1]))])
        PercentChangeValue = np.max(np.array([(PercentChangeArray1),(PercentChangeArray2)]),axis=0)
        print("Version: " + version + " PCL = " + str(BCL) + "\t Percent Change: " + str(PercentChangeValue))
        outputfile[i_BCL] = PercentChangeValue
        i_BCL = i_BCL + 1
    #Find the maximum drift in the analysis. If the drift is non-zero print it and if it is greater than 0.5%, add a warning. In all cases save the results.
    if(np.max(outputfile) >= 0.5):
        print("CAUTION: " + version)
        print(outputfile)
        outputfile = np.max(outputfile,axis=0)
        print(outputfile)
    if(np.max(outputfile) > 0):
        print(version)
        print(outputfile)
        outputfile = np.max(outputfile,axis=0)
        print(outputfile)
    else:
        outputfile = np.max(outputfile,axis=0)
    return(outputfile)

#Use the previously defined functions to analyze the results.
PercentChangeValues_Baseline = np.zeros((14,8))
Individuals = np.array(["C0","M1"])
PercentChangeValues_Baseline[0] = CheckConvergence_APD_BFD("Baseline")
PercentChangeValues_Baseline[1] = CheckConvergence_APD_BFD("Manuscript")

i = 1
while(i <= 6):
    Individuals = np.append(Individuals, ("C" + str(i)))
    Individuals = np.append(Individuals, ("M" + str(i)))
    PercentChangeValues_Baseline[i*2] = CheckConvergence_APD_BFD("Baseline_V" + str(i))
    PercentChangeValues_Baseline[i*2 + 1] = CheckConvergence_APD_BFD("Manuscript_V" + str(i))
    i = i + 1
PercentChangeValues_Baseline = np.transpose(PercentChangeValues_Baseline)

print("Maximum Change: " + str(np.max(PercentChangeValues_Baseline)))