{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 TimesNewRomanPS-BoldMT;\f1\fswiss\fcharset0 Helvetica;\f2\froman\fcharset0 TimesNewRomanPSMT;
\f3\froman\fcharset0 TimesNewRomanPS-ItalicMT;\f4\ftech\fcharset77 Symbol;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;\red0\green0\blue0;\red34\green255\blue6;
\red255\green255\blue11;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;\cssrgb\c0\c0\c0\c84706;\cssrgb\c0\c100000\c0;
\cssrgb\c100000\c100000\c0;}
\margl1440\margr1440\vieww30040\viewh16480\viewkind0
\deftab720
\pard\pardeftab720\sl368\partightenfactor0

\f0\b\fs32 \cf2 \expnd0\expndtw0\kerning0
Introduction:
\f1\b0 \
\pard\pardeftab720\sl368\partightenfactor0

\f2 \cf2 The following code can be used to verify the figures and statements made in the Master\'92s Thesis of Tymoteusz Bak. The code is divided into twelve folders, whose contents are defined below. The original Mahajan Model files (
\f3\i cell.cc
\f2\i0 , 
\f3\i make
\f2\i0 , and 
\f3\i cell.h
\f2\i0 ) were provided by Dr Daisuke Sato and revised as appropriate {\field{\*\fldinst{HYPERLINK "https://sciwheel.com/work/citation?ids=1148390&pre=&suf=&sa=0&dbf=0"}}{\fldrslt \cf3 \ul \ulc3 (Mahajan\uc0\u8197 et\u8197 al.,\u8197 2008)}}. The original population of models files (
\f3\i PLS_nipals.m
\f2\i0  and 
\f3\i SMC_SA3_sensitivity.m
\f2\i0 ) were provided by Dr Stefano Morotti {\field{\*\fldinst{HYPERLINK "https://sciwheel.com/work/citation?ids=17063575&pre=&suf=&sa=0&dbf=0"}}{\fldrslt \cf3 \ul \ulc3 (Morotti\uc0\u8197 et\u8197 al.,\u8197 2017)}}. The core simulation code (
\f3\i MahajanRecorder.cpp
\f2\i0 ) was written using a script written by Roshni Shetty as a template. When interpreting the results of the population of models analysis, two additional sources provided helpful insight {\field{\*\fldinst{HYPERLINK "https://sciwheel.com/work/citation?ids=18615852,15644636&pre=&pre=&suf=&suf=&sa=0,0&dbf=0&dbf=0"}}{\fldrslt \cf3 \ul \ulc3 (Morotti\uc0\u8197 et\u8197 al.,\u8197 2021;\u8197 Ding\u8197 et\u8197 al.,\u8197 2022)}}.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f3\i \cf2 \ul \ulc2 The following elements are present either in every folder or almost every folder:
\f1\i0 \ulnone \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul cell.h\ulnone : This is a header file for the cell object in the simulations. It is the same in each folder.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul cell.cc\ulnone : This is the main file for the cell object in the simulations. With the exception of Folder 1, it is the same in each folder.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul InitialCondition.csv\ulnone : This file describes the initial condition of the cell for each folder. It is the same in each folder; however, Folder 1 overwrites some initial values directly in the code.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul MahajanRecorder.cpp\ulnone : This is the core simulation script.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul Individuals\ulnone : This subfolder stores the text files that define specific model variations. Folders 3, 6, and 7 populate this subfolder with a MATLAB script.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul Outcomes_n\ulnone : This subfolder stores the text files that contain the outcomes of each simulation. This subfolder is absent in Folder 1.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul Outcomes_t\ulnone : This subfolder stores the text files that contain the waveform for each simulation. The last 10000ms are recorded for each basic cycle length (BCL) \'96 Individual combination with a 1ms sampling rate. This subfolder is absent in Folder 1.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul Makefile\ulnone : This file can be used to compile the code.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ExecutionFile.txt\ulnone : This text file contains commands that can be copied into a terminal window to run the main simulation. Folders 3, 6, and 7 generate this file with a MATLAB script. This will only work if the terminal is open to the appropriate directory and all of the prerequisite files are present.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f0\b \cf2 \cb4 Folder 1 - LTCC Voltage Dependent Activation:
\f1\b0 \cb1 \
\pard\pardeftab720\sl368\partightenfactor0

