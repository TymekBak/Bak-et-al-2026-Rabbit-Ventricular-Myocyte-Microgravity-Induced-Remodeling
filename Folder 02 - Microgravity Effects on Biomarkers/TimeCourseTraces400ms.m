%% Load the necessary data.
Baseline = "Outcomes_t/Baseline.txt";
Baseline = readmatrix(Baseline);
Microgravity = "Outcomes_t/Manuscript.txt";
Microgravity = readmatrix(Microgravity);

%% Extract the data for the calcium transient.
Vm1 = Baseline(:,10);
Vm2 = Microgravity(:,10);
Cai1 = Baseline(:,13);
Cai2 = Microgravity(:,13);

%% Generate the necessary plots.
figure(1)
clf
plot(190:1600,Vm1(190:1600),"Color","blue","LineWidth",2)
hold on
plot([175,175,275],[-50,-100,-100],"LineWidth",2,"Color","Black")
axis off
box off
ylim([-105,max(Vm1)])

figure(2)
clf
plot(190:1600,Vm2(190:1600),"Color","red","LineWidth",2)
hold on
plot(190:1600,Vm1(190:1600),"Color","blue","LineWidth",2)
plot([175,175,275],[-50,-100,-100],"LineWidth",2,"Color","Black")
axis off
box off
ylim([-105,max(Vm1)])

figure(3)
clf
plot(190:1600,Cai1(190:1600),"Color","blue","LineWidth",2)
hold on
plot([175,175,275],[min(Cai2-0.025+0.1),min(Cai2-0.025),min(Cai2-0.025)],"LineWidth",2,"Color","Black")
axis off
box off

figure(4)
clf
plot(190:1600,Cai1(190:1600),"Color","blue","LineWidth",2)
hold on
plot(190:1600,Cai2(190:1600),"Color","red","LineWidth",2)
plot([175,175,275],[min(Cai2-0.025+0.1),min(Cai2-0.025),min(Cai2-0.025)],"LineWidth",2,"Color","Black")
axis off
box off