%% Load the necessary data
Baseline = "Baseline.txt";
Baseline = readmatrix("Outcomes_n/" + Baseline);
BaselineThreshold = readmatrix("AlternansThresholdGuess/Baseline.txt");
Microgravity = "Manuscript.txt";
Microgravity = readmatrix("Outcomes_n/" + Microgravity);
MicrogravityThreshold = readmatrix("AlternansThresholdGuess/Manuscript.txt");

%% Extract the APD and calcium transient amplitude values 
APD1 = zeros(2,48);
APD2 = zeros(2,48);
CaT1 = zeros(2,48);
CaT2 = zeros(2,48);

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
plot(BCLs1,APD1,"Color","blue","LineWidth",2)
hold on
plot(BCLs2,APD2,"Color","red","LineWidth",2)
xlabel("BCL (ms)")
ylabel("APD_{90} (ms)")

figure(2)
clf
plot(BCLs1,CaT1,"Color","blue","LineWidth",2)
hold on
plot(BCLs2,CaT2,"Color","red","LineWidth",2)
xlabel("BCL (ms)")
ylabel("{\Delta}[Ca^{2+}]_i ({\mu}M)")

%% Compute and record the alternans thresholds (Baseline)
Alternans1 = abs(APD1(1,:) - APD1(2,:));
Alternans2 = abs(CaT1(1,:) - CaT1(2,:));
Threshold = 0;

for i = 1:length(BCLs1)
    if(Alternans1(i) >= 5)
        Threshold1 = BCLs1(i);
        break

    end
end
for i = 1:length(BCLs1)
    if(Alternans2(i) >= 0.01)
        Threshold2 = BCLs1(i);
        break
    end
end

writematrix([Threshold1,Threshold2],"AlternansThresholds/Baseline.txt");

%% Compute and record the alternans thresholds (Microgravity)
Alternans1 = abs(APD2(1,:) - APD2(2,:));
Alternans2 = abs(CaT2(1,:) - CaT2(2,:));
Threshold = 0;

for i = 1:length(BCLs2)
    if(Alternans1(i) >= 5)
        Threshold1 = BCLs2(i);
        break

    end
end
for i = 1:length(BCLs2)
    if(Alternans2(i) >= 0.01)
        Threshold2 = BCLs2(i);
        break
    end
end

writematrix([Threshold1,Threshold2],"AlternansThresholds/Manuscript.txt");

%% Repeat the analysis for the baseline model variations.
clear all
for n = 1:6
    %% Load the necessary data
    Individual = "Baseline_V" + int2str(n) + ".txt";
    Individual = readmatrix("Outcomes_n/" + Individual);
    IndividualThreshold = readmatrix("AlternansThresholdGuess/" + "Baseline_V" + int2str(n) + ".txt");
    
    %% Extract the APD and calcium transient amplitude values 
    APD1 = zeros(2,21);
    CaT1 = zeros(2,21);
    
    i = 1;
    BCL = 400;
    BCLs1 = zeros(1,48);
    while(BCL >= 200)
        APD = Individual(:, 3); APD = APD(Individual(:,1) == BCL); APD1(:,i) = APD((end-1):end); APD1(:,i) = [max(APD1(:,i)),min(APD1(:,i))];
        CaT = Individual(:, 4) - Individual(:, 5); CaT = CaT(Individual(:,1) == BCL); CaT1(:,i) = CaT((end-1):end); CaT1(:,i) = [max(CaT1(:,i)),min(CaT1(:,i))];
        
        BCLs1(i) = BCL;
        if(abs(BCL - IndividualThreshold) < 20)
            BCL = BCL - 1;
        else
            BCL = BCL - 10;
        end
        
        i = i + 1;
    end
    
    %% Plot the bifurcation diagrams
    figure(1)
    clf
    plot(BCLs1,APD1,"Color","blue")
    
    figure(2)
    clf
    plot(BCLs1,CaT1,"Color","blue")
    
    %% Compute and record the alternans thresholds
    Alternans1 = abs(APD1(1,:) - APD1(2,:));
    Alternans2 = abs(CaT1(1,:) - CaT1(2,:));
    Threshold1 = 0;
    Threshold2 = 0;
    
    for i = 1:length(BCLs1)
        if(Alternans1(i) >= 5)
            Threshold1 = BCLs1(i);
            break

        end
    end
    for i = 1:length(BCLs1)
        if(Alternans2(i) >= 0.01)
            Threshold2 = BCLs1(i);
            break
        end
    end
    
    writematrix([Threshold1,Threshold2],"AlternansThresholds/Baseline_V" + int2str(n) + ".txt");