\f2 \cf2 This folder can be used to recreate Figure 1 in the thesis. The simulation protocol is meant to characterize the behavior of the L-type Ca
\fs26\fsmilli13333 \super 2+
\fs32 \nosupersub  channel (LTCC) with a voltage clamp analysis.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f3\i \cf2 \ul The following elements are added to this folder:
\f1\i0 \ulnone \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul Results1\ulnone : This subfolder stores the main outcomes of the simulation in this folder.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul Results2\ulnone : This subfolder stores the same information as 
\f3\i Outcomes_t
\f2\i0 ; however, it records the entire simulation protocol instead of the last 10000ms. In addition, it also records the LTCC current.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul VDA_TimeCourseDisplay2.m\ulnone : This script is used to generate the panels of Figure 1.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul InactivationAnalysis_CaTD50.m\ulnone : This segment of code estimates the inactivation behavior of the LTCC at 0mV membrane potentials. Time to 50% decay of the normalized current is considered in this analysis.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul InactivationAnalysis_Tau.m\ulnone : This segment of code estimates the inactivation behavior of the LTCC at 0mV membrane potentials. Time constant of exponential decay of the normalized current is considered in this analysis.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f0\b \cf2 \cb4 Folder 2 - Microgravity Effects on Biomarkers:
\f1\b0 \cb1 \
\pard\pardeftab720\sl368\partightenfactor0

\f2 \cf2 This folder can be used to recreate Figure 2 and Figure 4 in the thesis. In addition, it is used to describe the baseline and microgravity models in Figure 5. This part of the project involves determining the steady-state behavior of these two models at 2.5Hz, analyzing the results, and creating the figures of interest.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f3\i \cf2 \ul The following elements are added to this folder:
\f1\i0 \ulnone \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ConfirmConvergence.py\ulnone : This script studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul TimeCourseScreening.py\ulnone : This script studies the action potential and calcium transient properties to ensure that the model behaves in a physiological manner.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul TimeCourseTraces400ms.m\ulnone : This script generates time course trace images for the baseline and microgravity models.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ValidationParameterDefinition.m\ulnone : This script generates an image of the action potential, calcium transient, and non-junctional sarcoplasmic reticulum calcium content waveforms. The plot includes threshold lines, which can be used to recreate Figure 2 in PowerPoint.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ValidationPlot.m\ulnone : This plot is meant to compare the results to the cited data.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f0\b \cf2 \cb4 Folder 3 - Population of Models Analysis at 2.5Hz:
\f1\b0 \cb1 \
\pard\pardeftab720\sl368\partightenfactor0

\f2 \cf2 This folder can be used to recreate Figure 5 in the thesis. The necessary values from Folder 2 were manually copied into the relevant script. This part of the project involves generating a population of models, pacing each individual to steady-state at 2.5Hz, analyzing the results, and creating the figures of interest.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f3\i \cf2 \ul The following elements are added to this folder:
\f1\i0 \ulnone \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul GeneratePopulation.m\ulnone : This script is used to generate the population of models in a random and reproducible manner. This is achieved by applying a fixed random seed, which ensures that the same population is used in each analysis. This file also writes 
\f3\i ExecutionFile.txt
\f2\i0  for this folder.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul DataFrameWriting.py\ulnone : This file is used to extract data for odd and even steady-state beats for every individual in the population.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ConfirmConvergence.py\ulnone : This script studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul TimeCourseScreening.py\ulnone : This script studies the action potential and calcium transient properties to ensure that the model behaves in a physiological manner.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul TimeCourseDisplay.py\ulnone : This code extracts AP and CaT time course traces from the simulations for a 1000ms interval and stores them in a text file.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul PopulationDescriptionTraces.m\ulnone : This code creates time course traces for each member of the population of models. The data from 
\f3\i TimeCourseDisplay.py
\f2\i0  is used in this plot and the exclusion criteria from the alternans analysis are used to exclude the appropriate traces from the image.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul DataAnalysisBaselineOnly.m\ulnone : This code processes and plots the data from 
\f3\i DataFrameWriting.py
\f2\i0 . The statistical significance of parameter correlations is also computed at this stage. The exclusion of specific individuals from the population is applied at this point in the analysis.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul SMC_SA3_sensitivity_Baseline.m\ulnone : This is an adaptation of a MATLAB script from another study that finishes the population of models analysis and generates the appropriate plots.
\f1 \
\pard\pardeftab720\li960\fi-480\sl368\sa213\partightenfactor0

