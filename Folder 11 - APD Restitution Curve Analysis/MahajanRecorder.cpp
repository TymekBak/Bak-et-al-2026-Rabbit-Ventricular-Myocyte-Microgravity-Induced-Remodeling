#include "cell.h"
#include <fstream>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>     
#include <math.h>
#include <time.h>
#include <ctime>
#include <string.h>
#include <vector>
using namespace std;

// for mkdir
#include <sys/types.h>
#include <sys/stat.h>

//Copy and paste these run commands into a terminal to run the simulation after executing the makefile.
//      Run Command: ./MahajanRecorder Individuals/Baseline.txt Outcomes_n/Baseline.txt Outcomes_t/Baseline.txt 
//      Run Command: ./MahajanRecorder Individuals/Manuscript.txt Outcomes_n/Manuscript.txt Outcomes_t/Manuscript.txt 

//Model Input Parameters:
// 1. gRyR: SR Release Flux Strength
// 2. av: SR Release Slope ([Ca2+]JSR>1.5mM)
// 3. vup: Maximum Reuptake Flux
// 4. cup: SERCA Affinity for Ca2+
// 5. gca: LTCC Flux Strength
// 6. vth: LTCC Markov Model Parameter
// 7. gtos: Transient Outward K+ Current Conductance (Slow Component)
// 8. gtof: Transient Outward K+ Current Conductance (Fast Component)
// 9. gnaca: Na+/Ca2+ Exchange Flux Strength
// 10. gks: Delayed Rectifier K+ Current Conductance (Slow Component)
// 11. gkr: Delayed Rectifier K+ Current Conductance (Rapid Component)
// 12. gna: Fast Na+ Current Conductance
// 13. gkix: Inward Rectifier K+ Current Conductance
// 14. gnak: Na+/K+ Pump Current Conductance
// 15. gleak: SR Leak Strength

//Model Parameters
// 1. m: Fast Sodium Channel Gating Variable
// 2. h: Fast Sodium Channel Gating Variable
// 3. j: Fast Sodium Channel Gating Variable
// 4. xr: Delayed Rectifier K+ Current Gating Variable (Rapid Component)
// 5. xs1: Delayed Rectifier K+ Current Gating Variable (Slow Component)
// 6. xs2: Delayed Rectifier K+ Current Gating Variable (Slow Component)
// 7. xtos: Transient Outward K+ Current Gating Variable (Slow Component)
// 8. ytos: Transient Outward K+ Current Gating Variable (Slow Component)
// 9. v: Membrane Potential
// 10. cp: Calcium in Dyadic Junction
// 11. cs: Calcium in Subsarcolemmal Space
// 12. ci: Calcium in Cytoplasm Space
// 13. cnsr: Calcium in Non-junctional SR
// 14. cjsr: Calcium in Junctional SR
// 15. xir: SR Release Flux
// 16. c1: LTCC Markov Model State
// 17. c2: LTCC Markov Model State
// 18. xi1ca: LTCC Markov Model State
// 19. xi1ba: LTCC Markov Model State
// 20. xi1ca: LTCC Markov Model State
// 21. xi1ba: LTCC Markov Model State
// 22. nai: Sodium Concentration
// 23. xtof: Transient Outward K+ Current Gating Variable (Fast Component)
// 24. ytof: Transient Outward K+ Current Gating Variable (Fast Component)
// 25. tropi: Cytoplasmic Troponin Buffering
// 26. trops: Subsarcolemmal Space Troponin Buffering

//Outcomes_n (each row has the following values that are seperated with "   "; each value is calculated over the course of one BCL)
//1. BCL (after initial pacing, otherwise 0)
//2. Beat Number
//3. APD
//4. Maximum Cytoplasmic Calcium
//5. End Diastolic Calcium
//6. Maximum SR Calcium
//7. Minimum SR Calcium
//8. Maximum Cytoplasmic Sodium
//9. Minimum Cytoplasmic Sodium
//10. CaTD50 (Decay Only)
//11. TTP

//Outcomes_t (each row has the following values that are seperated with "   "; each value is calculated with a 1ms sampling rate)
//1. BCL
//2. Time
//3-28. Model Parameters

