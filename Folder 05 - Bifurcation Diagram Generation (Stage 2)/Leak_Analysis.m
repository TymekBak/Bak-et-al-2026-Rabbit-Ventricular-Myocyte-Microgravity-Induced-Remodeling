%% Load the necessary data.
Baseline = "Outcomes_n/Baseline.txt";
Baseline = readmatrix(Baseline);
BaselineThreshold = readmatrix("AlternansThresholdGuess/Baseline.txt");

Microgravity = "Outcomes_n/Manuscript.txt";
Microgravity = readmatrix(Microgravity);
MicrogravityThreshold = readmatrix("AlternansThresholdGuess/Manuscript.txt");

Baseline_Perturbation = "Outcomes_n/Baseline_V2.txt";
Baseline_Perturbation = readmatrix(Baseline_Perturbation);
Baseline_PerturbationThreshold = readmatrix("AlternansThresholdGuess/Baseline_V2.txt");

Microgravity_Perturbation = "Outcomes_n/Manuscript_V2.txt";
Microgravity_Perturbation = readmatrix(Microgravity_Perturbation);
Microgravity_PerturbationThreshold = readmatrix("AlternansThresholdGuess/Manuscript_V2.txt");

%% Prepare the variables for storing the parameters of interest.
APD1 = zeros(2,21);
APD2 = zeros(2,21);
APD3 = zeros(2,21);
APD4 = zeros(2,21);

Cai_max1 = zeros(2,21);
Cai_max2 = zeros(2,21);
Cai_max3 = zeros(2,21);
Cai_max4 = zeros(2,21);

Cai_min1 = zeros(2,21);
Cai_min2 = zeros(2,21);
Cai_min3 = zeros(2,21);
Cai_min4 = zeros(2,21);

CaSR_max1 = zeros(2,21);
CaSR_max2 = zeros(2,21);
CaSR_max3 = zeros(2,21);
CaSR_max4 = zeros(2,21);

CaTD50_1 = zeros(2,21);
CaTD50_2 = zeros(2,21);
CaTD50_3 = zeros(2,21);
CaTD50_4 = zeros(2,21);

%% Extract the relevant data.
i = 1;
BCL = 400;
BCLs1 = zeros(1,48);
while(BCL >= 200)
    APD = Baseline(:, 3); APD = APD(Baseline(:,1) == BCL); APD1(:,i) = APD((end-1):end); APD1(:,i) = [max(APD1(:,i)),min(APD1(:,i))];
    Cai_max = Baseline(:, 4); Cai_max = Cai_max(Baseline(:,1) == BCL); Cai_max1(:,i) = Cai_max((end-1):end); Cai_max1(:,i) = [max(Cai_max1(:,i)),min(Cai_max1(:,i))];
    Cai_min = Baseline(:, 5); Cai_min = Cai_min(Baseline(:,1) == BCL); Cai_min1(:,i) = Cai_min((end-1):end); Cai_min1(:,i) = [max(Cai_min1(:,i)),min(Cai_min1(:,i))];
    CaSR_max = Baseline(:, 6); CaSR_max = CaSR_max(Baseline(:,1) == BCL); CaSR_max1(:,i) = CaSR_max((end-1):end); CaSR_max1(:,i) = [max(CaSR_max1(:,i)),min(CaSR_max1(:,i))];
    CaTD50 = Baseline(:, 10); CaTD50 = CaTD50(Baseline(:,1) == BCL); CaTD50_1(:,i) = CaTD50((end-1):end); CaTD50_1(:,i) = [max(CaTD50_1(:,i)),min(CaTD50_1(:,i))];
    
    BCLs1(i) = BCL;
    if(abs(BCL - BaselineThreshold) < 20)
        BCL = BCL - 1;
    else
        BCL = BCL - 10;
    end
    
    i = i + 1;
end