\f4 \cf2 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul PLS_nipals.m\ulnone : This is an imported function that is necessary for the population of models analysis. The file is a verbatim copy of a script written by Dr Stefano Morotti.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f0\b \cf2 \cb4 Folder 4 - Bifurcation Diagram Generation (Stage 1):
\f1\b0 \cb1 \
\pard\pardeftab720\sl368\partightenfactor0

\f2 \cf2 This folder describes a preliminary analysis that is not used to create any figures; however, the results of this analysis are used by Folder 5. This part of the project involves generating a course bifurcation diagram for the baseline model, the microgravity model, six baseline model variations (5 baseline model parameters + 1 microgravity model parameter), and six microgravity model variations (1 baseline model parameter + 5 microgravity model parameters). The alternans thresholds from these curves are needed in Folder 5.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f3\i \cf2 \ul The following elements are added to this folder:
\f1\i0 \ulnone \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul AlternansThresholds\ulnone : This subfolder is used to store estimated locations of the alternans thresholds based on the results of this simulation.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul BFD_Generator_Complete.m\ulnone : This script reads the contents of 
\f3\i Outcomes_n
\f2\i0  and uses them to estimate the alternans thresholds. The results are saved in 
\f3\i AlternansThresholds
\f2\i0 .
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f0\b \cf2 \cb4 Folder 5 - Bifurcation Diagram Generation (Stage 2):
\f1\b0 \cb1 \
\pard\pardeftab720\sl368\partightenfactor0

\f2 \cf2 This folder can be used to recreate Figures 6-10. The approximate locations 
\f1 \

\f2 of the bifurcation point are copied from Folder 4. This part of the project involves generating a bifurcation diagram with a high-resolution description of frequencies near the bifurcation point. The code in this section is also used to prepare the raw action potential (AP) traces for Folder 12.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f3\i \cf2 \ul The following elements are added to this folder:
\f1\i0 \ulnone \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul AlternansThresholds\ulnone : This subfolder is used to store estimated locations of the alternans thresholds based on the results of this simulation.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul AlternansThresholdsGuess\ulnone : This subfolder is used to store estimated locations of the alternans thresholds based on the results of the previous simulation. These values are needed for this folder to work properly.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul BFD_Generator_Complete.m\ulnone : This script reads the contents of 
\f3\i Outcomes_n
\f2\i0  and uses them to estimate the alternans thresholds. The results are saved in 
\f3\i AlternansThresholds
\f2\i0 .
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul AlternansThresholdAnalysis.m\ulnone : This code contains a copy of the results from 
\f3\i AlternansThresholds
\f2\i0  which is displayed visually to create Figure 10.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul RyR_Analysis.m\ulnone : The results of this script are not explicitly shown in the thesis; however, it contains the analysis for ryanodine receptor strength (g
\fs26\fsmilli13333 \sub RyR
\fs32 \nosupersub ) that is analogous to Figures 6-8.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul Leak_Analysis.m\ulnone : The results of this script are not explicitly shown in the thesis; however, it contains the analysis for the leak flux (g
\fs26\fsmilli13333 \sub leak
\fs32 \nosupersub ) that is analogous to Figures 6-8.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul PLB_Analysis.m\ulnone : The results of this script are not explicitly shown in the thesis; however, it contains the analysis for the phospholamban effect (Kmf
\fs26\fsmilli13333 \sub SERCA
\fs32 \nosupersub ) that is analogous to Figures 6-8.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul gLTCC_Analysis.m\ulnone : This script analyzes the contents of 
\f3\i Outcomes_n
\f2\i0  to recreate Figure 6 panels.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul vth_Analysis.m\ulnone : This script analyzes the contents of 
\f3\i Outcomes_n
\f2\i0  to recreate Figure 7 panels.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul NaK_Analysis.m\ulnone : This script analyzes the contents of 
\f3\i Outcomes_n
\f2\i0  to recreate Figure 8 panels.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ConfirmConvergence.py\ulnone : This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be studied to examine any drift that occurs.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ConfirmConvergenceAPC.py\ulnone : This script is essentially the same as 
\f3\i ConfirmConvergence.py
\f2\i0 ; however, it is used to evaluate the simulation that is used to generate the AP clamp recordings.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul MicrogravityEffect.m\ulnone : This script is used to generate the bifurcation diagrams for Figure 9.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul TimeCourse4Hz.m\ulnone : This script is used to generate the time course traces for Figure 9.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul TimeCourseScreening.py\ulnone : This script is used to confirm that the model behaves in a physiologically reasonable manner.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f0\b \cf2 Folder 6 - Alternans Threshold Search Analysis (Calcium):
\f1\b0 \
\pard\pardeftab720\sl368\partightenfactor0

