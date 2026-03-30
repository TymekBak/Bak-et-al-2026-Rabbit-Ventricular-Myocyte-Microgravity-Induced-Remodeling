import pathlib
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate
import pandas

#Define a function that extracts the input and output data for a specific individual (beat A).
def ExtractIndividual(i,version):
    path = "Individuals/" + version + "_P" + str(i) + ".txt"
    a = pathlib.Path(path)
    C0 = np.loadtxt(a)
    C0 = np.transpose(C0)
    path = "Outcomes_n/" + version + "_P" + str(i) + ".txt"
    a = pathlib.Path(path)
    Cn = np.loadtxt(a)
    Cn = Cn[len(Cn) - 1]
    C = np.append(C0,Cn[1:len(Cn)])
    return(C)

#Use the ExtractIndividual() to create a DataFrame and a .csv summary file for the simulation results.
p = np.array(["g_{RyR}","u","v_{up}","[Ca^{2+}]_{up}","g_{LTCC}","v_{th}","g_{to,s}","g_{to,f}","g_{NaCa}","g_{Ks}","g_{Kr}","g_{Na}","g_{K1}","g_{NaK}","g_{leak}","APD", "Cai_{max}", "Cai_{min}", "CaSR_{max}", "CaSR_{min}", "Nai_{max}", "Nai_{min}", "CaTD_{50}", "TTP"])
values = np.zeros((1001,len(p)))
print(len(p))
i = 0
DataFrame = dict()

while(i <= 1000):
    values[i] = ExtractIndividual(i, "Baseline")
    i = i + 1

values = np.transpose(values)
i = 0
while(i < len(p)):
    DataFrame[p[i]] = values[i]
    i = i + 1

DataFrame = pandas.DataFrame(DataFrame)
print(DataFrame)
DataFrame.to_csv("SimulationData_BCL400A.csv")

#Define a function that extracts the input and output data for a specific individual (beat B). This is repeated so that any alternans that are present do not influence the results.
def ExtractIndividual(i,version):
    path = "Individuals/" + version + "_P" + str(i) + ".txt"
    a = pathlib.Path(path)
    C0 = np.loadtxt(a)
    C0 = np.transpose(C0)
    path = "Outcomes_n/" + version + "_P" + str(i) + ".txt"
    a = pathlib.Path(path)
    Cn = np.loadtxt(a)
    Cn = Cn[len(Cn) - 2]
    C = np.append(C0,Cn[1:len(Cn)])
    return(C)

#Use the ExtractIndividual() to create a DataFrame and a .csv summary file for the simulation results.
values = np.zeros((1001,len(p)))
print(len(p))
i = 0
DataFrame = dict()

while(i <= 1000):
    values[i] = ExtractIndividual(i, "Baseline")
    i = i + 1

values = np.transpose(values)
i = 0
while(i < len(p)):
    DataFrame[p[i]] = values[i]
    i = i + 1

DataFrame = pandas.DataFrame(DataFrame)
print(DataFrame)
DataFrame.to_csv("SimulationData_BCL400B.csv")
