%% Read the data needed to generate the time course traces.
Baseline = "Outcomes_t/Baseline.txt";
Baseline = readmatrix(Baseline);
Microgravity = "Outcomes_t/Manuscript.txt";
Microgravity = readmatrix(Microgravity);

%% Extract the action potential and calcium transient data for 4Hz pacing.
BCL1 = Baseline(:,1);
BCL2 = Microgravity(:,1);

Vm1 = Baseline((BCL1 == 250),11);
Vm2 = Microgravity((BCL2 == 250),11);
Cai1 = Baseline((BCL1 == 250),14);
Cai2 = Microgravity((BCL2 == 250),14);

%% Plot the necessary data
figure(1)
clf
plot(190:1600,Vm1(190:1600),"Color","black","LineWidth",2)
hold on
plot([175,175,275],[-50,-100,-100],"LineWidth",2,"Color","Black")
axis off
box off
ylim([-105,max(Vm1)])

figure(2)
clf
plot(190:1600,Vm2(190:1600),"Color","red","LineWidth",2)
hold on
plot([175,175,275],[-50,-100,-100],"LineWidth",2,"Color","Black")
axis off
box off
ylim([-105,max(Vm1)])

figure(3)
clf
plot(190:1600,Cai1(190:1600),"Color","blue","LineWidth",2)
hold on
plot([175,175,275],[min(Cai2-0.025+0.5),min(Cai2-0.025),min(Cai2-0.025)],"LineWidth",2,"Color","Black")
axis off
box off
ylim([min(Cai2-0.05),max(Cai2+0.05)])

figure(4)
clf
plot(190:1600,Cai2(190:1600),"Color","red","LineWidth",2)
hold on
plot([175,175,275],[min(Cai2-0.025+0.5),min(Cai2-0.025),min(Cai2-0.025)],"LineWidth",2,"Color","Black")
axis off
box off
ylim([min(Cai2-0.05),max(Cai2+0.05)])