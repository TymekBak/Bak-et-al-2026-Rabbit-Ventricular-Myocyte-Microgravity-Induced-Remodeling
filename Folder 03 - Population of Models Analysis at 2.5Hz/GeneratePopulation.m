%% Create text arrays for storing command line prompts
CommandLine1 = ["make"];
CommandLine2 = ["make"];

%% Define the mean and SD values for each parameter (vth is temporarily shifted from 0mV to 10mV to give a 1mV SD)
parameter_names = {"gRyR","u","vup","cup","gLTCC","vth","gtos","gtof","gnaca","gks","gkr","gna","gkix","gnak","gleak"};
RegressionParameter_Baseline = [2.58079, 11.3, 0.4, 0.5, 182, 10, 0.04, 0.11, 0.84, 0.1386, 0.0125, 12.0, 0.3, 1.5, 0.00002069];
RegressionParameter_SD = 0.1*ones(size(parameter_names));

%% Define the Population of Models by Applying Random Perturbations to the model parameters
rng(28) %This line of code ensures that the same random distribution is generated each time.
for i = 0:1000
    distribution = randn(1,15);
    if(i > 0)
        scaling = exp(distribution.*RegressionParameter_SD);
        NewPopulation = RegressionParameter_Baseline.*scaling;
        NewPopulation(6) = NewPopulation(6) - 10;
    else
        NewPopulation = RegressionParameter_Baseline;
        NewPopulation(6) = NewPopulation(6) - 10;
    end
    
    %Define file names for the input and output files.
    IndividualFileName = "Individuals/Baseline_P" + i + ".txt";
    TimeCourseFileName = "Outcomes_t/Baseline_P" + i + ".txt";
    ConvergenceFileName = "Outcomes_n/Baseline_P" + i + ".txt";

    %Create the file that describes a new individual and record that individual's command line prompt. 
    writematrix(NewPopulation', IndividualFileName);
    CommandLineSegement = "./MahajanRecorder " + IndividualFileName + " " + ConvergenceFileName + " " + TimeCourseFileName;
    CommandLine1 = [CommandLine1; CommandLineSegement];
end
% Store the command line prompts in a text file.
writematrix(CommandLine1, "ExecutionFile.txt");