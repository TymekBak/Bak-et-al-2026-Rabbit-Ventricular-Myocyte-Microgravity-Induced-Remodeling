import pathlib
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate
import pandas

#Load the Data
path = "ThresholdDescriptionCa.txt"
a = pathlib.Path(path)
Cn = np.loadtxt(a)

APD_Exclusion = np.array([])
Detection_Exclusion = np.array([])
Reuptake1 = np.array([]) #This array is meant store the individuals who have less than 50% reuptake before threhsold
Reuptake2 = np.array([]) #This array is meant store the individuals who have less than 50% reuptake after threshold

#Assuming the individual is not in Reuptake1-2
Reuptake3 = np.array([]) #This array is meant store the individuals who have less than 75% reuptake in both trials
Reuptake4 = np.array([]) #This array is meant store the individuals who have less than 75% reuptake before threhsold

#Assuming the individual is not in Reuptake3-4
Reuptake5 = np.array([]) #This array is meant store the individuals who have less than 90% reuptake in both trials
Reuptake6 = np.array([]) #This array is meant store the individuals who have less than 90% reuptake before threhsold

#Assuming the individual is not in Reuptake5-6
Reuptake7 = np.array([]) #This array is meant store the individuals who have less than 100% reuptake in both trials
Reuptake8 = np.array([]) #This array is meant store the individuals who have less than 100% reuptake before threhsold

j = 0
while(j <= 1000):
    #Confirm that in all cases the APD is greater than the BCL
    if((abs(Cn[j][0]) < abs(Cn[j][1])) or (abs(Cn[j][0]) < abs(Cn[j][2])) or (abs(Cn[j][0] + 1) < abs(Cn[j][5])) or (abs(Cn[j][0] + 1) < abs(Cn[j][6]))):
        APD_Exclusion = np.append(APD_Exclusion,j)
        j = j + 1
    #Confirm that the alternans threshold meets the 5ms criterion
    if((abs(Cn[j][1] - Cn[j][2]) < 5) or (abs(Cn[j][5] - Cn[j][6]) >= 5)):
        Detection_Exclusion = np.append(Detection_Exclusion,j)
        print((np.array([(abs(Cn[j][1] - Cn[j][2])),(abs(Cn[j][5] - Cn[j][6]))])))
        j = j + 1
        continue

    #Compute the percent of recovery after the large calcium transient
    if((Cn[j][9] >= Cn[j][10])):
        a = (Cn[j][11] - Cn[j][12])/(Cn[j][9] - Cn[j][12])
    else:
        a = (Cn[j][12] - Cn[j][11])/(Cn[j][10] - Cn[j][11])
    
    if((Cn[j][13] >= Cn[j][14])):
        b = (Cn[j][15] - Cn[j][16])/(Cn[j][13] - Cn[j][16])
    else:
        b = (Cn[j][16] - Cn[j][15])/(Cn[j][14] - Cn[j][15])
    
    #This part of the code confirmed that the only deviations are for cases where only marginal differences in end diastolic intervals were observed
    #if((a > 1) or (a < 0) or (b > 1) or (b < 0)):
        #print(a)
        #print(b)
    
    #Extract Individuals for Reuptake arrays
    if(abs(a) >= 0.5):
        Reuptake1 = np.append(Reuptake1,j)
    elif(abs(a) >= 0.75):
        Reuptake3 = np.append(Reuptake3,j)
    elif(abs(a) >= 0.9):
        Reuptake5 = np.append(Reuptake5,j)
    else:
        Reuptake7 = np.append(Reuptake7,j)
    
    if(abs(b) >= 0.5):
        Reuptake2 = np.append(Reuptake2,j)
    elif(abs(b) >= 0.75):
        Reuptake4 = np.append(Reuptake4,j)
    elif(abs(b) >= 0.9):
        Reuptake6 = np.append(Reuptake6,j)
    else:
        Reuptake8 = np.append(Reuptake8,j)
    j = j + 1
print(APD_Exclusion)
print(Detection_Exclusion)
print(Reuptake1)
print(Reuptake2)
print(Reuptake3)
print(Reuptake4)
print(Reuptake5)
print(Reuptake6)