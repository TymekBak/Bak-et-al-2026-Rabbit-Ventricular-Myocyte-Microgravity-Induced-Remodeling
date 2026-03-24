import pathlib
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate
import pandas

plt.figure()
n = 0
j = 1
#Prepare arrays to store the AP and CaT traces for each individual in the population.
Vm_file = np.zeros((1001,2001))
Cai_file = np.zeros((1001,2001))
while(n < 1001):
    #Load the data for a specific individual.
    path = "Outcomes_t/Baseline_P" + str(n) + ".txt"
    a = pathlib.Path(path)
    Cn = np.loadtxt(a)
    Cn = np.transpose(Cn)

    #Extract the parameters of interest.
    tn = Cn[0] - min(Cn[0])
    Vmn = Cn[9]
    Cain = Cn[12]*1000
    CaNSRn = Cn[13]
    CaJSRn = Cn[14]

    #Prepare the AP and CaT data for export.
    Vm_file[n] = Vmn[0:2001]
    Cai_file[n] = Cain[0:2001]

    #Add the data to the current plot.
    plt.subplot(2,2,1)
    plt.plot(Vmn,color=(0.5,0.5,0.5))
    plt.xlabel("Time (ms)")
    plt.ylabel("Vm (mV)")
    plt.xlim(0,1000)

    plt.subplot(2,2,2)
    plt.plot(Cain,color=(0.5,0.5,0.5))
    plt.xlabel("Time (ms)")
    plt.ylabel("Cai (nM)")
    plt.xlim(0,1000)

    plt.subplot(2,2,3)
    plt.plot(CaNSRn,color=(0.5,0.5,0.5))
    plt.xlabel("Time (ms)")
    plt.ylabel("CaNSR (microM)")
    plt.xlim(0,1000)

    plt.subplot(2,2,4)
    plt.plot(CaJSRn,color=(0.5,0.5,0.5))
    plt.xlabel("Time (ms)")
    plt.ylabel("CaJSR (microM)")
    plt.xlim(0,1000)

    n = n + 1
    j = j + 1
plt.show()

#Write the AP and CaT data in a .txt file.
np.savetxt("AP_Traces_Baseline.txt", Vm_file)
np.savetxt("Ca_Traces_Baseline.txt", Cai_file)