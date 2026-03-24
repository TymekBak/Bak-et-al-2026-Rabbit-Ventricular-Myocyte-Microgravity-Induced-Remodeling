%% Load the necessary data
Baseline = "Outcomes_n/Baseline.txt";
Baseline = readmatrix(Baseline);
BaselineThreshold = readmatrix("AlternansThresholdGuess/Manuscript.txt");

Microgravity = "Outcomes_n/Manuscript.txt";
Microgravity = readmatrix(Microgravity);
MicrogravityThreshold = readmatrix("AlternansThresholdGuess/Manuscript.txt");

%% Extract the action potentials and calcium transient amplitudes
APD1 = zeros(2,21);
APD2 = zeros(2,21);
CaT1 = zeros(2,21);
CaT2 = zeros(2,21);

i = 1;
BCL = 400;
BCLs1 = zeros(1,48);
while(BCL >= 200)
    APD = Baseline(:, 3); APD = APD(Baseline(:,1) == BCL); APD1(:,i) = APD((end-1):end); APD1(:,i) = [max(APD1(:,i)),min(APD1(:,i))];
    CaT = Baseline(:, 4) - Baseline(:, 5); CaT = CaT(Baseline(:,1) == BCL); CaT1(:,i) = CaT((end-1):end); CaT1(:,i) = [max(CaT1(:,i)),min(CaT1(:,i))];
    
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
    CaT = Microgravity(:, 4) - Microgravity(:, 5); CaT = CaT(Microgravity(:,1) == BCL); CaT2(:,i) = CaT((end-1):end); CaT2(:,i) = [max(CaT2(:,i)),min(CaT2(:,i))];
    
    BCLs2(i) = BCL;
    if(abs(BCL - MicrogravityThreshold) < 20)
        BCL = BCL - 1;
    else
        BCL = BCL - 10;
    end
    
    i = i + 1;
end

%% Plot the bifurcation diagrams
figure(1)
clf
plot(BCLs1,APD1,"Color","black","LineStyle","-","LineWidth",2)
hold on
plot(BCLs2,APD2,"Color","black","LineStyle","-","LineWidth",2)
xlabel("BCL (ms)")
ylabel("APD_{90} (ms)")
xlim([250,350])
set(gca,"FontSize",18)

figure(2)
clf
plot(BCLs1,CaT1,"Color","blue","LineStyle","-","LineWidth",2)
hold on
plot(BCLs2,CaT2,"Color","red","LineStyle","-","LineWidth",2)
xlabel("BCL (ms)")
ylabel("{\Delta}[Ca^{2+}]_i ({\mu}M)")
xlim([250,350])
set(gca,"FontSize",18)