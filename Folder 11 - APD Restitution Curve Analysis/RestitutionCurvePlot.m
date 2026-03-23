%% Load the necessary data to generate the bifurcation diagram.
Baseline_DI = readmatrix("Baseline_DI_BCL400.txt");
Baseline_APD = readmatrix("Baseline_APD_BCL400.txt");
Microgravity_DI = readmatrix("Microgravity_DI_BCL400.txt");
Microgravity_APD = readmatrix("Microgravity_APD_BCL400.txt");

%% Estimate the formula of the tangent line of the resitution curve at the onset of AP alternans.
Baseline_DI_Threshold = [71.893114585392283,72.893206293951636]; Baseline_APD_Threshold = [1.656681737801169e+02,1.662643243892589e+02]; a = polyfit(Baseline_DI_Threshold,Baseline_APD_Threshold,1);
Microgravity_DI_Threshold = [83.694728083448382,84.689774995866742]; Microgravity_APD_Threshold = [1.782981253451115e+02,1.786392935320750e+02]; b = polyfit(Microgravity_DI_Threshold,Microgravity_APD_Threshold,1);

%% Plot the APD restitution curve for both models.
figure(3)
clf
plot(Baseline_DI,Baseline_APD,"Color",[0,0,1],"LineWidth",2) %APD Restitution Curve (Baseline)
hold on
plot(0:239, 239:-1:0,"Color",[0,0,1],"LineWidth",2) %Combination of all APD,DI Pairs at the Alternans Threshold (Baseline)
plot(0:200, ((0:200).*a(1) + a(2)),"Color",[0,0,1],"LineStyle","--","LineWidth",2) %Tangent Line at Alternans Threshold (Baseline)
plot(Microgravity_DI,Microgravity_APD,"Color",[1,0,0],"LineWidth",2) %APD Restitution Curve (Microgravity)
plot(0:263, 263:-1:0,"Color",[1,0,0],"LineWidth",2) %Combination of all APD,DI Pairs at the Alternans Threshold (Microgravity)
plot(0:200, ((0:200).*b(1) + b(2)),"Color",[1,0,0],"LineStyle","--","LineWidth",2) %Tangent Line at Alternans Threshold (Microgravity)
xlabel("DI_n (ms)")
ylabel("APD_{n+1} (ms)")
set(gca,"FontSize",16)
xlim([0,200])
ylim([70,230])