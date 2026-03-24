%% Load the necessary data
AP_Traces_Baseline = readmatrix("AP_Traces_Baseline.txt");
Ca_Traces_Baseline = readmatrix("Ca_Traces_Baseline.txt")/1000;

%% Eliminate the individuals who failed in the alternans analysis. See Folders 6-10 for details.
ExclusionIndex = unique([23,50,119,147,203,312,313,411,452,458,519,599,726,829,913,943,970]);
a = [];

for i = 1:1001
    if(any(i == ExclusionIndex))
        a = [a,i];
    end
end
AP_Traces_Baseline(a,:) = [];
Ca_Traces_Baseline(a,:) = [];


%% Plot the data.
figure(1)
clf
plot(AP_Traces_Baseline(2:end,:)', "Color",[0.7,0.7,0.9],"LineWidth",2)
hold on
plot(AP_Traces_Baseline(1,:)', "Color",[0,0,1],"LineWidth",2)
xlim([390,1190])
xlabel("Time (ms)")
ylabel("Vm (mV)")
set(gca,"FontSize",20)

figure(2)
clf
plot(Ca_Traces_Baseline(2:end,:)', "Color",[0.7,0.7,0.9],"LineWidth",2)
hold on
plot(Ca_Traces_Baseline(1,:)', "Color",[0,0,1],"LineWidth",2)
xlim([390,1190])
xlabel("Time (ms)")
ylabel("[Ca^{2+}]_i ({\mu}M)")
set(gca,"FontSize",20)