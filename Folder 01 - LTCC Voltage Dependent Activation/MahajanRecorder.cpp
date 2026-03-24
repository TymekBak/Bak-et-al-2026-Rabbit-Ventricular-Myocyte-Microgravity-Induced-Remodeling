#include "cell.h"
#include <iostream>
#include <fstream>
#include <cmath>

//Copy and paste these run commands into a terminal to run the simulation after executing the makefile.
//      Run Command: ./Mahajan_ICa_Characterization Individuals/Baseline.txt Results1/Baseline.txt Results2/Baseline.txt
//      Run Command: ./Mahajan_ICa_Characterization Individuals/Model6.txt Results1/Model6.txt Results2/Model6.txt

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

//Output File 1 (each row has the following format)
// VariableMembranePotential    PeakLTCC_Current    CorrespondingLTCC_Conductance

//Output File 2 (each row has the following format; the Model Parameters are seperated by "    ")
// Time    ModelParameters    LTCC_Current


int main(int argc, char *argv[]) {

    //Create the output files to enable the recording of simulation data.
    char *OutputFile = argv[2];
    std::ofstream output(OutputFile);
    char *OutputFile2 = argv[3];
    std::ofstream output2(OutputFile2);

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

    //Define the simulation protocol parameters.
    double PCL = 400;
    double dt = 0.01;

    //Run the following analysis for the target range of variable membrane potentials.
    double v_stim = -50;
    while(v_stim <= 60) {

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

        //Change the initial values of specific Mahajan Model parameters from the default.
        VM.cjsr = 0.00000000242;
        VM.cnsr = 0.00000000242;
        VM.ci = 0.00000000242;
        VM.cs = 0.00000000242;
        VM.nao = 136.0;
        VM.nai = 0.000000001;
        VM.cao = 1.8;
        VM.xir = 0; //This flux is set to zero because it needs an initial condition and the simulation assumes complete SR unloading is achieved.

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

        //Apply the voltage clamp protocol ten times.
        int i = 0;
        int n = 10;
        while(i <= n){
            double t = 0;
            //For the first 200ms of the simulation, clamp the membrane potential at -40mV.
            //The AP clamp is reapplied every 0.01ms and data is recorded with a 1ms sampling interval. 
            while(t<(200)) {
                VM.v = -40;
                VM.pace(0);
                if(abs(t - round(t)) < (dt/10)){
                    int j = 0;
                    output2 << t << "\t";
                    while(j < 26){
                        output2 << VM.y[j] << "\t";
                        j = j + 1;
                    }
                    output2 << VM.ica << "\n";
                    t = round(t);
                }
                t = t + dt;            
            }
            //For the next 400ms of the simulation, clamp the membrane potential at the variable membrane potential.
            //The AP clamp is reapplied every 0.01ms and data is recorded with a 1ms sampling interval.
            //Identify the maximum LTCC current in this interval and record it along with the membrane potential and driving force that produced it.
            double ICa_max = 0;
            double Vm_max = 0;
            double DF_max = 0;
            while(t<(600)) {
                VM.v = v_stim;
                VM.pace(0);
                if(abs(VM.ica) > abs(ICa_max)){
                    ICa_max = VM.ica;
                    Vm_max = VM.v;
                    DF_max = VM.comp_rxa(VM.cs/1000);
                }
                if(abs(t - round(t)) < (dt/10)){
                    int j = 0;
                    output2 << t << "\t";
                    while(j < 26){
                        output2 << VM.y[j] << "\t";
                        j = j + 1;
                    }
                    output2 << VM.ica << "\n";
                    t = round(t);
                }
                t = t + dt;
            }
            //For the next 200ms of the simulation, clamp the membrane potential at -40mV.
            //The AP clamp is reapplied every 0.01ms and data is recorded with a 1ms sampling interval.
            while(t<(800)) {
                VM.v = -40;
                VM.pace(0);
                if(abs(t - round(t)) < (dt/10)){
                    int j = 0;
                    output2 << t << "\t";
                    while(j < 26){
                        output2 << VM.y[j] << "\t";
                        j = j + 1;
                    }
                    output2 << VM.ica << "\n";
                    t = round(t);
                }
                t = t + dt;
            }
            //For the remainder of the 10000ms AP clamp cycle, clamp the membrane potential at -80mV.
            //The AP clamp is reapplied every 0.01ms and data is recorded with a 1ms sampling interval.
            while(t<(10000)) {
                VM.v = -80;
                VM.pace(0);
                if(abs(t - round(t)) < (dt/10)){
                    int j = 0;
                    output2 << t << "\t";
                    while(j < 26){
                        output2 << VM.y[j] << "\t";
                        j = j + 1;
                    }
                    output2 << VM.ica << "\n";
                    t = round(t);
                }
                t = t + dt;       
            }
            //If this is the tenth AP clamp cycle, record the peak current elicited by the variable voltage step and the conductance for this current.
            if(i == n){
                output << Vm_max << "\t" << ICa_max << "\t" << (ICa_max/DF_max) << "\n";
            }
            i = i + 1;
        }
        //Change the variable voltage step for the next simulation.
        v_stim = v_stim + 1;
        std::cout << v_stim << "\n";
    }
}