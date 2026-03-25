%% Sensitivity Analyisis - part 3/3
% 
% S. Morotti, M. Nieves-Cintrón, M.A. Nystoriak, M.F. Navedo, E. Grandi.
% Predominant contribution of L-type CaV1.2 channel stimulation to impaired
% intracellular calcium and cerebral artery vasoconstriction in diabetic 
% hyperglycemia. Channels. 2017. doi: 10.1080/19336950.2017.1293220.
% 
% Please, cite the above paper when using this code.

%% main PLS
close all
clear all
clc

color = [0 114 189]/255;

disp('Sensitivity Analysis')
disp('----------------------------------------------------------------')

%% Load parameters
% load matrix all_parameters (columns: N parameters, rows: N trials)
% and array 'parameter_names'
% parameter_names = {'ICaL','IBKCa','IK','IKleak','IClCa'...
%     'INaKCl','INaK','INCX','IPMCA','ISOC'...
%     'INSC','IIP3','ISRleak','ISRrel','ISRup'} 

load CalciumAlternansSensitivityAnalysis4.mat
all_parameters = Population(2:end,2:end);
all_parameters(:,6) = all_parameters(:,6) + 10;
all_outputs = Thresholds(2:end);
parameter_names = InputVariables;
parameter_names(4) = "Kmf_{SERCA}"; %An old version which I overwrote did not include this line.
output_names = {'Calcium Alternans Threshold'};
output_baseline = Thresholds(1);
[N_trials N_pars] = size(all_parameters);
N_outputs = 1;
%% Outputs - population level
all_outputs_mean = mean(all_outputs);
all_outputs_std_dev = std(all_outputs);

disp('Average outputs at the population level (mean +/- std dev):')
disp(['Voltage Alternans Threshold = ',num2str(all_outputs_mean(1),4),' +/- ',num2str(all_outputs_std_dev(1),4),' ms'])
disp('----------------------------------------------------------------')

%% Call the PLS routine
good_count = N_trials;
X = log(all_parameters);
Y = log(all_outputs);
% N_pars, N_outputs, N_trials, good_count

% PLS - nipals algorithm (2003)
[T,P,W,Wstar,U,B,C,Bpls,Bpls_star,Xhat,Yhat,R2x,R2y] = PLS_nipals(X,Y,rank(X));
% Regression Coefficients
disp('Regression Coefficients (Em, [Ca2+]i):')
Reg_Coeff = Bpls
disp('----------------------------------------------------------------')

% Calculate agreement of values predicted by regression (Yhat = Bpls*X) 
% with original outputs (Y)
SSYT = sum((Y-ones(good_count,1)*mean(Y)).^2);
SSYR = sum((Yhat-ones(good_count,1)*mean(Y)).^2);
R2each = SSYR./SSYT;

%% Plot the analysis results.
figure(1)
clf
p_values = string((p_values < 0.05));
for i = 1:length(p_values(:))
    if(p_values(i) == "true")
        p_values(i) = "*";
    else
        p_values(i) = "";
    end
end

subplot(1,2,1)
a = histogram((Thresholds(2:end)),"LineStyle","none");
xline((Thresholds(1)), "Label","Baseline","LabelHorizontalAlignment","left","FontSize",20,"LineWidth",2)
a.set("FaceAlpha",0.5);
a.set("BinWidth",(max(Thresholds(2:end)) - min(Thresholds(2:end)))/20);
ylim([0,250])
title("Ca^{2+} Alternans Threshold BCL (ms)")
set(gca,"FontSize",20)

subplot(1,2,2)
hold on
a = bar(Bpls(:,1),'FaceColor',color,"Labels",p_values(:,1));
set(a,"FontWeight","bold","FontSize",15)
set(gca,'box','off','tickdir','out','fontsize',15)
set(gca,'XLim',[0 N_pars+1])
set(gca,"YLim",[-1,1])
set(gca, "XTick",1:N_pars)
parameter_names(3) = "J_{up,max}";
title("Ca^{2+} Alternans Threshold BCL Regression Coefficients")
set(gca,'XTickLabel',parameter_names)
set(gca,"FontSize",20)
