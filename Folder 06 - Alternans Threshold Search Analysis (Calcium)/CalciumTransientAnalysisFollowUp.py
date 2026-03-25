import pathlib
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate
import pandas

j = 0

while(j < 23):
    #Cycle through each individual that requires a more through analysis
    ID = [15,274,411,570,891,979,23,119,203,313,458,519,991,50,187,312,452,726,793,829,913,943,970]
    #Load the necessary data
    path = "Outcomes_t/Baseline_P" + str(ID[j]) + ".txt"
    a = pathlib.Path(path)
    Cn = np.loadtxt(a)
    Cn = np.transpose(Cn)

    path = "AlternansThresholds/Baseline_P" + str(ID[j]) + ".txt"
    Threshold = pathlib.Path(path)
    Threshold = np.transpose(np.loadtxt(Threshold))

    #Extract the necessary action potential and calcium transient data.
    Vm_Pre = Cn[10][Cn[0] == (Threshold+1)]
    Vm_Post = Cn[10][Cn[0] == (Threshold)]
    Cai_Pre = Cn[13][Cn[0] == (Threshold+1)]
    Cai_Post = Cn[13][Cn[0] == (Threshold)]

    Vm_Pre = Vm_Pre[0:int(10*Threshold+1)]
    Vm_Post = Vm_Post[0:int(10*Threshold)]
    Cai_Pre = Cai_Pre[0:int(10*Threshold)]
    Cai_Post = Cai_Post[0:int(10*Threshold)]

    #Compute the parameters that are needed to estimate the APDs.
    Thresh_Pre = min(Vm_Pre) + 0.1*(max(Vm_Pre) - min(Vm_Pre))
    Thresh_Post = min(Vm_Post) + 0.1*(max(Vm_Post) - min(Vm_Post))
    inAPD_Pre = Vm_Pre[0] > Thresh_Pre
    inAPD_Post = Vm_Post[0] > Thresh_Post


    #Estimate the APDs.
    i = 1
    APD_Start1_Pre = 0
    APD_Start2_Pre = 0
    APD_Start3_Pre = 0
    APD_End1_Pre = 0
    APD_End2_Pre = 0
    APD_End3_Pre = 0
    APD1_Pre = 0
    APD2_Pre = 0
    APD3_Pre = 0

    while(i < len(Vm_Pre)):
        if(inAPD_Pre and (Vm_Pre[i] < Thresh_Pre)):
            APD_End3_Pre = APD_End2_Pre
            APD_End2_Pre = APD_End1_Pre
            APD_End1_Pre = i - 1

            APD3_Pre = APD2_Pre
            APD2_Pre = APD1_Pre
            APD1_Pre = APD_Start1_Pre - APD_End1_Pre

            inAPD_Pre = False
        elif(not(inAPD_Pre) and (Vm_Pre[i] > Thresh_Pre)):
            APD_Start3_Pre = APD_Start2_Pre
            APD_Start2_Pre = APD_Start1_Pre
            APD_Start1_Pre = i - 1
            inAPD_Pre = True
        i = i + 1

    i = 1
    APD_Start1_Post = 0
    APD_Start2_Post = 0
    APD_Start3_Post = 0
    APD_End1_Post = 0
    APD_End2_Post = 0
    APD_End3_Post = 0
    APD1_Post = 0
    APD2_Post = 0
    APD3_Post = 0

    while(i < len(Vm_Post)):
        if(inAPD_Post and (Vm_Post[i] < Thresh_Post)):
            APD_End3_Post = APD_End2_Post
            APD_End2_Post = APD_End1_Post
            APD_End1_Post = i - 1

            APD3_Post = APD2_Post
            APD2_Post = APD1_Post
            APD1_Post = APD_Start1_Post - APD_End1_Post

            inAPD_Post = False
        elif(not(inAPD_Post) and (Vm_Post[i] > Thresh_Post)):
            APD_Start3_Post = APD_Start2_Post
            APD_Start2_Post = APD_Start1_Post
            APD_Start1_Post = i - 1
            inAPD_Post = True
        i = i + 1
    
    #Obtain the maximum cytosolic calcium concentration in the APD and the minimum cytosolic calcium concentration in the DI.
    if(not(inAPD_Pre)):
        Cai_Max1_Pre = np.max(Cai_Pre[(APD_Start2_Pre-1):(APD_End2_Pre)])
        Cai_Max2_Pre = np.max(Cai_Pre[(APD_Start3_Pre-1):(APD_End3_Pre)])
        Cai_ED1_Pre = np.min(Cai_Pre[(APD_End2_Pre-1):(APD_Start1_Pre)])
        Cai_ED2_Pre = np.min(Cai_Pre[(APD_End3_Pre-1):(APD_Start2_Pre)])
    else:
        Cai_Max1_Pre = np.max(Cai_Pre[(APD_Start2_Pre-1):(APD_End1_Pre)])
        Cai_Max2_Pre = np.max(Cai_Pre[(APD_Start3_Pre-1):(APD_End2_Pre)])
        Cai_ED1_Pre = np.min(Cai_Pre[(APD_End1_Pre-1):(APD_Start1_Pre)])
        Cai_ED2_Pre = np.min(Cai_Pre[(APD_End2_Pre-1):(APD_Start2_Pre)])

    if(not(inAPD_Post)):
        Cai_Max1_Post = np.max(Cai_Post[(APD_Start2_Post-1):(APD_End2_Post)])
        Cai_Max2_Post = np.max(Cai_Post[(APD_Start3_Post-1):(APD_End3_Post)])
        Cai_ED1_Post = np.min(Cai_Post[(APD_End2_Post-1):(APD_Start1_Post)])
        Cai_ED2_Post = np.min(Cai_Post[(APD_End3_Post-1):(APD_Start2_Post)])
    else:
        Cai_Max1_Post = np.max(Cai_Post[(APD_Start2_Post-1):(APD_End1_Post)])
        Cai_Max2_Post = np.max(Cai_Post[(APD_Start3_Post-1):(APD_End2_Post)])
        Cai_ED1_Post = np.min(Cai_Post[(APD_End1_Post-1):(APD_Start1_Post)])
        Cai_ED2_Post = np.min(Cai_Post[(APD_End2_Post-1):(APD_Start2_Post)])

    #Plot and print the results to better understand what is going on in these special cases.
    plt.figure()
    plt.subplot(2,2,1)
    plt.plot(Cai_Pre)
    plt.xlabel("Time (ms)")
    plt.ylabel("Cai (microM)")
    plt.title("Before Alternans for Baseline " + str(ID[j]))

    plt.axhline(Cai_Max1_Pre,color=(0,0,0))
    plt.axhline(Cai_Max2_Pre,color=(0,0,0))
    plt.axhline(Cai_ED1_Pre,color=(0,0,0))
    plt.axhline(Cai_ED2_Pre,color=(0,0,0))

    plt.axvline(APD_Start1_Pre,color=(0,0,0))
    plt.axvline(APD_Start2_Pre,color=(0,0,0))
    plt.axvline(APD_Start3_Pre,color=(0,0,0))
    plt.axvline(APD_End3_Pre,color=(0,0,0))
    plt.axvline(APD_End1_Pre,color=(0,0,0))
    plt.axvline(APD_End2_Pre,color=(0,0,0))

    plt.subplot(2,2,2)
    plt.plot(Cai_Post)
    plt.xlabel("Time (ms)")
    plt.ylabel("Cai (microM)")
    plt.title("After Alternans for Baseline " + str(ID[j]))

    plt.axhline(Cai_Max1_Post,color=(0,0,0))
    plt.axhline(Cai_Max2_Post,color=(0,0,0))
    plt.axhline(Cai_ED1_Post,color=(0,0,0))
    plt.axhline(Cai_ED2_Post,color=(0,0,0))

    plt.axvline(APD_Start1_Post,color=(0,0,0))
    plt.axvline(APD_Start2_Post,color=(0,0,0))
    plt.axvline(APD_Start3_Post,color=(0,0,0))
    plt.axvline(APD_End3_Post,color=(0,0,0))
    plt.axvline(APD_End1_Post,color=(0,0,0))
    plt.axvline(APD_End2_Post,color=(0,0,0))

    plt.subplot(2,2,3)
    plt.plot(Vm_Pre)
    plt.axhline(Thresh_Pre,color=(0,0,0))
    plt.xlabel("Time (ms)")
    plt.ylabel("Vm (mV)")
    plt.title("Before Alternans for Baseline " + str(ID[j]))

    plt.axvline(APD_Start1_Pre,color=(0,0,0))
    plt.axvline(APD_Start2_Pre,color=(0,0,0))
    plt.axvline(APD_Start3_Pre,color=(0,0,0))
    plt.axvline(APD_End3_Pre,color=(0,0,0))
    plt.axvline(APD_End1_Pre,color=(0,0,0))
    plt.axvline(APD_End2_Pre,color=(0,0,0))


    plt.subplot(2,2,4)
    plt.plot(Vm_Post)
    plt.axhline(Thresh_Post,color=(0,0,0))
    plt.ylabel("Vm (mV)")
    plt.xlabel("Time (ms)")
    plt.title("After Alternans for Baseline " + str(ID[j]))

    plt.axvline(APD_Start1_Post,color=(0,0,0))
    plt.axvline(APD_Start2_Post,color=(0,0,0))
    plt.axvline(APD_Start3_Post,color=(0,0,0))
    plt.axvline(APD_End3_Post,color=(0,0,0))
    plt.axvline(APD_End1_Post,color=(0,0,0))
    plt.axvline(APD_End2_Post,color=(0,0,0))
    plt.show()
    print("Before Threshold for Individual: " + str(j) + "\t CaT1 = " + str(Cai_Max1_Pre - Cai_ED1_Pre) + "\t CaT2 = " + str(Cai_Max2_Pre - Cai_ED2_Pre))
    print("After Threshold for Individual: " + str(j) + "\t CaT1 = " + str(Cai_Max1_Post - Cai_ED1_Post) + "\t CaT2 = " + str(Cai_Max2_Post - Cai_ED2_Post))
    j = j + 1
    