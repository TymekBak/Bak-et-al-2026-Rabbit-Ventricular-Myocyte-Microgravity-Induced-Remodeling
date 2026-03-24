%% Load the necessary data
Baseline = "Outcomes_t/Baseline.txt";
Baseline = readmatrix(Baseline);
Microgravity = "Outcomes_t/Manuscript.txt";
Microgravity = readmatrix(Microgravity);

%% Extract the parameters of interest
BCL1 = Baseline(:,1);
BCL2 = Microgravity(:,1);

Vm1 = Baseline((BCL1 == 250),11);
Vm2 = Microgravity((BCL2 == 250),11);
Cai1 = Baseline((BCL1 == 250),14);
Cai2 = Microgravity((BCL2 == 250),14);

%% Create the necessary plots
figure(1)
clf
plot(5:1500,Vm1((end-1495):end),"Color","blue","LineWidth",2)
hold on
plot([5,5,105],[-40,-90,-90],"LineWidth",2,"Color","Black")
axis off
box off

figure(2)
clf
plot(5:1500,Vm2((end-1495):end),"Color","red","LineWidth",2)
hold on
plot([5,5,105],[-40,-90,-90],"LineWidth",2,"Color","Black")
axis off
box off

figure(3)
clf
plot(5:1500,Cai1((end-1495):end),"Color","blue","LineWidth",2)
hold on
plot([5,5,105],[0.6,0.1,0.1],"LineWidth",2,"Color","Black")
axis off
box off

figure(4)
clf
plot(5:1500,Cai2((end-1495):end),"Color","red","LineWidth",2)
hold on
plot([5,5,105],[0.6,0.1,0.1],"LineWidth",2,"Color","Black")
axis off
box off