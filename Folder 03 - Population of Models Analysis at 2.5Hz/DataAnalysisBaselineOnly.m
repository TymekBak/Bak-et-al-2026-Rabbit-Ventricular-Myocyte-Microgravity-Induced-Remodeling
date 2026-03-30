%% Load the data and assign new headings
DataHeadings = {'Individual ID','g_RyR','u','vup','Caup','g_LTCC','v_th','g_tos','g_tof','g_NaCa','g_Ks','g_Kr','g_Na','g_K1','g_NaK','g_leak','APD', 'Cai_max', 'Cai_min', 'CaSR_max', 'CaSR_min', 'Nai_max', 'Nai_min', 'CaTD_50', 'TTP'};
DataA = readtable("SimulationData_BCL400A.csv"); DataA.Properties.VariableNames = DataHeadings;
DataB = readtable("SimulationData_BCL400B.csv"); DataB.Properties.VariableNames = DataHeadings;

%% Renumber the individuals
ID = DataA.("Individual ID"); ID(1002:end) = ID(1002:end) - 1001; DataA.("Individual ID") = ID; DataB.("Individual ID") = ID;

%% Seperate the input and output data
Baseline_Input = DataA(1:1001,2:16);
DataA_Baseline_Output = DataA(1:1001,[17,20,18,19,24]);
DataB_Baseline_Output = DataB(1:1001,[17,20,18,19,24]);

%% Remove individuals that failed in the primary and follow-up alternans analysis
ExclusionIndex = 1 + unique([23,50,119,147,203,312,313,411,452,458,519,599,726,829,913,943,970]);
a = [];

for i = 1:1001
    if(any(i == ExclusionIndex))
        a = [a,i];
    end
end
Baseline_Input(a,:) = [];
DataA_Baseline_Output(a,:) = [];
DataB_Baseline_Output(a,:) = [];


%% Remove the individuals that exhibit alternans. No individuals exhibited alternans; however, if they had, it would have complicated the analysis.
Baseline_Alternans = abs(DataA_Baseline_Output - DataB_Baseline_Output);
Baseline_Alternans_Index = any((table2array(Baseline_Alternans)' < 0.001))';
Baseline_Input = table2array(Baseline_Input(Baseline_Alternans_Index,:));
Baseline_Output = table2array(DataA_Baseline_Output(Baseline_Alternans_Index,:));

%% Record the names and units of the model parameters and biomarkers.
output_titles = ["APD_{90} (ms)", "[Ca^{2+}]_{SR,max} ({\mu}M)", "[Ca^{2+}]_{i,max} ({\mu}M)", "[Ca^{2+}]_{i,min} ({\mu}M)", "CaTD_{50} (ms)"];
input_titles = ["g_{RyR} (sp cm^2/mA)","u (/ms)","J_{up,max} ({\muM}/ms)","Kmf_{SERCA} ({\mu}M)","g_{LTCC} (mmol/cm/C)","v_{th} (mV)","g_{to,s} (mS/{\mu}F)","g_{to,f} (mS/{\mu}F)","g_{NaCa} ({\mu}M/ms)","g_{Ks} (mS/{\mu}F)","g_{Kr} (mS/{\mu}F)","g_{Na} (mS/{\mu}F)","g_{K1} (mS/{\mu}F)","g_{NaK} (mS/{\mu}F)","g_{leak} (/ms)"];

%% Create histograms of the model parameters and biomarkers.
figure(1)
clf
for i = 1:5
    subplot(3,2,i)
    a = histogram((Baseline_Output(2:end,i)),"LineStyle","none");
    xline((Baseline_Output(1,i)), "Label","Baseline","LabelHorizontalAlignment","right","FontSize",14,"FontWeight","bold")
    a.set("FaceAlpha",0.5);
    a.set("BinWidth",(max(Baseline_Output(2:end,i)) - min(Baseline_Output(2:end,i)))/20);
    title(output_titles(i))
    ylim([0,250])
    set(gca,"FontSize",14)
end

figure(2)
clf
for i = 1:15
    subplot(3,5,i)
    a = histogram((Baseline_Input(2:end,i)),"LineStyle","none");
    xline((Baseline_Input(1,i)), "Label","Baseline","LabelHorizontalAlignment","right","FontSize",14,"FontWeight","bold")
    a.set("FaceAlpha",0.5);
    title(input_titles(i))
    set(gca,"FontSize",14)
end

%% Compute the p-values for the population of models analysis.
Baseline = [(Baseline_Input),Baseline_Output];
Baseline_p_values = zeros(15,5);
Baseline_coefficients = zeros(15,5);
for i = 1:5
    a = fitlm(Baseline(2:end,1:15),Baseline(2:end,(i+15)));
    Baseline_p_values(:,i) = a.Coefficients.pValue(2:end);
    Baseline_coefficients(:,i) = a.Coefficients.Estimate(2:end);
end

%% Save the data for further analysis and plotting.
input_titles = ["g_{RyR}","u","v_{up}","[Ca^{2+}]_{up}","g_{LTCC}","v_{th}","g_{to,s}","g_{to,f}","g_{NaCa}","g_{Ks}","g_{Kr}","g_{Na}","g_{K1}","g_{NaK}","g_{leak}"];
save("PLS_Data_BaselineOnly3.mat", "Baseline_Input","Baseline_Output","Baseline_p_values","Baseline_coefficients" ,"input_titles", "output_titles");
