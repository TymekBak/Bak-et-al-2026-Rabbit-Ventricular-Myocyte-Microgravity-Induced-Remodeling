%% Load the population parameter data and the alternans thresholds.
Population = zeros(1001,16); Population(:,1) = 0:1000;
Thresholds = zeros(1001,1);

for i = 0:1000
    Population((i+1),2:end) = readmatrix("Individuals\Baseline_P" + int2str(i) + ".txt");
    Thresholds(i+1) = readmatrix("AlternansThresholds\Baseline_P" + int2str(i) + ".txt");
end

InputVariables = ["g_{RyR}","u","v_{up}","[Ca^{2+}]_{up}","g_{LTCC}","v_{th}","g_{to,s}","g_{to,f}","g_{NaCa}","g_{Ks}","g_{Kr}","g_{Na}","g_{K1}","g_{NaK}","g_{leak}"];

%% Remove the excluded individuals from the analysis and correct the initially incorrect alternans thresholds.
ExclusionIndex = unique([23,50,119,147,203,312,313,411,452,458,519,599,726,829,913,943,970]);
a = [];

for i = 1:1001
    if(any(Population(i,1) == ExclusionIndex))
        a = [a,i];
    end
end
%The indexes are one more than the individual IDs
Thresholds(188) = 135;
Thresholds(473) = 295;
Thresholds(275) = 191;
Thresholds(794) = 209;
Thresholds(892) = 207;
Thresholds(980) = 168;
Thresholds(992) = 205;
Thresholds(571) = 72;

Population(a,:) = [];
Thresholds(a,:) = [];

%% Calculate the p-value for the population of models.
a = fitlm(Population(:,2:end),Thresholds);
p_values = a.Coefficients.pValue(2:end);
coefficients = a.Coefficients.Estimate(2:end);

%% Store the data for the next step of the analysis
save("CalciumAlternansSensitivityAnalysis4.mat", "Population","Thresholds","p_values","coefficients","InputVariables");