i = 1;
BCL = 400;
BCLs2 = zeros(1,48);
while(BCL >= 200)
    APD = Microgravity(:, 3); APD = APD(Microgravity(:,1) == BCL); APD2(:,i) = APD((end-1):end); APD2(:,i) = [max(APD2(:,i)),min(APD2(:,i))];
    Cai_max = Microgravity(:, 4); Cai_max = Cai_max(Microgravity(:,1) == BCL); Cai_max2(:,i) = Cai_max((end-1):end); Cai_max2(:,i) = [max(Cai_max2(:,i)),min(Cai_max2(:,i))];
    Cai_min = Microgravity(:, 5); Cai_min = Cai_min(Microgravity(:,1) == BCL); Cai_min2(:,i) = Cai_min((end-1):end); Cai_min2(:,i) = [max(Cai_min2(:,i)),min(Cai_min2(:,i))];
    CaSR_max = Microgravity(:, 6); CaSR_max = CaSR_max(Microgravity(:,1) == BCL); CaSR_max2(:,i) = CaSR_max((end-1):end); CaSR_max2(:,i) = [max(CaSR_max2(:,i)),min(CaSR_max2(:,i))];
    CaTD50 = Microgravity(:, 10); CaTD50 = CaTD50(Microgravity(:,1) == BCL); CaTD50_2(:,i) = CaTD50((end-1):end); CaTD50_2(:,i) = [max(CaTD50_2(:,i)),min(CaTD50_2(:,i))];
    
    BCLs2(i) = BCL;
    if(abs(BCL - MicrogravityThreshold) < 20)
        BCL = BCL - 1;
    else
        BCL = BCL - 10;
    end
    
    i = i + 1;
end

i = 1;
BCL = 400;
BCLs3 = zeros(1,48);
while(BCL >= 200)
    APD = Baseline_Perturbation(:, 3); APD = APD(Baseline_Perturbation(:,1) == BCL); APD3(:,i) = APD((end-1):end); APD3(:,i) = [max(APD3(:,i)),min(APD3(:,i))];
    Cai_max = Baseline_Perturbation(:, 4); Cai_max = Cai_max(Baseline_Perturbation(:,1) == BCL); Cai_max3(:,i) = Cai_max((end-1):end); Cai_max3(:,i) = [max(Cai_max3(:,i)),min(Cai_max3(:,i))];
    Cai_min = Baseline_Perturbation(:, 5); Cai_min = Cai_min(Baseline_Perturbation(:,1) == BCL); Cai_min3(:,i) = Cai_min((end-1):end); Cai_min3(:,i) = [max(Cai_min3(:,i)),min(Cai_min3(:,i))];
    CaSR_max = Baseline_Perturbation(:, 6); CaSR_max = CaSR_max(Baseline_Perturbation(:,1) == BCL); CaSR_max3(:,i) = CaSR_max((end-1):end); CaSR_max3(:,i) = [max(CaSR_max3(:,i)),min(CaSR_max3(:,i))];
    CaTD50 = Baseline_Perturbation(:, 10); CaTD50 = CaTD50(Baseline_Perturbation(:,1) == BCL); CaTD50_3(:,i) = CaTD50((end-1):end); CaTD50_3(:,i) = [max(CaTD50_3(:,i)),min(CaTD50_3(:,i))];
    
    BCLs3(i) = BCL;
    if(abs(BCL - Baseline_PerturbationThreshold) < 20)
        BCL = BCL - 1;
    else
        BCL = BCL - 10;
    end
    
    i = i + 1;
end

i = 1;
BCL = 400;
BCLs4 = zeros(1,48);
while(BCL >= 200)
    APD = Microgravity_Perturbation(:, 3); APD = APD(Microgravity_Perturbation(:,1) == BCL); APD4(:,i) = APD((end-1):end); APD4(:,i) = [max(APD4(:,i)),min(APD4(:,i))];
    Cai_max = Microgravity_Perturbation(:, 4); Cai_max = Cai_max(Microgravity_Perturbation(:,1) == BCL); Cai_max4(:,i) = Cai_max((end-1):end); Cai_max4(:,i) = [max(Cai_max4(:,i)),min(Cai_max4(:,i))];
    Cai_min = Microgravity_Perturbation(:, 5); Cai_min = Cai_min(Microgravity_Perturbation(:,1) == BCL); Cai_min4(:,i) = Cai_min((end-1):end); Cai_min4(:,i) = [max(Cai_min4(:,i)),min(Cai_min4(:,i))];
    CaSR_max = Microgravity_Perturbation(:, 6); CaSR_max = CaSR_max(Microgravity_Perturbation(:,1) == BCL); CaSR_max4(:,i) = CaSR_max((end-1):end); CaSR_max4(:,i) = [max(CaSR_max4(:,i)),min(CaSR_max4(:,i))];
    CaTD50 = Microgravity_Perturbation(:, 10); CaTD50 = CaTD50(Microgravity_Perturbation(:,1) == BCL); CaTD50_4(:,i) = CaTD50((end-1):end); CaTD50_4(:,i) = [max(CaTD50_4(:,i)),min(CaTD50_4(:,i))];
    
    BCLs4(i) = BCL;
    if(abs(BCL - Microgravity_PerturbationThreshold) < 20)
        BCL = BCL - 1;
    else
        BCL = BCL - 10;
    end
    
    i = i + 1;
