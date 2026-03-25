%% Record the percent changes in simulation data
labels = (["APD_{90}", "[Ca^{2+}]_{i,max}","[Ca^{2+}]_{i,min}","[Ca^{2+}]_{SR,max}","CaTD_{50}","\tau","CaTD_{90}"]);
change = [7.1582, -22.2024, -4.8404, -5.6628, 24.0654,19.4355,7.6218];

%% Record the data from the scientific literature.
% The names in parantheses correspond to the sources of data used in this
% figure. The data distributions that were not expressed as standard error
% were converted to standard error. On occassion this required assuming the
% data is normally distributed. If a source is listed twice that means measurements
% were provided for two time points (Ibrahim and Ito) or two conditions (post-rest
% and steady-state).
% Data References:
% Chang, H., Zhang, L., Xu, P.-T., Li, Q., Sheng, J.-J., Wang, Y.-Y., Chen, Y., Zhang, L.-N., & Yu, Z.-B. (2011). Nuclear translocation of calpain-2 regulates propensity toward apoptosis in cardiomyocytes of tail-suspended rats. J Cell Biochem, 112(2), 571–580. https://doi.org/10.1002/jcb.22947.
% Forghani, P., Liu, W., Wang, Z., Ling, Z., Takaesu, F., Yang, E., Tharp, G.K., Nielsen, S., Doraisingam, S., Countryman, S., Davis, M.E., Wu, R., Jia, S., & Xu, C. (2025). Spaceflight alters protein levels and gene expression associated with stress response and metabolic characteristics in human cardiac spheroids. Biomaterials, 317, 123080. https://doi.org/10.1016/j.biomaterials.2024.123080.
% Halet, G., Viard, P., Morel, J.L., Mironneau, J., & Mironneau, C. (1999). Effects of hindlimb suspension on cytosolic Ca2+ and [3H]ryanodine binding in cardiac myocytes. Am J Physiol, 276(4), H1131-6. https://doi.org/10.1152/ajpheart.1999.276.4.H1131.
% Ibrahim, M., Kukadia, P., Siedlecka, U., Cartledge, J.E., Navaratnarajah, M., Tokar, S., Van Doorn, C., Tsang, V.T., Gorelik, J., Yacoub, M.H., & Terracciano, C.M. (2012). Cardiomyocyte Ca2+ handling and structure is regulated by degree and duration of mechanical load variation. J Cell Mol Med, 16(12), 2910–2918. https://doi.org/10.1111/j.1582-4934.2012.01611.x.
% Ito, K., Nakayama, M., Hasan, F., Yan, X., Schneider, M.D., & Lorell, B.H. (2003). Contractile reserve and calcium regulation are depressed in myocytes from chronically unloaded hearts. Circulation, 107(8), 1176–1182. https://doi.org/10.1161/01.cir.0000051463.72137.96.
% Moffitt, J.A., Henry, M.K., Welliver, K.C., Jepson, A.J., & Garnett, E.R. (2013). Hindlimb unloading results in increased predisposition to cardiac arrhythmias and alters left ventricular connexin 43 expression. Am J Physiol Regul Integr Comp Physiol, 304(5), R362-73. https://doi.org/10.1152/ajpregu.00391.2012.
% Respress, J.L., Gershovich, P.M., Wang, T., Reynolds, J.O., Skapura, D.G., Sutton, J.P., Miyake, C.Y., & Wehrens, X.H.T. (2014). Long-term simulated microgravity causes cardiac RyR2 phosphorylation and arrhythmias in mice. Int J Cardiol, 176(3), 994–1000. https://doi.org/10.1016/j.ijcard.2014.08.138.
%Percent Change Standard Error Reference:
%United States Census Bureau (n.d.). https://www2.census.gov/programs-surveys/acs/tech_docs/accuracy/percchg.pdf. Available at: https://www2.census.gov/programs-surveys/acs/tech_docs/accuracy/percchg.pdf [Accessed February 12, 2026].