end
%% Repeat the analysis for the microgravity model variations.
clear all
for n = 1:6
    %% Load the necessary data
    Individual = "Manuscript_V" + int2str(n) + ".txt";
    Individual = readmatrix("Outcomes_n/" + Individual);
    IndividualThreshold = readmatrix("AlternansThresholdGuess/" + "Manuscript_V" + int2str(n) + ".txt");
    
    %% Extract the APD and calcium transient amplitude values
    APD1 = zeros(2,21);
    CaT1 = zeros(2,21);
    
    i = 1;
    BCL = 400;
    BCLs1 = zeros(1,48);
    while(BCL >= 200)
        APD = Individual(:, 3); APD = APD(Individual(:,1) == BCL); APD1(:,i) = APD((end-1):end); APD1(:,i) = [max(APD1(:,i)),min(APD1(:,i))];
        CaT = Individual(:, 4) - Individual(:, 5); CaT = CaT(Individual(:,1) == BCL); CaT1(:,i) = CaT((end-1):end); CaT1(:,i) = [max(CaT1(:,i)),min(CaT1(:,i))];
        
        BCLs1(i) = BCL;
        if(abs(BCL - IndividualThreshold) < 20)
            BCL = BCL - 1;
        else
            BCL = BCL - 10;
        end
        
        i = i + 1;
    end
    
    %% Plot the bifurcation diagrams
    figure(1)
    clf
    plot(BCLs1,APD1,"Color","blue")
    
    figure(2)
    clf
    plot(BCLs1,CaT1,"Color","blue")
    
    %% Compute and record the alternans thresholds
    Alternans1 = abs(APD1(1,:) - APD1(2,:));
    Alternans2 = abs(CaT1(1,:) - CaT1(2,:));
    Threshold1 = 0;
    Threshold2 = 0;
    
    for i = 1:length(BCLs1)
        if(Alternans1(i) >= 5)
            Threshold1 = BCLs1(i);
            break

        end
    end
    for i = 1:length(BCLs1)
        if(Alternans2(i) >= 0.01)
            Threshold2 = BCLs1(i);
            break
        end
    end
    
    writematrix([Threshold1,Threshold2],"AlternansThresholds/Manuscript_V" + int2str(n) + ".txt");
end
%% Repeat the analysis for the AP clamp preliminary work.
clear all

%% Load the necessary data
Baseline = "BaselineAPC.txt";
Baseline = readmatrix("Outcomes_n/" + Baseline);
BaselineThreshold = readmatrix("AlternansThresholdGuess/Manuscript.txt");

%% Extract the APD and calcium transient amplitude values
APD1 = zeros(2,48);
CaT1 = zeros(2,48);

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

%% Plot the bifurcation diagrams
figure(1)
clf
plot(BCLs1,APD1,"Color","blue","LineWidth",2)
xlabel("BCL (ms)")
ylabel("APD (ms)")

figure(2)
clf
plot(BCLs1,CaT1,"Color","blue","LineWidth",2)
xlabel("BCL (ms)")
ylabel("{\Delta}[Ca^{2+}]_i ({\mu}M)")

%% Compute and record the alternans thresholds (Baseline AP Clamp)
Alternans1 = abs(APD1(1,:) - APD1(2,:));
Alternans2 = abs(CaT1(1,:) - CaT1(2,:));
Threshold = 0;

for i = 1:length(BCLs1)
    if(Alternans1(i) >= 5)
        Threshold1 = BCLs1(i);
        break

    end
end
for i = 1:length(BCLs1)
    if(Alternans2(i) >= 0.01)
        Threshold2 = BCLs1(i);
        break
    end
end

writematrix([Threshold1,Threshold2],"AlternansThresholds/Baseline_APC.txt");