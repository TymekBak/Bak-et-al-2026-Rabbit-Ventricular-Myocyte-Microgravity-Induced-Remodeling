import pathlib
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate
import pandas

#This function is meant to compare the first value in an array to all other values in an array.
def PercentChange(C):
    i = 0
    C0 = C[0]
    if((max(C) == 0) and (min(C) == 0)):
        return(C)
    else:
        while(i < len(C)):
            C[i] = abs((C[i] - C0)/C0*100)
            i = i + 1
        return(C)

def CheckConvergence_APD_BFD(i,version):
    #Load the file of interest
    path = "Outcomes_n/" + version + "_P" + str(i) + ".txt"
    a = pathlib.Path(path)
    outcomes_n_ref = np.transpose(np.loadtxt(a))

    #Identify all of the unique BCLs.
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
        PercentChangeArray2 = np.array([np.max(PercentChange(APD[(n%2) == 1])),np.max(PercentChange(Cai_max[(n%2) == 1])),np.max(PercentChange(Cai_min[(n%2) == 1])),np.max(PercentChange(CaSR_max[(n%2) == 1])),np.max(PercentChange(CaSR_min[(n%2) == 1])),np.max(PercentChange(Nai_max[(n%2) == 1])),np.max(PercentChange(Nai_min[(n%2) == 1])),np.max(PercentChange(D50[(n%2) == 0]))])
        PercentChangeValue = np.max(np.array([(PercentChangeArray1),(PercentChangeArray2)]),axis=0)
        print("PCL = " + str(BCL) + "\t Percent Change: " + str(PercentChangeValue))
        outputfile[i_BCL] = PercentChangeValue
        i_BCL = i_BCL + 1
    
    #Find the maximum drift in the analysis. If the drift is non-zero print it and if it is greater than 0.5%, add a warning and print extra details. In all cases save the results.
    if(np.max(outputfile) >= 0.5):
        print("CAUTION: " + version + "_P" + str(i) + ".txt")
        print(outputfile)
        outputfile = np.max(outputfile,axis=0)
        print(outputfile)
        j = 0
        while(j < len(np.transpose(outputfile))):
            if(np.any(outputfile[j] >= 0.5)):
                print("BCL = " + str(PCLs[j]))
                print(outputfile[j])
            j = j + 1
    if(np.max(outputfile) > 0):
        print(version + "_P" + str(i) + ".txt")
        print(outputfile)
        outputfile = np.max(outputfile,axis=0)
        print(outputfile)
    else:
        outputfile = np.max(outputfile,axis=0)
    return(outputfile)

#Use the previously defined functions to analyze the results.
i = 0
PercentChangeValues_Baseline = np.zeros((1001,8))
Individuals = np.zeros(1001)
BCL = [23,147,519,599,970,119,203,313,411,458,519,50,187,312,452,726,829,913,943]
while(i < len(BCL)):
    Individuals[i] = BCL[i]
    PercentChangeValues_Baseline[i] = CheckConvergence_APD_BFD(BCL[i],"Baseline")
    i = i + 1
PercentChangeValues_Baseline = np.transpose(PercentChangeValues_Baseline)

print("Maximum Change: " + str(np.max(PercentChangeValues_Baseline)))