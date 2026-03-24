%% Load the necessary data and extract the target BCLs. Note that it may be necessary to change the paths to get the code to run properly.
Baseline = "Outcomes_t/Baseline.txt";
Baseline = readmatrix(Baseline);
Baseline400 = Baseline((Baseline(:,1) == 400),:);
Baseline300 = Baseline((Baseline(:,1) == 300),:);
Baseline250 = Baseline((Baseline(:,1) == 250),:);
Baseline200 = Baseline((Baseline(:,1) == 200),:);

Baseline = "D:\Manuscript Code\Folder 5 - Bifurcation Diagram Generation (Stage 2; Short)/Outcomes_t/Baseline.txt";
Baseline = readmatrix(Baseline);
Baseline400C = Baseline((Baseline(:,1) == 400),:);
Baseline300C = Baseline((Baseline(:,1) == 300),:);
Baseline250C = Baseline((Baseline(:,1) == 250),:);
Baseline200C = Baseline((Baseline(:,1) == 200),:);

Manuscript = "Outcomes_t/Manuscript.txt";
Manuscript = readmatrix(Manuscript);
Manuscript400 = Manuscript((Manuscript(:,1) == 400),:);
Manuscript300 = Manuscript((Manuscript(:,1) == 300),:);
Manuscript250 = Manuscript((Manuscript(:,1) == 250),:);
Manuscript200 = Manuscript((Manuscript(:,1) == 200),:);

Manuscript = "D:\Manuscript Code\Folder 5 - Bifurcation Diagram Generation (Stage 2; Short)/Outcomes_t/Manuscript.txt";
Manuscript = readmatrix(Manuscript);
Manuscript400C = Manuscript((Manuscript(:,1) == 400),:);
Manuscript300C = Manuscript((Manuscript(:,1) == 300),:);
Manuscript250C = Manuscript((Manuscript(:,1) == 250),:);
Manuscript200C = Manuscript((Manuscript(:,1) == 200),:);

%% Compare the clamped action potentials to the simulation on which they are based.
figure(1)
clf
subplot(1,3,1)
plot(Baseline400(:,11))
hold on
plot(Baseline400C(:,11))
xlim([0,1000])
title("BCL = 400ms")
xlabel("Time (ms)")
ylabel("Vm (mV)")

subplot(1,3,2)
plot(Baseline300(:,11))
hold on
plot(Baseline300C(:,11))
xlim([0,1000])
title("BCL = 300ms")
xlabel("Time (ms)")
ylabel("Vm (mV)")

subplot(1,3,3)
plot(Baseline250(:,11))
hold on
plot(Baseline250C(:,11))
xlim([0,1000])
title("BCL = 250ms")
xlabel("Time (ms)")
ylabel("Vm (mV)")

figure(2)
clf
subplot(1,3,1)
plot(Manuscript400(:,11))
hold on
plot(Baseline400C(:,11))
xlim([0,1000])
title("BCL = 400ms")
xlabel("Time (ms)")
ylabel("Vm (mV)")

subplot(1,3,2)
plot(Manuscript300(:,11))
hold on
plot(Baseline300C(:,11))
xlim([0,1000])
title("BCL = 300ms")
xlabel("Time (ms)")
ylabel("Vm (mV)")

subplot(1,3,3)
plot(Manuscript250(:,11))
hold on
plot(Baseline250C(:,11))
xlim([0,1000])
title("BCL = 250ms")
xlabel("Time (ms)")
ylabel("Vm (mV)")