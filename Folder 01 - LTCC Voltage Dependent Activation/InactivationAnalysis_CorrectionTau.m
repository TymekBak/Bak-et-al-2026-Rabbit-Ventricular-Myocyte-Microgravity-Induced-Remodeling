%% Read the simulation output into MATLAB variables.
% Baseline = readmatrix("Results2/Baseline.txt");
% Manuscript = readmatrix("Results2/Model6.txt");

%% Store the membrane potential and LTCC current traces in smaller variables.
Vm1 = zeros(110000,111); 
Vm2 = zeros(110000,111);
ILTCC1 = zeros(110000,111);
ILTCC2 = zeros(110000,111);

%% Select the last iteration with a 0mV membrane potential clamp
Vm1(:) = Baseline(:,10); Vm1 = Vm1(90001:100000,51);
Vm2(:) = Manuscript(:,10); Vm2 = Vm2(90001:100000,51);
ILTCC1(:) = Baseline(:,28); ILTCC1 = ILTCC1(90001:100000,51);
ILTCC2(:) = Manuscript(:,28); ILTCC2 = ILTCC2(90001:100000,51);

%% Select the time segment at the variable voltage step
ILTCC1_segment = ILTCC1(round(Vm1) == 0);
ILTCC2_segment = ILTCC2(round(Vm2) == 0);

ILTCC1_threshold = (max(ILTCC1_segment) - min(ILTCC1_segment))*(1-exp(-1)) + min(ILTCC1_segment);
ILTCC2_threshold = (max(ILTCC2_segment) - min(ILTCC2_segment))*(1-exp(-1)) + min(ILTCC2_segment);

t0_5_ILTCC1 = 0; thresh1 = false;
t0_5_ILTCC2 = 0; thresh2 = false;
start1 = 0; start2 = 0; end1 = 0; end2 = 0;

%% Compute the time to 50% 
for i = 1:400
    if(~thresh1 && (abs(ILTCC1_segment(i)) == max(abs(ILTCC1_segment))))
        t0_5_ILTCC1 = i;
        thresh1 = ~thresh1;
    end

    if(~thresh2 && (abs(ILTCC2_segment(i)) == max(abs(ILTCC2_segment))))
        t0_5_ILTCC2 = i;
        thresh2 = ~thresh2;
    end

    if(thresh1 && (abs(ILTCC1_segment(i)) < abs(ILTCC1_threshold)))
        t0_5_ILTCC1 = -t0_5_ILTCC1 + ((i - 1) + (ILTCC1_threshold - ILTCC1_segment(i-1))/(ILTCC1_segment(i) - ILTCC1_segment(i-1)));
        thresh1 = ~thresh1;
    end

    if(thresh2 && (abs(ILTCC2_segment(i)) < abs(ILTCC2_threshold)))
        t0_5_ILTCC2 = -t0_5_ILTCC2 + ((i - 1) + (ILTCC2_threshold - ILTCC2_segment(i-1))/(ILTCC2_segment(i) - ILTCC2_segment(i-1)));
        thresh2 = ~thresh2;
    end
end

figure(1)
clf
plot(ILTCC1)
hold on
%plot(ILTCC1_segment)
yline(ILTCC1_threshold)

figure(2)
clf
plot(ILTCC2)
hold on
%plot(ILTCC2_segment)
yline(ILTCC2_threshold)

figure(3)
clf
plot((ILTCC1_segment - min(ILTCC1_segment))/(max(ILTCC1_segment) - min(ILTCC1_segment)))
hold on
plot((ILTCC2_segment - min(ILTCC2_segment))/(max(ILTCC2_segment) - min(ILTCC2_segment)))
xlabel("Time (ms)")
ylabel("I_{LTCC} (A/F)")
title("Vm = 0mV")
legend("Baseline","Microgravity")

(t0_5_ILTCC2 - t0_5_ILTCC1)/t0_5_ILTCC1*100