end

%% Plot the biomarkers as a function of BCL.
figure(1)
clf
subplot(1,5,1)
plot(BCLs1,APD1,"Color","blue","LineStyle","-","LineWidth",2)
hold on
plot(BCLs3,APD3,"Color","blue","LineStyle","--","LineWidth",2)
plot(BCLs2,APD2,"Color","red","LineStyle","-","LineWidth",2)
plot(BCLs4,APD4,"Color","red","LineStyle","--","LineWidth",2)
xlabel("BCL (ms)")
ylabel("APD (ms)")
xlim([300,400])
ylim([150,200])
set(gca,"FontSize",18)

subplot(1,5,2)
plot(BCLs1,Cai_max1,"Color","blue","LineStyle","-","LineWidth",2)
hold on
plot(BCLs3,Cai_max3,"Color","blue","LineStyle","--","LineWidth",2)
plot(BCLs2,Cai_max2,"Color","red","LineStyle","-","LineWidth",2)
plot(BCLs4,Cai_max4,"Color","red","LineStyle","--","LineWidth",2)
xlabel("BCL (ms)")
ylabel("[Ca^{2+}]_{i,max} ({\mu}M)")
xlim([300,400])
ylim([0.5,1.5])
set(gca,"FontSize",18)

subplot(1,5,3)
plot(BCLs1,Cai_min1,"Color","blue","LineStyle","-","LineWidth",2)
hold on
plot(BCLs3,Cai_min3,"Color","blue","LineStyle","--","LineWidth",2)
plot(BCLs2,Cai_min2,"Color","red","LineStyle","-","LineWidth",2)
plot(BCLs4,Cai_min4,"Color","red","LineStyle","--","LineWidth",2)
xlabel("BCL (ms)")
ylabel("[Ca^{2+}]_{i,min} ({\mu}M)")
xlim([300,400])
ylim([0.2,0.5])
set(gca,"FontSize",18)

subplot(1,5,4)
plot(BCLs1,CaSR_max1/0.06/1000,"Color","blue","LineStyle","-","LineWidth",2)
hold on
plot(BCLs3,CaSR_max3/0.06/1000,"Color","blue","LineStyle","--","LineWidth",2)
plot(BCLs2,CaSR_max2/0.06/1000,"Color","red","LineStyle","-","LineWidth",2)
plot(BCLs4,CaSR_max4/0.06/1000,"Color","red","LineStyle","--","LineWidth",2)
xlabel("BCL (ms)")
ylabel("[Ca^{2+}]_{SR,max} (mM)")
xlim([300,400])
ylim([1.5,2])
set(gca,"FontSize",18)

subplot(1,5,5)
plot(BCLs1,CaTD50_1,"Color","blue","LineStyle","-","LineWidth",2)
hold on
plot(BCLs3,CaTD50_3,"Color","blue","LineStyle","--","LineWidth",2)
plot(BCLs2,CaTD50_2,"Color","red","LineStyle","-","LineWidth",2)
plot(BCLs4,CaTD50_4,"Color","red","LineStyle","--","LineWidth",2)
xlabel("BCL (ms)")
ylabel("CaTD_{50} (ms)")
ylim([50,150])
xlim([300,400])
set(gca,"FontSize",18)

%% Load the necessary data.
Baseline = "Outcomes_t/Baseline.txt";
Baseline = readmatrix(Baseline);
Baseline = Baseline((Baseline(:,1) == 400),:);

