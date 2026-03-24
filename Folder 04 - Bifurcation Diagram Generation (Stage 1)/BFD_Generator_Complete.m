%% Load the necessary data
Baseline = "Baseline.txt";
Baseline = readmatrix("Outcomes_n/" + Baseline);
Microgravity = "Manuscript.txt";
Microgravity = readmatrix("Outcomes_n/" + Microgravity);

%% Extract the APD and calcium transient amplitude values 
APD1 = zeros(2,21);
APD2 = zeros(2,21);
CaT1 = zeros(2,21);
CaT2 = zeros(2,21);

i = 1;
for BCL = 400:-10:200
    APD = Baseline(:, 3); APD = APD(Baseline(:,1) == BCL); APD1(:,i) = APD((end-1):end); APD1(:,i) = [max(APD1(:,i)),min(APD1(:,i))];
    APD = Microgravity(:, 3); APD = APD(Microgravity(:,1) == BCL); APD2(:,i) = APD((end-1):end); APD2(:,i) = [max(APD2(:,i)),min(APD2(:,i))];

    CaT = Baseline(:, 4) - Baseline(:, 5); CaT = CaT(Baseline(:,1) == BCL); CaT1(:,i) = CaT((end-1):end); CaT1(:,i) = [max(CaT1(:,i)),min(CaT1(:,i))];
    CaT = Microgravity(:, 4) - Microgravity(:, 5); CaT = CaT(Microgravity(:,1) == BCL); CaT2(:,i) = CaT((end-1):end); CaT2(:,i) = [max(CaT2(:,i)),min(CaT2(:,i))];

    i = i + 1;
end
BCL = 400:-10:200; 

%% Plot the bifurcation diagrams
figure(1)
clf
plot(BCL,APD1,"Color","blue")
hold on
plot(BCL,APD2,"Color","red")
xlabel("BCL (ms)")
ylabel("APD (ms)")

figure(2)
clf
plot(BCL,CaT1,"Color","blue")
hold on
plot(BCL,CaT2,"Color","red")
xlabel("BCL (ms)")
ylabel("[Ca^{2+}]_i ({\mu}M)")

%% Compute and record the alternans thresholds (Baseline)
Alternans1 = abs(APD1(1,:) - APD1(2,:));
Alternans2 = abs(CaT1(1,:) - CaT1(2,:));
Threshold = 0;

for i = 1:length(BCL)
    if(Alternans1(i) >= 5)
        Threshold = BCL(i);
        break
    elseif(Alternans2(i) >= 0.01)
        Threshold = BCL(i);
        break
    end
end

writematrix(Threshold,"AlternansThresholds/Baseline.txt");

%% Compute and record the alternans thresholds (Microgravity)
Alternans1 = abs(APD2(1,:) - APD2(2,:));
Alternans2 = abs(CaT2(1,:) - CaT2(2,:));
Threshold = 0;

for i = 1:length(BCL)
    if(Alternans1(i) >= 5)
        Threshold = BCL(i);
        break
    elseif(Alternans2(i) >= 0.01)
        Threshold = BCL(i);
        break
    end
end

writematrix(Threshold,"AlternansThresholds/Manuscript.txt");

%% Repeat the analysis for the six variations of the baseline model.
clear all
for n = 1:6
    %% Load the necessary data
    Individual = "Baseline_V" + int2str(n) + ".txt";
    Individual = readmatrix("Outcomes_n/" + Individual);

    %% Extract the APD and calcium transient amplitude values 
    APD1 = zeros(2,21);
    CaT1 = zeros(2,21);
    
    i = 1;
    for BCL = 400:-10:200
        APD = Individual(:, 3); APD = APD(Individual(:,1) == BCL); APD1(:,i) = APD((end-1):end); APD1(:,i) = [max(APD1(:,i)),min(APD1(:,i))];
    
        CaT = Individual(:, 4) - Individual(:, 5); CaT = CaT(Individual(:,1) == BCL); CaT1(:,i) = CaT((end-1):end); CaT1(:,i) = [max(CaT1(:,i)),min(CaT1(:,i))];
    
        i = i + 1;
    end
    BCL = 400:-10:200;

    %% Plot the bifurcation diagrams
    figure(1)
    clf
    plot(BCL,APD1,"Color","blue")
    
    figure(2)
    clf
    plot(BCL,CaT1,"Color","blue")

    %% Compute and record the alternans thresholds
    Alternans1 = abs(APD1(1,:) - APD1(2,:));
    Alternans2 = abs(CaT1(1,:) - CaT1(2,:));
    Threshold = 0;
    
    for i = 1:length(BCL)
        if(Alternans1(i) >= 5)
            Threshold = BCL(i);
            break
        elseif(Alternans2(i) >= 0.01)
            Threshold = BCL(i);
            break
        end
    end
    
    writematrix(Threshold,"AlternansThresholds/Baseline_V" + int2str(n) + ".txt");
end
%% Repeat the analysis for the six variations of the microgravity model.
clear all
for n = 1:6
    %% Load the necessary data
    Individual = "Manuscript_V" + int2str(n) + ".txt";
    Individual = readmatrix("Outcomes_n/" + Individual);
    
    %% Extract the APD and calcium transient amplitude values
    APD1 = zeros(2,21);
    CaT1 = zeros(2,21);
    
    i = 1;
    for BCL = 400:-10:200
        APD = Individual(:, 3); APD = APD(Individual(:,1) == BCL); APD1(:,i) = APD((end-1):end); APD1(:,i) = [max(APD1(:,i)),min(APD1(:,i))];
    
        CaT = Individual(:, 4) - Individual(:, 5); CaT = CaT(Individual(:,1) == BCL); CaT1(:,i) = CaT((end-1):end); CaT1(:,i) = [max(CaT1(:,i)),min(CaT1(:,i))];
    
        i = i + 1;
    end
    BCL = 400:-10:200; 
    
    %% Plot the bifurcation diagrams
    figure(1)
    clf
    plot(BCL,APD1,"Color","blue")
    
    figure(2)
    clf
    plot(BCL,CaT1,"Color","blue")
    
    %% Compute and record the alternans thresholds
    Alternans1 = abs(APD1(1,:) - APD1(2,:));
    Alternans2 = abs(CaT1(1,:) - CaT1(2,:));
    Threshold = 0;
    
    for i = 1:length(BCL)
        if(Alternans1(i) >= 5)
            Threshold = BCL(i);
            break
        elseif(Alternans2(i) >= 0.01)
            Threshold = BCL(i);
            break
        end
    end
    
    writematrix(Threshold,"AlternansThresholds/Manuscript_V" + int2str(n) + ".txt");
end