int main(int argc, char *argv[]) {
    //Read the model input parameters from the input text file.
    char *InputFile = argv[1];
    double input2[15];
    FILE *fp2;
    fp2 = fopen( InputFile, "r");
    cout << "Input Parameters: " << endl;

    for ( int idy = 0; idy < 15; idy++ ) {
        fscanf ( fp2, "%lf", &input2[idy] );
        cout << idy << "\t" << input2[idy] << endl;
    }
    fclose( fp2 );

    //Create the output files to enable the recording of simulation data.
    char *OutputFile = argv[2];
    std::ofstream Validation_Parameters_n(OutputFile);
    char *OutputFile2 = argv[3];
    std::ofstream Validation_Parameters_t(OutputFile2);

    //Create the cell object and load the initial conditions from a .csv file.
    CCell VM;
    double y[26];
    FILE *fp;
    fp = std::fopen("InitialCondition.csv", "r");
    for ( int idy = 0; idy < 26; idy++ ) {
        fscanf ( fp, "%lf", &y[idy] );
        VM.y[idy] = y[idy];
    }
    fclose(fp);

    //Apply the model parameters to the cell object
    VM.gRyR = input2[0];
    VM.av = input2[1];
    VM.vup = input2[2];
    VM.cup = input2[3];
    VM.gca = input2[4];
    VM.vth = input2[5];
    VM.gtos = input2[6];
    VM.gtof = input2[7];
    VM.gnaca = input2[8];
    VM.gks = input2[9];
    VM.gkr = input2[10];
    VM.gna = input2[11];
    VM.gkix = input2[12];
    VM.gnak = input2[13];
    VM.gleak = input2[14];

    //Define the Simulation Parameters
    double BCL = 400;
    double dt = 0.01;
    double stim_time= 2;
    double t = 0;
    double stim = 0;
    int n = 0;
    int n_total = 2000;

    //Define Variables for Describing the Previous Time Step
    double Cai_old = 0;
    double Vm_old = 0;
    //Define variables for calculating the extreme ionic concentration and  membrane potential values.
    double Cai_max = 0;
    double Cai_min = 100000;
    double CaSR_max = 0;
    double CaSR_min = 100000;
    double Nai_max = 0;
    double Nai_min = 100000;
    double Vm_max = -1000;
    double Vm_min = 1000;
    //Define Variables for Computing Thresholds
    double Cai_thresh50 = 0;
    double Vm_thresh = 0;
    //Define Variables for Computing Time Interval Bounds
    double t_Cai_max = 0;
    double t_Cai_min = 0;
    double t_Cai_start = 0;
    double D50_Start = 0;
    double D50_End = 0;
    double APD_Start = 0;
    double APD_End = 0;
    //Define Variables that state whether the cell meets different threshold requirements.
    bool inD50 = false;
    bool inAPD = false;

    //Run the preliminary part of the simulation.
    while(t<(BCL*n_total)) {
        //Stimulate the cell at the start of each BCL. Advance forwards in time by dt regardless of whether the cell was stimulated.
        stim = 0;
        if(fmod(t,BCL) <= stim_time){
            stim = 80;
        }
        VM.pace(stim);

        //If the cytosolic calcium level reached a new maximum: record the maximum value, the time of the maximum value, and make sure that you are not in the CaTD50 interval.
        if(VM.ci > Cai_max){
            Cai_max = VM.ci;
            inD50 = false;
            t_Cai_max = t;
        }

        //If the cytosolic calcium level reached a new minimum: record the minimum value and the time at which it is observed.
        if(VM.ci < Cai_min){
            Cai_min = VM.ci;
            t_Cai_min = t;
        }

        //Check whether the extreme value variables need to be updated for non-junctional SR calcium, cytosolic sodium, and the membrane potential.
        if(VM.cnsr > CaSR_max){
            CaSR_max = VM.cnsr;
        }
        if(VM.nai > Nai_max){
            Nai_max = VM.nai;
        }
        if(VM.v > Vm_max){
            Vm_max = VM.v;
        }
        if(VM.cnsr < CaSR_min){
            CaSR_min = VM.cnsr;
        }
        if(VM.nai < Nai_min){
            Nai_min = VM.nai;
        }
        if(VM.v < Vm_min){
            Vm_min = VM.v;
        }

        //Determine if you are entering or leaving the AP and record the necessary data.
        if((!inAPD) && (VM.v > Vm_thresh) && (n > 0)){
            APD_Start = t + dt/(VM.v - Vm_old)*(VM.v - Vm_thresh);
            inAPD = true;
        }
        if((inAPD) && (VM.v < Vm_thresh) && (n > 0)){
            APD_End = t + dt/(VM.v - Vm_old)*(VM.v - Vm_thresh);
            inAPD = false;
        }
        
        //Determine if you are entering or leaving the calcium transient decay interval.
        if((!inD50) && (t > t_Cai_max) && (VM.ci > Cai_thresh50) && (n>0)){
            D50_Start = t + dt/(VM.ci - Cai_old)*(VM.ci - Cai_max);
            inD50 = true;
        }
        if((inD50) && (t > t_Cai_max) && (VM.ci < Cai_thresh50) && (n>0)){
            D50_End = t + dt/(VM.ci - Cai_old)*(VM.ci - Cai_thresh50);
            inD50 = false;
        }

        //Update the variables for storing the previous values of the membrane potential and calcium transient.
        Vm_old = VM.v;
        Cai_old = VM.ci;

        //At the transition point to the new BCL, record the outputs for the present BCL. The first 21 beats are skipped to allow the code to learn how to compute these biomarkers prior to the beginning of the recording interval.
        if(abs(t - BCL*n) <= (dt/10)){
            if(n > 20){
                Validation_Parameters_n << 0 << "\t";
                Validation_Parameters_n << n << "\t";
                Validation_Parameters_n << (APD_End - APD_Start) << "\t";
                Validation_Parameters_n << Cai_max << "\t";
                Validation_Parameters_n << VM.ci << "\t";
                Validation_Parameters_n << CaSR_max << "\t";
                Validation_Parameters_n << CaSR_min << "\t";
                Validation_Parameters_n << Nai_max << "\t";
                Validation_Parameters_n << Nai_min << "\t";
                Validation_Parameters_n << (D50_End - D50_Start) << "\t";
                Validation_Parameters_n << (t_Cai_max - t_Cai_min) << "\n";
            }

            //Round the time variable to prevent excessive drift.
            t = n*BCL;
            //Update the beat number variable.
            n = n + 1;

            //Update the threshold variables
            Vm_thresh = Vm_min + (Vm_max - Vm_min)*0.1;
            Cai_thresh50 = Cai_min + (Cai_max - Cai_min)*0.5;

            //Reset the variables that are needed to characterize the next BCL
            Cai_max = 0;
            Cai_min = 100000;
            CaSR_max = 0;
            CaSR_min = 100000;
            Nai_max = 0;
            Nai_min = 100000;
            APD_Start = 0;
            APD_End = 0;
            D50_Start = 0;
            D50_End = 0;
        }

        //Extract the model variable traces for the last 10000ms with a 1ms sampling rate
        if((10000>((BCL*n_total) - (BCL*n))) && (fabs(fmod(t,1)-dt) <= (dt/10))){
            Validation_Parameters_t << BCL << "\t";
            Validation_Parameters_t << t ;
            int j = 0;
            while(j < 26){
                Validation_Parameters_t << "\t" << VM.y[j];
                j = j + 1;
            }
            Validation_Parameters_t << "\n";
        }
        //Update the time variable for the next time-step.
        t = t + dt;
    }
    //Set-Up a new simulation protocol that uses the previous cell object as a template.
    BCL = 600;
    n_total = 2;
    CCell VM_template;
    VM_template = VM;

    //Conduct this analysis on a new cell object for each integer BCL in the 200-600 ms range.
    while(BCL >= 200){
        VM = VM_template;
        t = 0;
        n = 0;

        //Run the main part of the simulation.
        while(t<(BCL*n_total)) {
            //Stimulate the cell at the start of each BCL. Advance forwards in time by dt regardless of whether the cell was stimulated.
            stim = 0;
            if(fmod(t,BCL) <= stim_time){
                stim = 80;
            }
            VM.pace(stim);

            //If the cytosolic calcium level reached a new maximum: record the maximum value, the time of the maximum value, and make sure that you are not in the CaTD50 interval.
            if(VM.ci > Cai_max){
                Cai_max = VM.ci;
                inD50 = false;
                t_Cai_max = t;
            }

            //If the cytosolic calcium level reached a new minimum: record the minimum value and the time at which it is observed.
            if(VM.ci < Cai_min){
                Cai_min = VM.ci;
                t_Cai_min = t;
            }

            //Check whether the extreme value variables need to be updated for non-junctional SR calcium, cytosolic sodium, and the membrane potential.
            if(VM.cnsr > CaSR_max){
                CaSR_max = VM.cnsr;
            }
            if(VM.nai > Nai_max){
                Nai_max = VM.nai;
            }
            if(VM.v > Vm_max){
                Vm_max = VM.v;
            }
            if(VM.cnsr < CaSR_min){
                CaSR_min = VM.cnsr;
            }
            if(VM.nai < Nai_min){
                Nai_min = VM.nai;
            }
            if(VM.v < Vm_min){
                Vm_min = VM.v;
            }

            //Determine if you are entering or leaving the AP and record the necessary data.
            if((!inAPD) && (VM.v > Vm_thresh) && (n > 0)){
                APD_Start = t + dt/(VM.v - Vm_old)*(VM.v - Vm_thresh);
                inAPD = true;
            }
            if((inAPD) && (VM.v < Vm_thresh) && (n > 0)){
                APD_End = t + dt/(VM.v - Vm_old)*(VM.v - Vm_thresh);
                inAPD = false;
            }
            
            //Determine if you are entering or leaving the calcium transient decay interval.
            if((!inD50) && (t > t_Cai_max) && (VM.ci > Cai_thresh50) && (n>0)){
                D50_Start = t + dt/(VM.ci - Cai_old)*(VM.ci - Cai_max);
                inD50 = true;
            }
            if((inD50) && (t > t_Cai_max) && (VM.ci < Cai_thresh50) && (n>0)){
                D50_End = t + dt/(VM.ci - Cai_old)*(VM.ci - Cai_thresh50);
                inD50 = false;
            }

            //Update the variables for storing the previous values of the membrane potential and calcium transient.
            Vm_old = VM.v;
            Cai_old = VM.ci;

            //At the transition point to the new BCL, record the outputs for the present BCL.
            if(abs(t - BCL*n) <= (dt/10)){
                if(n >= 0){
                    Validation_Parameters_n << BCL << "\t";
                    Validation_Parameters_n << n << "\t";
                    Validation_Parameters_n << (APD_End - APD_Start) << "\t";
                    Validation_Parameters_n << Cai_max << "\t";
                    Validation_Parameters_n << VM.ci << "\t";
                    Validation_Parameters_n << CaSR_max << "\t";
                    Validation_Parameters_n << CaSR_min << "\t";
                    Validation_Parameters_n << Nai_max << "\t";
                    Validation_Parameters_n << Nai_min << "\t";
                    Validation_Parameters_n << (D50_End - D50_Start) << "\t";
                    Validation_Parameters_n << (t_Cai_max - t_Cai_min) << "\n";
                }
                //Round the time variable to prevent excessive drift.
                t = n*BCL;
                //Update the beat number variable.
                n = n + 1;

                //Update the threshold variables
                Vm_thresh = Vm_min + (Vm_max - Vm_min)*0.1;
                Cai_thresh50 = Cai_min + (Cai_max - Cai_min)*0.5;

                //Reset the variables that are needed to characterize the next BCL
                Cai_max = 0;
                Cai_min = 100000;
                CaSR_max = 0;
                CaSR_min = 100000;
                Nai_max = 0;
                Nai_min = 100000;
                APD_Start = 0;
                APD_End = 0;
                D50_Start = 0;
                D50_End = 0;
            }


            //Extract the model variable traces for the last 10000ms with a 1ms sampling rate
            if(abs(round(t) - t) <= (dt/10)){
                Validation_Parameters_t << BCL << "\t";
                Validation_Parameters_t << t;
                int j = 0;
                while(j < 26){
                    Validation_Parameters_t  << "\t" << VM.y[j];
                    j = j + 1;
                }
                Validation_Parameters_t << "\n";
                t = round(t);
            }
            //Update the time variable for the next time-step.
            t = t + dt;
        }
        //Switch to the next BCL in the analysis.
        BCL = BCL - 1;
        std::cout << BCL << "\n";
    }
}