\f2 \cf2 This folder is needed to recreate Figure 11B-C. This part of the project involves generating a population of models (same population as Folder 3), estimating the calcium transient alternans threshold for each individual, analyzing the results, and creating the figure of interest. Refer to Folders 8-10 for the follow-up analysis.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f3\i \cf2 \ul The following elements are added to this folder:
\f1\i0 \ulnone \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \cb4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul AlternansThresholds\ulnone : This subfolder is used to store estimated locations of the alternans thresholds based on the results of this simulation.
\f1 \cb1 \

\f4 \cb4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul GeneratePopulation.m\ulnone : This script is used to generate the population of models in a random and reproducible manner. This is achieved by applying a fixed random seed, which ensures that the same population is used in each analysis. This files also writes 
\f3\i ExecutionFile.txt
\f2\i0  for this folder.
\f1 \cb1 \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \cb5 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul CalciumTransientAnalysisFull.py\ulnone : This script is used to create a short analysis file to confirm that the model behaves in a reasonable manner. Specifically, it computes the action potential duration, calcium transient amplitude, peak systolic cytosolic calcium, and end diastolic cytosolic calcium, at the identified alternans threshold and at the closest BCL without alternans. The file is analyzed in 
\f3\i CalciumTransientAnalysisFollowUp.py
\f2\i0 .
\f1 \cb1 \

\f4 \cb5 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul CalciumTransientAnalysisFollowUp.py\ulnone : This file analyzes the results of 
\f3\i CalciumTransientAnalysisFull.py
\f2\i0  to confirm that the alternans thresholds meet the necessary criteria.
\f1 \cb1 \

\f4 \cb5 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul CalciumTransientAnalysisThresholdAnalysis.py\ulnone : This file is used to visually inspect the individuals that failed in the simulation from this folder.
\f1 \cb1 \

\f4 \cb5 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul SensitivityAnalysisPreparation.m\ulnone : This code processes the simulation outputs, removes the excluded models from the analysis, and prepares the inputs, outputs, and p-values for the Ca
\fs26\fsmilli13333 \super 2+
\fs32 \nosupersub  alternans analysis.
\f1 \cb1 \

\f4 \cb5 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul SMC_SA3_sensitivity_Baseline.m\ulnone : This is an adaptation of a MATLAB script from another study that finishes the population of models analysis and generates the appropriate plots.
\f1 \cb1 \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \cb4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul PLS_nipals.m\ulnone : This is an imported function that is necessary for the population of models analysis. The code is a verbatim copy of a script written by Dr Stefano Morotti.
\f1 \cb1 \

\f4 \cb4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ConfirmConvergence.py\ulnone : This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to examine any drift that occurs. Note that only BCLs that are less than 10ms from the threshold are considered.
\f1 \cb1 \
\pard\pardeftab720\sl368\partightenfactor0

\f0\b \cf2 Folder 7 - Alternans Threshold Search Analysis (Action Potential):
\f1\b0 \
\pard\pardeftab720\sl368\partightenfactor0

\f2 \cf2 This folder is needed to recreate Figure 11A and Figure 11D. This part of the project involves generating a population of models (same population as Folder 3), estimating the action potential duration (APD) alternans threshold for each individual, analyzing the results, and creating the figure of interest. Refer to Folders 8-10 for the follow-up analysis.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f3\i \cf2 \ul The following elements are added to this folder:
\f1\i0 \ulnone \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \cb4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul AlternansThresholds\ulnone : This subfolder is used to store estimated locations of the alternans thresholds based on the results of this simulation.
\f1 \cb1 \

