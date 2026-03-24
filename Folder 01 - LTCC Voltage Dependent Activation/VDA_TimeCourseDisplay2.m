%% Read the simulation output into MATLAB variables.
Baseline = readmatrix("Results2/Baseline.txt");
Manuscript = readmatrix("Results2/Model6.txt");

%% Store the membrane potential and LTCC current traces in smaller variables.
Vm1 = zeros(110000,111);
Vm2 = zeros(110000,111);
ILTCC1 = zeros(110000,111);
ILTCC2 = zeros(110000,111);

Vm1(:) = Baseline(:,10);
Vm2(:) = Manuscript(:,10);
ILTCC1(:) = Baseline(:,28);
ILTCC2(:) = Manuscript(:,28);

%% Plot the membrane potential and LTCC current traces.
figure(1)
clf
plot(Vm1((end-9999):end,1:25:end),"Color","black","LineWidth",2)
set(gca,"FontSize",20)
a = breakxaxis([1000,9600],0);
set(a.leftAxes,"FontSize",20,"XTick",0:200:1000)
set(a.rightAxes,"FontSize",20,"XTick",9800:200:10000)

figure(2)
clf
plot(ILTCC1((end-9999):end,1:25:end),"Color","black","LineWidth",2)
set(gca,"FontSize",20)
a = breakxaxis([1000,9600],0);
set(a.leftAxes,"FontSize",20,"XTick",0:200:1000)
set(a.rightAxes,"FontSize",20,"XTick",9800:200:10000)

%% Extract the peak LTCC current and the LTCC conductance that is associated with it.
Baseline2 = readmatrix("Results1/Baseline.txt");
Manuscript2 = readmatrix("Results1/Model6.txt");

%% Generate the Current-Voltage and Activation Plots for the computational model before and after reparametrization.
figure(3)
clf
plot(Baseline2(:,1),Baseline2(:,2), "LineWidth",2,"Color","blue")
hold on
plot(Manuscript2(:,1),Manuscript2(:,2), "LineWidth",2,"Color","red")
%xlabel("Vm (mV)")
%ylabel("I_{LTCC,max} (A/F)")
xlim([-50,60])
set(gca,"FontSize",20)

figure(4)
clf
plot(Baseline2(:,1),Baseline2(:,3)/Baseline2(end,3), "LineWidth",2,"Color","blue")
hold on
plot(Manuscript2(:,1),Manuscript2(:,3)/Manuscript2(end,3), "LineWidth",2,"Color","red")
%xlabel("Vm (mV)")
%ylabel("G/G_{max}")
xlim([-50,60])
set(gca,"FontSize",20)