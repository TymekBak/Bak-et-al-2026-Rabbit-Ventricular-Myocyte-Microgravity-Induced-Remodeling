### ***Introduction:***
The following code can be used to verify the figures and statements made in the Master’s Thesis of Tymoteusz Bak. The code is divided into twelve folders, whose contents are defined below. The original Mahajan Model files (*cell.cc*, *make*, and *cell.h*) were provided by Dr Daisuke Sato and revised as appropriate (Mahajan et al., 2008). The original population of models files (*PLS_nipals.m* and *SMC_SA3_sensitivity.m*) were provided by Dr Stefano Morotti (Morotti et al., 2017). The core simulation code (*MahajanRecorder.cpp*) was written using a script written by Roshni Shetty as a template. When interpreting the results of the population of models analysis, two additional sources provided helpful insight (Morotti et al., 2021; Ding et al., 2022).\
*The following elements are present either in every folder or almost every folder:*\
•	**cell.h**: This is a header file for the cell object in the simulations. It is the same in each folder.\
•	**cell.cc**: This is the main file for the cell object in the simulations. With the exception of Folder 1, it is the same in each folder.\
•	**InitialCondition.csv**: This file describes the initial condition of the cell for each folder. It is the same in each folder; however, *Folder 1* overwrites some initial values directly in the code.\
•	**MahajanRecorder.cpp**: This is the core simulation script. The comments in this file describe the input and output file format.\
•	**Individuals**: This subfolder stores the text files that define specific model variations. *Folders 3, 6, and 7* populate this subfolder using a MATLAB script.\
•	**Outcomes_n**: This subfolder stores the text files that contain the outcomes of each simulation. This subfolder is absent in *Folder 1*.\
•	**Outcomes_t**: This subfolder stores the text files that contain the waveforms for each simulation. The last 10000ms are recorded for each basic cycle length (BCL) – Individual combination with a 1ms sampling rate. This subfolder is absent in *Folder 1*.\
•	**Makefile**: This file can be used to compile the code.\
•	**ExecutionFile.txt**: This text file contains commands that can be copied into a terminal window to run the main simulation. *Folders 3, 6, and 7* generate this file with a MATLAB script. This will only work if the terminal is open to the appropriate directory and all of the prerequisite files are present.
### ***Note:***
•	If a folder is missing in GitHub, that means that it is initially empty and needs to be created for the code to work.\
•	The code was run on three different computers using a combination of MacOS and Windows operating systems.\
•	The code is written using a combination of MATLAB, Python, and C/C++. Reproducing the analysis also requires the operating system to be able to use Makefiles.\
•	If the code contains a path, it is likely that this line will need to be changed to run the code properly.
### ***Folder 1 - LTCC Voltage Dependent Activation:***
This folder can be used to recreate Figure 1 in the thesis. The simulation protocol is meant to characterize the behavior of the L-type Ca2+ channel (LTCC) with a voltage clamp analysis.\
*The following elements are added to this folder:*\
•	**Results1:** This subfolder stores the main outcomes of the simulation in this folder.\
•	**Results2:** This subfolder stores the same information as *Outcomes_t*; however, it records the entire simulation protocol instead of the last 10000ms. In addition, it records the LTCC current.\
•	**VDA_TimeCourseDisplay2.m:** This script is used to generate the panels of Figure 1.\
•	**InactivationAnalysis_CaTD50.m:** This segment of code estimates the inactivation behavior of the LTCC at 0mV membrane potentials. The time to 50% decay of the normalized current is considered in this analysis.\
•	**InactivationAnalysis_Tau.m:** This segment of code estimates the inactivation behavior of the LTCC at 0mV membrane potentials. The time constant of exponential decay of the normalized current is considered in this analysis.
### ***Folder 2 - Microgravity Effects on Biomarkers:***
This folder can be used to recreate Figure 2 and Figure 4 in the thesis. In addition, it is used to describe the baseline and microgravity models in Figure 5. This part of the project involves determining the steady-state behavior of these two models at 2.5Hz, analyzing the results, and creating the figures of interest.\
*The following elements are added to this folder:*\
•	**ConfirmConvergence.py:** This script studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs.\
•	**TimeCourseScreening.py:** This script studies the action potential and calcium transient properties to ensure that the model behaves in a physiological manner.\
•	**TimeCourseTraces400ms.m:** This script generates time course trace images for the baseline and microgravity models.\
•	**ValidationParameterDefinition.m:** This script generates an image of the action potential, calcium transient, and non-junctional sarcoplasmic reticulum calcium content waveforms. The plot includes threshold lines, which can be used to recreate Figure 2 in PowerPoint.\
•	**ValidationPlot.m:** This plot is meant to compare the results to the cited data.
### ***Folder 3 - Population of Models Analysis at 2.5Hz:***
This folder can be used to recreate Figure 5 in the thesis. The necessary values from Folder 2 were manually copied into the relevant script. This part of the project involves generating a population of models, pacing each individual to steady-state at 2.5Hz, analyzing the results, and creating the figures of interest.\
*The following elements are added to this folder:*\
•	**GeneratePopulation.m:** This script is used to generate the population of models in a random and reproducible manner. This is achieved by applying a fixed random seed, which ensures that the same population is used in each analysis. This file also writes *ExecutionFile.txt* for this folder.\
•	**DataFrameWriting.py:** This file is used to extract data for odd and even steady-state beats for every individual in the population.\
•	**ConfirmConvergence.py:** This script studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs.\
•	**TimeCourseScreening.py:** This script studies the action potential and calcium transient properties to ensure that the model behaves in a physiological manner.\
•	**TimeCourseDisplay.py:** This code extracts action potential and calcium transient time course traces from the simulations for a 2000ms interval and stores them in a text file.\
•	**PopulationDescriptionTraces.m:** This code creates time course traces for each member of the population of models. The data from *TimeCourseDisplay.py* is used in this plot and the exclusion criteria from the alternans analysis are used to exclude the appropriate traces from the image.\
•	**DataAnalysisBaselineOnly.m:** This code processes and plots the data from *DataFrameWriting.py*. The statistical significance of parameter correlations is also computed at this stage. The exclusion of specific individuals from the population is applied at this point in the analysis.\
•	**SMC_SA3_sensitivity_Baseline.m:** This is an adaptation of a MATLAB script from another study that finishes the population of models analysis and generates the appropriate plots.\
•	**PLS_nipals.m:** This is an imported function that is necessary for the population of models analysis. The file is a verbatim copy of a script provided by Dr Stefano Morotti.
### ***Folder 4 - Bifurcation Diagram Generation (Stage 1):***
This folder describes a preliminary analysis that is not used to create any figures; however, the results of this analysis are used by *Folder 5*. This part of the project involves generating a course bifurcation diagram for the baseline model, the microgravity model, six baseline model variations (5 baseline model parameters + 1 microgravity model parameter), and six microgravity model variations (1 baseline model parameter + 5 microgravity model parameters). The alternans thresholds from these curves are needed in *Folder 5*.\
*The following elements are added to this folder:*\
•	**AlternansThresholds:** This subfolder is used to store estimated locations of the alternans thresholds based on the results of this simulation.\
•	**BFD_Generator_Complete.m:** This script reads the contents of *Outcomes_n* and uses them to estimate the alternans thresholds. The results are saved in *AlternansThresholds*.
### ***Folder 5 - Bifurcation Diagram Generation (Stage 2):***
This folder can be used to recreate Figures 6-10. The approximate locations of the bifurcation point are copied from *Folder 4*. This part of the project involves generating a bifurcation diagram with a high-resolution description of frequencies near the bifurcation point. The code in this section is also used to prepare the raw action potential (AP) traces for *Folder 12*.\
*The following elements are added to this folder:*\
•	**AlternansThresholds:** This subfolder is used to store estimated locations of the alternans thresholds based on the results of this simulation.\
•	**AlternansThresholdsGuess:** This subfolder is used to store estimated locations of the alternans thresholds based on the results of the previous simulation. These values are needed for this folder to work properly.\
•	**BFD_Generator_Complete.m:** This script reads the contents of *Outcomes_n* and uses them to estimate the alternans thresholds. The results are saved in *AlternansThresholds*.\
•	**AlternansThresholdAnalysis.m:** This code contains a copy of the results from *AlternansThresholds* which is displayed visually to create Figure 10.\
•	**RyR_Analysis.m:** The results of this script are not explicitly shown in the thesis; however, it contains the analysis for ryanodine receptor strength (gRyR) that is analogous to Figures 6-8.\
•	**Leak_Analysis.m:** The results of this script are not explicitly shown in the thesis; however, it contains the analysis for the leak flux strength (gleak) that is analogous to Figures 6-8.\
•	**PLB_Analysis.m:** The results of this script are not explicitly shown in the thesis; however, it contains the analysis for the phospholamban-based remodeling effect (KmfSERCA) that is analogous to Figures 6-8.\
•	**gLTCC_Analysis.m:** This script analyzes the contents of *Outcomes_n* to recreate Figure 6 panels.\
•	**vth_Analysis.m:** This script analyzes the contents of *Outcomes_n* to recreate Figure 7 panels.\
•	**NaK_Analysis.m:** This script analyzes the contents of *Outcomes_n* to recreate Figure 8 panels.\
•	**ConfirmConvergence.py:** This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be studied to examine any drift that occurs.\
•	**ConfirmConvergenceAPC.py:** This script is essentially the same as *ConfirmConvergence.py*; however, it is used to evaluate the simulation that is used to generate the AP clamp recordings.\
•	**MicrogravityEffect.m:** This script is used to generate the bifurcation diagrams for Figure 9.\
•	**TimeCourse4Hz.m:** This script is used to generate the time course traces for Figure 9.\
•	**TimeCourseScreening.py:** This script is used to confirm that the model behaves in a physiologically reasonable manner.
### ***Folder 6 - Alternans Threshold Search Analysis (Calcium):***
This folder is needed to recreate Figure 11B and 11D. This part of the project involves generating a population of models (same population as *Folder 3*), estimating the calcium transient alternans threshold for each individual, analyzing the results, and creating the figure of interest. Refer to *Folders 8-10* for the follow-up analysis.\
*The following elements are added to this folder:*\
•	**AlternansThresholds:** This subfolder is used to store estimated locations of the alternans thresholds based on the results of this simulation.\
•	**GeneratePopulation.m:** This script is used to generate the population of models in a random and reproducible manner. This is achieved by applying a fixed random seed, which ensures that the same population is used in each analysis. This file also writes *ExecutionFile.txt* for this folder.\
•	**CalciumTransientAnalysisFull.py:** This script is used to create a short analysis file to confirm that the model behaves in a reasonable manner. Specifically, it computes the action potential duration, calcium transient amplitude, peak systolic cytosolic calcium, and end diastolic cytosolic calcium, at the identified alternans threshold and at the closest BCL without alternans. The file is analyzed in *CalciumTransientThresholdAnalysis.py*.\
•	**CalciumTransientThresholdAnalysis.py:** This file analyzes the results of *CalciumTransientAnalysisFull.py* to confirm that the alternans thresholds meet the necessary criteria. If an individual ID number is printed in the first four rows of the output, the individual fails to meet some criterion. Look at the code for details.\
•	**CalciumTransientAnalysisFollowUp.py:** This file is used to visually inspect the individuals that failed in the simulation from this folder.\
•	**SensitivityAnalysisPreparation.m:** This code processes the simulation outputs, removes the excluded models from the analysis, and prepares the inputs, outputs, and p-values for the Ca2+ alternans analysis.\
•	**SMC_SA3_sensitivity.m:** This is an adaptation of a MATLAB script from another study that finishes the population of models analysis and generates the appropriate plots.\
•	**PLS_nipals.m:** This is an imported function that is necessary for the population of models analysis. The code is a verbatim copy of a script provided by Dr Stefano Morotti.\
•	**ConfirmConvergence.py:** This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs. Note that only BCLs that are less than 10ms from the threshold are considered.
### ***Folder 7 - Alternans Threshold Search Analysis (Action Potential):***
This folder is needed to recreate Figure 11A and Figure 11C. This part of the project involves generating a population of models (same population as *Folder 3*), estimating the action potential duration (APD) alternans threshold for each individual, analyzing the results, and creating the figure of interest. Refer to *Folders 8-10* for the follow-up analysis.\
*The following elements are added to this folder:*\
•	**AlternansThresholds:** This subfolder is used to store estimated locations of the alternans thresholds based on the results of this simulation.\
•	**GeneratePopulation.m:** This script is used to generate the population of models in a random and reproducible manner. This is achieved by applying a fixed random seed, which ensures that the same population is used in each analysis. This file also writes *ExecutionFile.txt* for this folder.\
•	**CalciumTransientAnalysisFull.py:** This script is used to create a short analysis file to confirm that the model behaves in a reasonable manner. Specifically, it computes the action potential duration, calcium transient amplitude, peak systolic cytosolic calcium, and end diastolic cytosolic calcium, at the identified alternans threshold and at the closest BCL without alternans. The file is analyzed in *CalciumTransientThresholdAnalysis.py*.\
•	**CalciumTransientThresholdAnalysis.py:** This file analyzes the results of *CalciumTransientAnalysisFull.py* to confirm that the alternans thresholds meet the necessary criteria. A typo was identified after publication that prevented the identification of six individuals who did not meet the threshold criteria. These individuals almost met the criterion; therefore, it is assumed that the overall findings of this project are valid.\
•	**CalciumTransientAnalysisFollowUp.py:** This file is used to visually inspect the individuals that failed in the simulation from this folder.\
•	**SensitivityAnalysisPreparation.m:** This code processes the simulation outputs, removes the excluded models from the analysis, and prepares the inputs, outputs, and p-values for the AP alternans analysis.\
•	**SMC_SA3_sensitivity.m:** This is an adaptation of a MATLAB script from another study that finishes the population of models analysis and generates the appropriate plots.\
•	**PLS_nipals.m:** This is an imported function that is necessary for the population of models analysis. The code is a verbatim copy of a script provided by Dr Stefano Morotti.\
•	**ConfirmConvergence.py:** This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs. Note that only BCLs that are less than 10ms from the threshold are considered.
### ***Folder 8 - Alternans Threshold Search Analysis Follow-Up Simulations (Part 1):***
This folder is needed to follow-up on the results from *Folders 6-7* and correct the alternans thresholds for specific cases. As such, this simulation is needed to finish Figure 11. This part of the project generates a high-resolution bifurcation diagram which is then  examined to find the threshold for alternans initiation. The results are further examined to determine if the individual should be removed from the study or if its alternans thresholds need to be updated.\
*The following elements are added to this folder:*\
•	**Bifurcation Diagrams:** This subfolder is used to store the bifurcation diagrams that are generated by *ThresholdSearch.m*.\
•	**TimeCourse:** This subfolder is used to store the action potential and calcium transient traces that are generated by *ThresholdSearch.m*.\
•	**ConfirmConvergence.py:** This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs.\
•	**ThresholdSearch.m:** This analysis code generates images of bifurcation diagrams, identifies the alternans thresholds, and plots the action potential and calcium transient at the threshold and at the closest BCL without alternans.\
•	**AlternansThresholdSummary.txt:** This text file gives the alternans thresholds for the model variations tested in this folder.
### ***Folder 9 - Alternans Threshold Search Analysis Follow-Up Simulations (Part 2):***
This folder is needed to follow-up on the results from *Folders 6-7* and correct the alternans thresholds for specific cases. As such, this simulation is needed to finish *Figure 11*. This part of the project generates a high-resolution bifurcation diagram which is then manually examined to find the threshold for alternans initiation. The results are further examined to determine if the individual should be removed from the study or if its alternans thresholds need to be updated.\
*The following elements are added to this folder:*\
•	**Bifurcation Diagrams:** This subfolder is used to store the bifurcation diagrams that are generated by *ThresholdSearch.m*.\
•	**TimeCourse:** This subfolder is used to store the action potential and calcium transient traces that are generated by *ThresholdSearch.m*.\
•	**ConfirmConvergence.py:** This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs. A BCL cutoff is applied to exclude extremely fast pacing rates. Two individuals are moved to *ConfirmConvergenceSecond.py* because it is necessary to consider them at these pacing rates. \
•	**ConfirmConvergenceSecond.py:** This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs. The individuals excluded from *ConfirmConvergence.py:* are considered here.*\
•	**ThresholdSearch.m:** This analysis code generates images of bifurcation diagrams, identifies the alternans thresholds, and plots the action potential and calcium transient at the threshold and at the closest BCL without alternans.\
•	**AlternansThresholdSummary.txt:** This text file gives the alternans thresholds for the model variations tested in this folder.
### ***Folder 10 - Alternans Threshold Search Analysis Follow-Up Simulations (Part 3):***
This folder is needed to follow-up on the results from *Folders 6-7* and correct the alternans thresholds for specific cases. As such, this simulation is needed to finish Figure 11. This part of the project generates a high-resolution bifurcation diagram which is then manually examined to find the threshold for alternans initiation. The results are further examined to determine if the individual should be removed from the study or if its alternans thresholds need to be updated.\
*The following elements are added to this folder:*\
•	**Bifurcation Diagrams:** This subfolder is used to store the bifurcation diagrams that are generated by *ThresholdSearch.m*.\
•	**TimeCourse:** This subfolder is used to store the action potential and calcium transient traces that are generated by *ThresholdSearch.m*.\
•	**ConfirmConvergence.py:** This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs.\
•	**ThresholdSearch.m:** This analysis code generates images of bifurcation diagrams, identifies the alternans thresholds, and plots the action potential and calcium transient at the threshold and at the closest BCL without alternans. \
•	**AlternansThresholdSummary.txt:** This text file gives the alternans thresholds for the model variations tested in this folder.
### ***Folder 11 - APD Restitution Curve Analysis:***
This folder is needed to recreate Figure 12A. This part of the project involves running the APD restitution curve analysis, analyzing the results, and creating the necessary figure. It is worth noting that the cell is paced to steady-state at 2.5Hz prior to the experiment, which ensures that the contribution of long-term memory effects is reproducible.\
*The following elements are added to this folder:*\
•	**RestitutionCurveAnalysis.py:** This code analyzes the action potential waveform from the simulation to generate the APD and DI data for the restitution curve. The outputs are saved to text files.\
•	**RestitutionCurvePlot.m:** This code uses the output files from *RestitutionCurveAnalysis.py* to create the necessary figure panel.
### ***Folder 12 - Action Potential Clamp Analysis:***
This folder is needed to recreate Figure 12B-C. This part of the project involves processing the raw time course traces from Folder 5, running the baseline and microgravity model simulations with an AP clamp, and creating the necessary figure.\
*The following elements are added to this folder:*\
•	**AlternansThresholdsGuess:** This subfolder is used to store estimated locations of the alternans thresholds based on the results of the previous simulation. These values are needed for this folder to work properly.\
•	**Baseline APs:** This subfolder stores the initial action potential clamps, that are generated by *APClampExtraction.py*.\
•	**Baseline AP Correction:** This subfolder stores the final action potential clamps, which are created from those in *Baseline APs*, using *CorrectRecording.m*.\
•	**ConfirmConvergence.py:** This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs.\
•	**TimeCourseScreening.py:** This script is used to confirm that the model behaves in a physiologically reasonable manner.\
•	**TimeCourseAnalysis.m:** This code compares the original action potential waveforms from *Folder 5* to the clamped versions. It may be necessary to change the paths within the code to get it to run properly.\
•	**TimeCourseTraces.m:** This script plots the calcium transients and action potential for the action potential clamp simulations.\
•	**APClampExtraction.py:** This file is used to extract the action potential waveforms from *Folder 5*.\
•	**CorrectRecording.m:** This file is used to align the action potential waveform recordings.\
•	**MicrogravityEffect_APC.m:** This file is used to generate the bifurcation diagrams for *Figure 12*.
### ***References:***
•	Ding, Y., Lang, D., Yan, J., Bu, H., Li, H., Jiao, K., Yang, J., Ni, H., Morotti, S., Le, T., Clark, K.J., Port, J., Ekker, S.C., Cao, H., Zhang, Y., Wang, J., Grandi, E., Li, Z., Shi, Y., … Xu, X. (2022). A phenotype-based forward genetic screen identifies Dnajb6 as a sick sinus syndrome gene. eLife,; DOI: 10.7554/eLife.77327. \
•	Mahajan, A., Shiferaw, Y., Sato, D., Baher, A., Olcese, R., Xie, L.-H., Yang, M.-J., Chen, P.-S., Restrepo, J.G., Karma, A., Garfinkel, A., Qu, Z., & Weiss, J.N. (2008). A rabbit ventricular action potential model replicating cardiac dynamics at rapid heart rates. Biophys J, 94(2), 392–410. https://doi.org/10.1529/biophysj.106.98160. \
•	Morotti, S., Ni, H., Peters, C.H., Rickert, C., Asgari-Targhi, A., Sato, D., Glukhov, A.V., Proenza, C., & Grandi, E. (2021). Intracellular na+ modulates pacemaking activity in murine sinoatrial node myocytes: an in silico analysis. Int J Mol Sci,; DOI: 10.3390/ijms22115645. \
•	Morotti, S., Nieves-Cintrón, M., Nystoriak, M.A., Navedo, M.F., & Grandi, E. (2017). Predominant contribution of L-type Cav1.2 channel stimulation to impaired intracellular calcium and cerebral artery vasoconstriction in diabetic hyperglycemia. Channels (Austin), 11(4), 340–346. https://doi.org/10.1080/19336950.2017.1293220.