Microgravity = "Outcomes_t/Manuscript.txt";
Microgravity = readmatrix(Microgravity);
Microgravity = Microgravity((Microgravity(:,1) == 400),:);

Baseline_Perturbation = "Outcomes_t/Baseline_V2.txt";
Baseline_Perturbation = readmatrix(Baseline_Perturbation);
Baseline_Perturbation = Baseline_Perturbation((Baseline_Perturbation(:,1) == 400),:);

Microgravity_Perturbation = "Outcomes_t/Manuscript_V2.txt";
Microgravity_Perturbation = readmatrix(Microgravity_Perturbation);
Microgravity_Perturbation = Microgravity_Perturbation((Microgravity_Perturbation(:,1) == 400),:);

%% Plot the parameters of interest. 
figure(7)
clf
subplot(3,1,1)
plot(-8999:1000,Baseline(:,11),"Color","blue","LineStyle","-","LineWidth",2)
hold on
plot(-8999:1000,Baseline_Perturbation(:,11),"Color","blue","LineStyle","--","LineWidth",2)
plot([1,1,101],[-38,-88,-88],"Color","black","LineStyle","-","LineWidth",5)
xlabel("t (ms)")
ylabel("Vm (mV)")
xlim([0,1000])
ylim([-90,150])
set(gca,"FontSize",16)
box off
axis off

subplot(3,1,2)
plot(-8999:1000,Baseline(:,14),"Color","blue","LineStyle","-","LineWidth",2)
hold on
plot(-8999:1000,Baseline_Perturbation(:,14),"Color","blue","LineStyle","--","LineWidth",2)
plot([1,1,101],[0.21,0.01,0.01],"Color","black","LineStyle","-","LineWidth",5)
xlabel("t (ms)")
ylabel("[Ca^{2+}]_i ({\mu}M)")
xlim([0,1000])
ylim([0,1])
set(gca,"FontSize",16)
box off
axis off

subplot(3,1,3)
plot(-8999:1000,Baseline(:,15)/0.06/1000,"Color","blue","LineStyle","-","LineWidth",2)
hold on
plot(-8999:1000,Baseline_Perturbation(:,15)/0.06/1000,"Color","blue","LineStyle","--","LineWidth",2)
plot([1,1,101],[1.21,1.01,1.01],"Color","black","LineStyle","-","LineWidth",5)
xlabel("t (ms)")
ylabel("[Ca^{2+}]_{SR} (mM)")
xlim([0,1000])
ylim([1,2])
set(gca,"FontSize",16)
box off
axis off

figure(8)
clf
subplot(3,1,1)
plot(-8999:1000,Microgravity(:,11),"Color","red","LineStyle","-","LineWidth",2)
hold on
plot(-8999:1000,Microgravity_Perturbation(:,11),"Color","red","LineStyle","--","LineWidth",2)
plot([1,1,101],[-38,-88,-88],"Color","black","LineStyle","-","LineWidth",5)
xlabel("t (ms)")
ylabel("Vm (mV)")
xlim([0,1000])
ylim([-90,150])
set(gca,"FontSize",16)
box off
axis off

subplot(3,1,2)
plot(-8999:1000,Microgravity(:,14),"Color","red","LineStyle","-","LineWidth",2)
hold on
plot(-8999:1000,Microgravity_Perturbation(:,14),"Color","red","LineStyle","--","LineWidth",2)
plot([1,1,101],[0.21,0.01,0.01],"Color","black","LineStyle","-","LineWidth",5)
xlabel("t (ms)")
ylabel("[Ca^{2+}]_i ({\mu}M)")
xlim([0,1000])
ylim([0,1])
set(gca,"FontSize",16)
box off
axis off

subplot(3,1,3)
plot(-8999:1000,Microgravity(:,15)/0.06/1000,"Color","red","LineStyle","-","LineWidth",2)
hold on
plot(-8999:1000,Microgravity_Perturbation(:,15)/0.06/1000,"Color","red","LineStyle","--","LineWidth",2)
plot([1,1,101],[1.21,1.01,1.01],"Color","black","LineStyle","-","LineWidth",5)
xlabel("t (ms)")
ylabel("[Ca^{2+}]_{SR} (mM)")
xlim([0,1000])
ylim([1,2])
set(gca,"FontSize",16)
box off
axis off