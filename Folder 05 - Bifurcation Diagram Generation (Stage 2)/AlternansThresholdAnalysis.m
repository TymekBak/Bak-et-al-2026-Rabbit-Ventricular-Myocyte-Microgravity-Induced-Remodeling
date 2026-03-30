%% Transcribe the values from the simulation to plot the result.
Model = ["Baseline", "Microgravity","g_{RyR}","g_{leak}","Kmf_{SERCA}","g_{LTCC}", "v_{th}","g_{NaK}"];
APD_Alternans_A1 = [239,263,248,239,238,256,250,238];
CaT_Alternans_A1 = [243,277,256,244,243,262,255,242];
APD_Alternans_A2 = [239,263,250,262,265,249,269,265];
CaT_Alternans_A2 = [243,277,261,276,278,260,278,280];

%% Plot the results
figure(1)
clf
subplot(1,2,1)
a = bar(Model(3:end),APD_Alternans_A1(3:end),"LineStyle","none");
a.FaceAlpha = 0.5;
yline(APD_Alternans_A1(1),"-",Model(1),"FontWeight","bold","FontSize",24,"Color","Blue","LineWidth",3)
yline(APD_Alternans_A1(2),"-",Model(2),"FontWeight","bold","FontSize",24,"Color","Red","LineWidth",3)
ylim([230,290])
set(gca,"FontSize",24)
ylabel("Alternans Threshold BCL (ms)","FontSize",24)


subplot(1,2,2)
a = bar(Model(3:end),CaT_Alternans_A1(3:end),"LineStyle","none");
a.FaceAlpha = 0.5;
yline(CaT_Alternans_A1(1),"-",Model(1),"FontWeight","bold","FontSize",24,"Color","Blue","LineWidth",3)
yline(CaT_Alternans_A1(2),"-",Model(2),"FontWeight","bold","FontSize",24,"Color","Red","LineWidth",3)
ylim([230,290])
set(gca,"FontSize",24)
ylabel("Alternans Threshold BCL (ms)","FontSize",24)

figure(2)
clf
subplot(1,2,1)
a = bar(Model(3:end),APD_Alternans_A2(3:end),"LineStyle","none");
a.FaceAlpha = 0.5;
yline(APD_Alternans_A2(1),"-",Model(1),"FontWeight","bold","FontSize",24,"Color","Blue","LineWidth",3)
yline(APD_Alternans_A2(2),"-",Model(2),"FontWeight","bold","FontSize",24,"Color","Red","LineWidth",3)
ylim([230,290])
ylabel("Alternans Threshold BCL (ms)","FontSize",24)
set(gca,"FontSize",24)

subplot(1,2,2)
a = bar(Model(3:end),CaT_Alternans_A2(3:end),"LineStyle","none");
a.FaceAlpha = 0.5;
yline(CaT_Alternans_A2(1),"-",Model(1),"FontWeight","bold","FontSize",24,"Color","Blue","LineWidth",3)
yline(CaT_Alternans_A2(2),"-",Model(2),"FontWeight","bold","FontSize",24,"Color","Red","LineWidth",3)
ylim([230,290])
ylabel("Alternans Threshold BCL (ms)","FontSize",24)
set(gca,"FontSize",24)