\f4 \cb4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul GeneratePopulation.m\ulnone : This script is used to generate the population of models in a random and reproducible manner. This is achieved by applying a fixed random seed, which ensures that the same population is used in each analysis. This files also writes 
\f3\i ExecutionFile.txt
\f2\i0  for this folder.
\f1 \cb1 \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \cb5 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul CalciumTransientAnalysisFull.py\ulnone : This script is used to create a short analysis file to confirm that the model behaves in a reasonable manner. Specifically, it computes the action potential duration, calcium transient amplitude, peak systolic cytosolic calcium, and end diastolic cytosolic calcium, at the identified alternans threshold and at the closest BCL without alternans. The file is analyzed in 
\f3\i CalciumTransientAnalysisFollowUp.py
\f2\i0 .
\f1 \cb1 \

\f4 \cb5 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul CalciumTransientAnalysisFollowUp.py\ulnone : This file analyzes the results of 
\f3\i CalciumTransientAnalysisFull.py
\f2\i0  to confirm that the alternans thresholds meet the necessary criteria.
\f1 \cb1 \

\f4 \cb5 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul CalciumTransientAnalysisThresholdAnalysis.py\ulnone : This file is used to visually inspect the individuals that failed in the simulation from this folder.
\f1 \cb1 \

\f4 \cb5 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul SensitivityAnalysisPreparation.m\ulnone : This code processes the simulation outputs, removes the excluded models from the analysis, and prepares the inputs, outputs, and p-values for the AP alternans analysis
\f1 \cb1 \

\f4 \cb5 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul SMC_SA3_sensitivity.m\ulnone : This is an adaptation of a MATLAB script from another study that finishes the population of models analysis and generates the appropriate plots.
\f1 \cb1 \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \cb4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul PLS_nipals.m\ulnone : This is an imported function that is necessary for the population of models analysis. The code is a verbatim copy of a script written by Dr Stefano Morotti.
\f1 \cb1 \

\f4 \cb4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ConfirmConvergence.py\ulnone : This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs. Note that only BCLs that are less than 10ms from the threshold are considered.
\f1 \cb1 \
\pard\pardeftab720\sl368\partightenfactor0

\f0\b \cf2 \cb4 Folder 8 - Alternans Threshold Search Analysis Follow-Up Simulations (Part 1):
\f1\b0 \cb1 \
\pard\pardeftab720\sl368\partightenfactor0

\f2 \cf2 This folder is needed to follow-up on the results from Folders 6-7 and correct the alternans thresholds for specific cases. As such, this simulation is needed to finish Figure 11. This part of the project generates a high-resolution bifurcation diagram which is then manually examined to find the threshold for alternans initiation. The results are further examined to determine if the individual should be removed from the study or if its alternans thresholds need to be updated.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f3\i \cf2 \ul The following elements are added to this folder:
\f1\i0 \ulnone \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul Bifurcation Diagrams\ulnone : This subfolder is used to store the bifurcation diagrams that are generated by 
\f3\i ThresholdSearch.m
\f2\i0 .
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul TimeCourse\ulnone : This subfolder is used to store the action potential and calcium transient traces that are generated by 
\f3\i ThresholdSearch.m
\f2\i0 .
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ConfirmConvergence.py\ulnone : This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ThresholdSearch.m\ulnone : This analysis code generates images of bifurcation diagrams, identifies the alternans thresholds, and plots the action potential and calcium transient at the threshold and at the closest BCL without alternans. 
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul AlternansThresholdSummary.txt\ulnone : This text file gives the alternans thresholds for the model variations tested in this folder.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f0\b \cf2 \cb4 Folder 9 - Alternans Threshold Search Analysis Follow-Up Simulations (Part 2):
\f1\b0 \cb1 \
\pard\pardeftab720\sl368\partightenfactor0

