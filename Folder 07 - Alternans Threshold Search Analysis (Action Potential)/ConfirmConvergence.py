import pathlib
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate
import pandas

#Define a fucntion that can compute the percent change for each member of an array relative to the first index.
def PercentChange(C):
    i = 0
    C0 = C[0]
    while(i < len(C)):
        C[i] = abs((C[i] - C0)/C0*100)
        i = i + 1
    return(C)

#Define a function that studies the biomarkers of each simulation to evaluate convergence to steady-state.
def CheckConvergence_APD_BFD(i,version):
    #Load the file of interest
    path = "Outcomes_n/" + version + "_P" + str(i) + ".txt"
    a = pathlib.Path(path)
    outcomes_n_ref = np.transpose(np.loadtxt(a))

    path = "AlternansThresholds/" + version + "_P" + str(i) + ".txt"
    a = pathlib.Path(path)
    AlternansThreshold = np.transpose(np.loadtxt(a))

    #Identify which BCLs need to be considered.
    PCLs = np.unique(outcomes_n_ref[0])
    PCLs = PCLs[abs(PCLs - AlternansThreshold) < 10]
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

        #Compute the maximum percent change in each evaluated biomarker for the last 50 even beats
        PercentChangeArray1 = np.array([np.max(PercentChange(APD[(n%2) == 0])),np.max(PercentChange(Cai_max[(n%2) == 0])),np.max(PercentChange(Cai_min[(n%2) == 0])),np.max(PercentChange(CaSR_max[(n%2) == 0])),np.max(PercentChange(CaSR_min[(n%2) == 0])),np.max(PercentChange(Nai_max[(n%2) == 0])),np.max(PercentChange(Nai_min[(n%2) == 0])),np.max(PercentChange(D50[(n%2) == 0]))])
        #Compute the maximum percent change in each evaluated biomarker for the last 50 odd beats
        PercentChangeArray2 = np.array([np.max(PercentChange(APD[(n%2) == 1])),np.max(PercentChange(Cai_max[(n%2) == 1])),np.max(PercentChange(Cai_min[(n%2) == 1])),np.max(PercentChange(CaSR_max[(n%2) == 1])),np.max(PercentChange(CaSR_min[(n%2) == 1])),np.max(PercentChange(Nai_max[(n%2) == 1])),np.max(PercentChange(Nai_min[(n%2) == 1])),np.max(PercentChange(D50[(n%2) == 1]))])
        #Determine the maximum percent change for any evaluated biomarker in the last 100 beats, after accounting for alternans.
        PercentChangeValue = np.max(np.array([(PercentChangeArray1),(PercentChangeArray2)]),axis=0)
        outputfile[i_BCL] = PercentChangeValue
        i_BCL = i_BCL + 1
    #Find the maximum drift in the analysis. If the drift is non-zero print it and if it is greater than 0.5%, add a warning. In all cases save the results.
    if(np.max(outputfile) >= 0.5):
        print("CAUTION: " + version + "_P" + str(i) + ".txt")
        print(outputfile)
        outputfile = np.max(outputfile,axis=0)
        print(outputfile)
    if(np.max(outputfile) > 0):
        print(version + "_P" + str(i) + ".txt")
        print(outputfile)
        outputfile = np.max(outputfile,axis=0)
        print(outputfile)
    else:
        outputfile = np.max(outputfile,axis=0)
    return(outputfile)

#Use the functions defined above to evaluate steady-state convergence in the simulation results.
i = 0
PercentChangeValues_Baseline = np.zeros((1001,8))
Individuals = np.zeros(1001)
while(i <= 1000):
    Individuals[i] = i
    PercentChangeValues_Baseline[i] = CheckConvergence_APD_BFD(i,"Baseline")
    i = i + 1
PercentChangeValues_Baseline = np.transpose(PercentChangeValues_Baseline)

#Print the maximum change in any biomarker and individual for the last 100 beats of the analyses.
print("Maximum Change: " + str(np.max(PercentChangeValues_Baseline)))