%APD Data for Tail Suspension Studies (Moffit, Respress)
APD_Initial = [160,38.3];
APD_Initial_SE = [6.8,1.3];
APD_Final = [168,40.9];
APD_Final_SE = [9.4,1];
APD_PercentChange = 100*(APD_Final - APD_Initial)./APD_Initial;
APD_PercentChange_SE = 100*abs(APD_Final./APD_Initial).*sqrt((APD_Final_SE./APD_Final).^2 + (APD_Initial_SE./APD_Initial).^2);

%Calcium Transient Data for Tail Suspension Studies (Halet,Halet,Chang)
Cai_CaT_Initial = [0.06108597285, 0.0330316742,120.248962656];
Cai_CaT_Initial_SE = [0.00226244343,0.00180995475,5.22821576763];
Cai_CaT_Final = [0.08552036199, 0.03936651583,129.211618257];
Cai_CaT_Final_SE = [0.00271493212,0.00407239819,4.48132780083];
Cai_CaT_PercentChange = 100*(Cai_CaT_Final - Cai_CaT_Initial)./Cai_CaT_Initial;
Cai_CaT_PercentChange_SE = 100*abs(Cai_CaT_Final./Cai_CaT_Initial).*sqrt((Cai_CaT_Final_SE./Cai_CaT_Final).^2 + (Cai_CaT_Initial_SE./Cai_CaT_Initial).^2);

%End Diastolic Calcium Data for Tail Suspension Studies (Halet, Chang)
Cai_min_Initial = [0.51,27.6348547718];
Cai_min_Initial_SE = [0.004,4.48132780083];
Cai_min_Final = [0.53,35.8506224066];
Cai_min_Final_SE = [0.009,5.97510373444];
Cai_min_PercentChange = 100*(Cai_min_Final - Cai_min_Initial)./Cai_min_Initial;
Cai_min_PercentChange_SE = 100*abs(Cai_min_Final./Cai_min_Initial).*sqrt((Cai_min_Final_SE./Cai_min_Final).^2 + (Cai_min_Initial_SE./Cai_min_Initial).^2);

%Peak SR Calcium Data for Tail Suspension Studies (Halet,Halet,Respress)
CaSR_max_Initial = [0.13060344827,0.11637931034,3.72807017544];
CaSR_max_Initial_SE = [0.00387931034,0.00517241379,0.3031];
CaSR_max_Final = [0.13577586206,0.13060344827,2.73391812865];
CaSR_max_Final_SE = [0.00905172413,0.00775862068,0.2810];
CaSR_max_PercentChange = 100*(CaSR_max_Final - CaSR_max_Initial)./CaSR_max_Initial;
CaSR_max_PercentChange_SE = 100*abs(CaSR_max_Final./CaSR_max_Initial).*sqrt((CaSR_max_Final_SE./CaSR_max_Final).^2 + (CaSR_max_Initial_SE./CaSR_max_Initial).^2);

%Data for CaTD50 (Forghani, Ibrahim, Ibrahim, Ito, Ito)
CaTD50_Initial = [0.62157534246,190.151515152,190.151515152,70,69];
CaTD50_Initial_SE = [0.0504,6.06060606061,6.06060606061,3,4];
CaTD50_Final = [0.51883561643,237.878787879,253.03030303,77,85];
CaTD50_Final_SE = [0.0538,6.06060606061,12.1212121212,6,3];
CaTD50_PercentChange = 100*(CaTD50_Final - CaTD50_Initial)./CaTD50_Initial;
CaTD50_PercentChange_SE = 100*abs(CaTD50_Final./CaTD50_Initial).*sqrt((CaTD50_Final_SE./CaTD50_Final).^2 + (CaTD50_Initial_SE./CaTD50_Initial).^2);

%% Generate the figure
figure(1)
clf
scatter(1:5,change(1:(end-2)),100,"filled","Blue");
set(gca,"FontSize",24,"XTick",1:5,"XTickLabel",labels(1:(end-2)))
hold on
yline(0,"LineWidth",2,"LineStyle",":")