\f2 \cf2 This folder is needed to follow-up on the results from Folders 6-7 and correct the alternans thresholds for specific cases. As such, this simulation is needed to finish Figure 11. This part of the project generates a high-resolution bifurcation diagram which is then manually examined to find the threshold for alternans initiation. The results are further examined to determine if the individual should be removed from the study or if its alternans thresholds need to be updated.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f3\i \cf2 \ul The following elements are added to this folder:
\f1\i0 \ulnone \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul Bifurcation Diagrams\ulnone : This subfolder is used to store the bifurcation diagrams that are generated by 
\f3\i ThresholdSearch.m
\f2\i0 .
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul TimeCourse\ulnone : This subfolder is used to store the action potential and calcium transient traces that are generated by 
\f3\i ThresholdSearch.m
\f2\i0 .
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ConfirmConvergence.py\ulnone : This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ThresholdSearch.m\ulnone : This analysis code generates images of bifurcation diagrams, identifies the alternans thresholds, and plots the action potential and calcium transient at the threshold and at the closest BCL without alternans. 
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul AlternansThresholdSummary.txt\ulnone : This text file gives the alternans thresholds for the model variations tested in this folder.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f0\b \cf2 \cb4 Folder 10 - Alternans Threshold Search Analysis Follow-Up Simulations (Part 3):
\f1\b0 \cb1 \
\pard\pardeftab720\sl368\partightenfactor0

\f2 \cf2 This folder is needed to follow-up on the results from Folders 6-7 and correct the alternans thresholds for specific cases. As such, this simulation is needed to finish Figure 11. This part of the project generates a high-resolution bifurcation diagram which is then manually examined to find the threshold for alternans initiation. The results are further examined to determine if the individual should be removed from the study or if its alternans thresholds need to be updated.
\f1 \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul Bifurcation Diagrams\ulnone : This subfolder is used to store the bifurcation diagrams that are generated by 
\f3\i ThresholdSearch.m
\f2\i0 .
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul TimeCourse\ulnone : This subfolder is used to store the action potential and calcium transient traces that are generated by 
\f3\i ThresholdSearch.m
\f2\i0 .
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ConfirmConvergence.py\ulnone : This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ThresholdSearch.m\ulnone : This analysis code generates images of bifurcation diagrams, identifies the alternans thresholds, and plots the action potential and calcium transient at the threshold and at the closest BCL without alternans. 
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul AlternansThresholdSummary.txt\ulnone : This text file gives the alternans thresholds for the model variations tested in this folder.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f0\b \cf2 \cb4 Folder 11 - APD Restitution Curve Analysis:
\f1\b0 \cb1 \
\pard\pardeftab720\sl368\partightenfactor0

\f2 \cf2 This folder is needed to recreate Figure 12A. This part of the project involves running the APD restitution curve analysis, analyzing the results, and creating the necessary figure. It is worth noting that the cell is paced to steady-state at 2.5Hz prior to the experiment, which ensures that the contribution of long-term memory effects is reproducible.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f3\i \cf2 \ul The following elements are added to this folder:
\f1\i0 \ulnone \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul RestitutionCurveAnalysis.py\ulnone : This code analyzes the action potential waveform from the simulation to generate the APD and DI data for the restitution curve. The outputs are saved to text files which are omitted from this list.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul RestitutionCurvePlot.m\ulnone : This code uses the output files from\ul  
\f3\i \ulnone RestitutionCurveAnalysis.py
\f2\i0  to create the necessary figure panel.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f0\b \cf2 \cb4 Folder 12 - Action Potential Clamp Analysis:
\f1\b0 \cb1 \
\pard\pardeftab720\sl368\partightenfactor0

\f2 \cf2 This folder is needed to recreate Figure 12B-C. This part of the project involves processing the raw time course traces from Folder 5, running the baseline and microgravity model simulations with an AP clamp, and creating the necessary figure.
\f1 \
\pard\pardeftab720\sl368\partightenfactor0

\f3\i \cf2 \ul The following elements are added to this folder:
\f1\i0 \ulnone \
\pard\pardeftab720\li960\fi-480\sl368\partightenfactor0

\f4 \cf2 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul AlternansThresholdsGuess\ulnone : This subfolder is used to store estimated locations of the alternans thresholds based on the results of the previous simulation. These values are needed for this folder to work properly.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul Baseline APs\ulnone : This subfolder stores the initial action potential clamps, that are generated by 
\f3\i APClampExtraction.py
\f2\i0 .
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul Baseline AP Correction\ulnone : This subfolder stores the final action potential clamps, which are created from those in 
\f3\i Baseline APs
\f2\i0 , using 
\f3\i CorrectRecording.m
\f2\i0 .
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul ConfirmConvergence.py\ulnone : This is a Python script that studies the biomarkers in the last 100 beats of the simulation to determine how well the system converged to steady-state. The printout can be examined to study any drift that occurs.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul TimeCourseScreening.py\ulnone : This script is used to confirm that the model behaves in a physiologically reasonable manner.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul TimeCourseAnalysis.m\ulnone : This code compares the original action potential waveforms from Folder 5 to the clamped versions. It may be necessary to change the paths within the code to get it to run properly.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul TimeCourseTraces.m\ulnone : This script plots the calcium transients and action potential for the action potential clamp simulations.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul APClampExtraction.py\ulnone : This file is used to extract the action potential waveforms from Folder 5.
\f1 \

