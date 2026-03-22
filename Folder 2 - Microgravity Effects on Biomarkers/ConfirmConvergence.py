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

#Define a function that evaluates the biomarkers of each simulation to evaluate convergence to steady-state.
def CheckConvergence_APD_BFD(version):
    #Load the files of interest
    path = "Outcomes_n/" + version + ".txt"
    a = pathlib.Path(path)
    outcomes_n_ref = np.transpose(np.loadtxt(a))

    #Select the last 100 beats
    outcomes_n = np.transpose(outcomes_n_ref)
    outcomes_n = outcomes_n[(len(outcomes_n)-100):(len(outcomes_n))]
    outcomes_n = np.transpose(outcomes_n)    

    #Extract the parameters used for defining convergence
    n = np.transpose(np.reshape(outcomes_n[0], shape=(100,-1)))
    APD = np.transpose(np.reshape(outcomes_n[1], shape=(100,-1)))
    Cai_max = np.transpose(np.reshape(outcomes_n[2], shape=(100,-1)))
    Cai_min = np.transpose(np.reshape(outcomes_n[3], shape=(100,-1)))
    CaSR_max = np.transpose(np.reshape(outcomes_n[4], shape=(100,-1)))
    CaSR_min = np.transpose(np.reshape(outcomes_n[5], shape=(100,-1)))
    Nai_max = np.transpose(np.reshape(outcomes_n[6], shape=(100,-1)))
    Nai_min = np.transpose(np.reshape(outcomes_n[7], shape=(100,-1)))
    CaTD50 = np.transpose(np.reshape(outcomes_n[8], shape=(100,-1)))

    #Compute the maximum percent change in each evaluated biomarker for the last 50 even beats
    PercentChangeArray1 = np.array([np.max(PercentChange(APD[(n%2) == 0])),np.max(PercentChange(Cai_max[(n%2) == 0])),np.max(PercentChange(Cai_min[(n%2) == 0])),np.max(PercentChange(CaSR_max[(n%2) == 0])),np.max(PercentChange(CaSR_min[(n%2) == 0])),np.max(PercentChange(Nai_max[(n%2) == 0])),np.max(PercentChange(Nai_min[(n%2) == 0])),np.max(PercentChange(CaTD50[(n%2) == 0]))])
    #Compute the maximum percent change in each evaluated biomarker for the last 50 odd beats
    PercentChangeArray2 = np.array([np.max(PercentChange(APD[(n%2) == 1])),np.max(PercentChange(Cai_max[(n%2) == 1])),np.max(PercentChange(Cai_min[(n%2) == 1])),np.max(PercentChange(CaSR_max[(n%2) == 1])),np.max(PercentChange(CaSR_min[(n%2) == 1])),np.max(PercentChange(Nai_max[(n%2) == 1])),np.max(PercentChange(Nai_min[(n%2) == 1])),np.max(PercentChange(CaTD50[(n%2) == 1]))])
    #Determine the maximum percent change for any evaluated biomarker in the last 100 beats, after accounting for alternans.
    PercentChangeValue = np.max(np.array([(PercentChangeArray1),(PercentChangeArray2)]),axis=0)
    #Print a summary of the analysis.
    print("Version: " + version + "\t PCL = " + str(400) + "\t Percent Change: " + str(PercentChangeValue))

    #Find the maximum percent change for each biomarker and print a warning if the drift exceeds 0.5%.
    outputfile = PercentChangeValue
    if(np.max(outputfile) >= 0.5):
        print("CAUTION: " + version)
        print(outputfile)
        outputfile = np.max(outputfile,axis=0)
        print(outputfile)
    else:
        outputfile = np.max(outputfile,axis=0)
    return(outputfile)

#Use the functions defined above to evaluate steady-state convergence in the simulation results.
PercentChangeValues_Baseline = np.zeros((2,8))
Individuals = np.array(["Baseline","Manuscript"])
PercentChangeValues_Baseline[0] = CheckConvergence_APD_BFD("Baseline")
PercentChangeValues_Baseline[1] = CheckConvergence_APD_BFD("Manuscript")

#Print the maximum change in any biomarker and individual for the last 100 beats of the analyses.
print("Maximum Change: " + str(np.max(PercentChangeValues_Baseline)))