x = linspace(0.8,1.2,length(APD_PercentChange));
i = abs(APD_PercentChange - change(1)) < APD_PercentChange_SE*1.96;
scatter(x(i),APD_PercentChange(i), 100, "filled", "Black")
errorbar(x(i),APD_PercentChange(i),APD_PercentChange_SE(i),"Marker",".","MarkerSize",5,"LineStyle","none","Color","Black","LineWidth",3)
scatter(x(~i),APD_PercentChange(~i), 100, "filled", "Black")
errorbar(x(~i),APD_PercentChange(~i),APD_PercentChange_SE(~i),"Marker",".","MarkerSize",5,"LineStyle","none","Color","Black","LineWidth",3)

x = 1 + linspace(0.8,1.2,length(Cai_CaT_PercentChange));
i = abs(Cai_CaT_PercentChange - change(2)) < Cai_CaT_PercentChange_SE*1.96;
scatter(x(i),Cai_CaT_PercentChange(i), 100, "filled", "Black")
errorbar(x(i),Cai_CaT_PercentChange(i),Cai_CaT_PercentChange_SE(i),"Marker",".","MarkerSize",5,"LineStyle","none","Color","Black","LineWidth",3)
scatter(x(~i),Cai_CaT_PercentChange(~i), 100, "filled", "Black")
errorbar(x(~i),Cai_CaT_PercentChange(~i),Cai_CaT_PercentChange_SE(~i),"Marker",".","MarkerSize",5,"LineStyle","none","Color","Black","LineWidth",3)

x = 2 + linspace(0.8,1.2,length(Cai_min_PercentChange));
i = abs(Cai_min_PercentChange - change(3)) < Cai_min_PercentChange_SE*1.96;
scatter(x(i),Cai_min_PercentChange(i), 100, "filled", "Black")
errorbar(x(i),Cai_min_PercentChange(i),Cai_min_PercentChange_SE(i),"Marker",".","MarkerSize",5,"LineStyle","none","Color","Black","LineWidth",3)
scatter(x(~i),Cai_min_PercentChange(~i), 100, "filled", "Black")
errorbar(x(~i),Cai_min_PercentChange(~i),Cai_min_PercentChange_SE(~i),"Marker",".","MarkerSize",5,"LineStyle","none","Color","Black","LineWidth",3)

x = 3 + linspace(0.8,1.2,length(CaSR_max_PercentChange));
i = abs(CaSR_max_PercentChange - change(4)) < CaSR_max_PercentChange_SE*1.96;
scatter(x(i),CaSR_max_PercentChange(i), 100, "filled", "Black")
errorbar(x(i),CaSR_max_PercentChange(i),CaSR_max_PercentChange_SE(i),"Marker",".","MarkerSize",5,"LineStyle","none","Color","Black","LineWidth",3)
scatter(x(~i),CaSR_max_PercentChange(~i), 100, "filled", "Black")
errorbar(x(~i),CaSR_max_PercentChange(~i),CaSR_max_PercentChange_SE(~i),"Marker",".","MarkerSize",5,"LineStyle","none","Color","Black","LineWidth",3)

x = 4 + linspace(0.8,1.2,length(CaTD50_PercentChange));
i = abs(CaTD50_PercentChange - change(5)) < CaTD50_PercentChange_SE*1.96;
scatter(x(i),CaTD50_PercentChange(i), 100, "filled", "Black")
errorbar(x(i),CaTD50_PercentChange(i),CaTD50_PercentChange_SE(i),"Marker",".","MarkerSize",5,"LineStyle","none","Color","Black","LineWidth",3)
scatter(x(~i),CaTD50_PercentChange(~i), 100, "filled", "Black")
errorbar(x(~i),CaTD50_PercentChange(~i),CaTD50_PercentChange_SE(~i),"Marker",".","MarkerSize",5,"LineStyle","none","Color","Black","LineWidth",3)

ylabel("Percent Change (%)")