\f4 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul CorrectRecording.m\ulnone : This file is used to align the action potential waveform recordings.
\f1 \
\pard\pardeftab720\li960\fi-480\sl368\sa213\partightenfactor0

\f4 \cf2 \'e1
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0\'a0 
\fs32 \ul MicrogravityEffect_APC.m\ulnone : This file is used to generate the bifurcation diagrams for Figure 12.
\f1 \
\pard\pardeftab720\sl368\sa213\partightenfactor0

\f0\b \cf2 References:
\f1\b0 \
\pard\pardeftab720\li320\fi-320\sa320\partightenfactor0
{\field{\*\fldinst{HYPERLINK "https://sciwheel.com/work/bibliography/15644636"}}{\fldrslt 
\f2 \cf2 \ul Ding, Y., Lang, D., Yan, J., Bu, H., Li, H., Jiao, K., Yang, J., Ni, H., Morotti, S., Le, T., Clark, K.J., Port, J., Ekker, S.C., Cao, H., Zhang, Y., Wang, J., Grandi, E., Li, Z., Shi, Y., \'85 Xu, X. (2022). A phenotype-based forward genetic screen identifies Dnajb6 as a sick sinus syndrome gene. 
\f3\i eLife
\f2\i0 ,; DOI: 10.7554/eLife.77327.}}
\f2 \
\pard\pardeftab720\li320\fi-320\sa320\partightenfactor0
{\field{\*\fldinst{HYPERLINK "https://sciwheel.com/work/bibliography/1148390"}}{\fldrslt \cf2 \ul Mahajan, A., Shiferaw, Y., Sato, D., Baher, A., Olcese, R., Xie, L.-H., Yang, M.-J., Chen, P.-S., Restrepo, J.G., Karma, A., Garfinkel, A., Qu, Z., & Weiss, J.N. (2008). A rabbit ventricular action potential model replicating cardiac dynamics at rapid heart rates. 
\f3\i Biophys J
\f2\i0 , 
\f0\b 94
\f2\b0 (2), 392\'96410. https://doi.org/10.1529/biophysj.106.98160.}}\
{\field{\*\fldinst{HYPERLINK "https://sciwheel.com/work/bibliography/18615852"}}{\fldrslt \ul Morotti, S., Ni, H., Peters, C.H., Rickert, C., Asgari-Targhi, A., Sato, D., Glukhov, A.V., Proenza, C., & Grandi, E. (2021). Intracellular na+ modulates pacemaking activity in murine sinoatrial node myocytes: an in silico analysis. 
\f3\i Int J Mol Sci
\f2\i0 ,; DOI: 10.3390/ijms22115645.}}\
{\field{\*\fldinst{HYPERLINK "applewebdata://5554ABCB-E29D-458E-A200-BB59C6FEB9C0/Morotti,%20S.,%20Nieves-Cintr%C3%B3n,%20M.,%20Nystoriak,%20M.A.,%20Navedo,%20M.F.,%20&%20Grandi,%20E.%20(2017).%20Predominant%20contribution%20of%20L-type%20Cav1.2%20channel%20stimulation%20to%20impaired%20intracellular%20calcium%20and%20cerebral%20artery%20vasoconstriction%20in%20diabetic%20hyperglycemia.%20Channels%20(Austin),%2011(4),%20340%E2%80%93346.%20https:/doi.org/10.1080/19336950.2017.1293220."}}{\fldrslt \ul Morotti, S., Nieves-Cintr\'f3n, M., Nystoriak, M.A., Navedo, M.F., & Grandi, E. (2017). Predominant contribution of L-type Cav1.2 channel stimulation to impaired intracellular calcium and cerebral artery vasoconstriction in diabetic hyperglycemia. 
\f3\i Channels (Austin)
\f2\i0 , 
\f0\b 11
\f2\b0 (4), 340\'96346. https://doi.org/10.1080/19336950.2017.1293220.}} \
}