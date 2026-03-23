%% Read the data needed to generate the time course traces of the AP, cytoplasmic calcium transient, and non-junctional SR calcium transient.
Baseline = readmatrix("Outcomes_t/Baseline.txt");

%% Compute the thresholds that need to be incorporated into the figure.
BaselineThreshold1 = (max(Baseline(:,10)) - min(Baseline(:,10)))*0.1 + min(Baseline(:,10));
BaselineThreshold2 = (max(Baseline(:,13)) - min(Baseline(:,13)))*0.5 + min(Baseline(:,13));
BaselineThreshold3 = (max(Baseline(:,13)) - min(Baseline(:,13)))*exp(-1) + min(Baseline(:,13));
BaselineThreshold4 = (max(Baseline(:,13)) - min(Baseline(:,13)))*0.1 + min(Baseline(:,13));

%% Plot the time course traces and thresholds.
figure(1)
clf
subplot(3,1,1)
plot(Baseline(:,10),"LineWidth",2)
xlabel("Time (ms)")
ylabel("Vm (mV)")
set(gca,"FontSize", 16)
yline(BaselineThreshold1,"LineWidth",2,"LineStyle",":")
yline(max(Baseline(:,10)),"LineWidth",2,"LineStyle",":")
yline(min(Baseline(:,10)),"LineWidth",2,"LineStyle",":")
xlim([0,1000])

subplot(3,1,2)
plot(Baseline(:,13),"LineWidth",2)
xlabel("Time (ms)")
ylabel("[Ca^{2+}]_i ({\mu}M)")
set(gca,"FontSize", 16)
yline(BaselineThreshold2,"LineWidth",2,"LineStyle",":")
yline(BaselineThreshold3,"LineWidth",2,"LineStyle",":")
yline(BaselineThreshold4,"LineWidth",2,"LineStyle",":")
yline(max(Baseline(:,13)),"LineWidth",2,"LineStyle",":")
yline(min(Baseline(:,13)),"LineWidth",2,"LineStyle",":")
xlim([0,1000])

subplot(3,1,3)
plot(Baseline(:,14)/0.06/1000,"LineWidth",2)
xlabel("Time (ms)")
ylabel("[Ca^{2+}]_{SR} (mM)")
set(gca,"FontSize", 16)
yline(max(Baseline(:,14)/0.06/1000),"LineWidth",2,"LineStyle",":")
yline(min(Baseline(:,14)/0.06/1000),"LineWidth",2,"LineStyle",":")
xlim([0,1000])