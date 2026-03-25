%% Identify every individual that was analyzed
Output = [];
directory = dir(fullfile("Outcomes_n\","*.txt"));
for n = 1:length(directory)
    %% Extract the necessary data for the individual of interest.
    file = directory(n).name;
    Baseline = readmatrix("Outcomes_n/" + file);
    
    %% Plot the bifurcation diagrams for this individual
    APD1 = zeros(2,41);
    CaT1 = zeros(2,41);

    i = 1;
    for BCL = max(Baseline(:,1)):-1:min(Baseline(:,1))
        APD = Baseline(:, 3); APD = APD(Baseline(:,1) == BCL); APD1(:,i) = APD((end-1):end);
        CaT = Baseline(:, 4) - Baseline(:, 5); CaT = CaT(Baseline(:,1) == BCL); CaT1(:,i) = CaT((end-1):end);
        i = i + 1;
    end
    BCL = max(Baseline(:,1)):-1:min(Baseline(:,1)); 
     
    APD = figure(1);
    clf
    scatter(BCL,APD1, "blue","filled")
    ylabel("APD_{90} (ms)")
    xlabel("BCL (ms)")
    title(file)

    CaT = figure(2);
    clf
    scatter(BCL,CaT1, "blue","filled")
    ylabel("{\Delta}[Ca^{2+}]_i ({\mu}M)")
    xlabel("BCL (ms)")
    title(file)
    
    Both = figure(3);
    clf
    subplot(1,2,1)
    scatter(BCL,APD1, "blue","filled")
    ylabel("APD_{90} (ms)")
    xlabel("BCL (ms)")
    title(file)

    subplot(1,2,2)
    scatter(BCL,CaT1, "blue","filled")
    ylabel("{\Delta}[Ca^{2+}]_i ({\mu}M)")
    xlabel("BCL (ms)")
    title(file)

    %% Save the bifurcation diagrams for this individual.
    saveas(CaT,("Bifurcation Diagrams/CaT " + file(10:13) + ".png"))
    saveas(APD,("Bifurcation Diagrams/APD " + file(10:13) + ".png"))
    saveas(Both,("Bifurcation Diagrams/Both " + file(10:13) + ".png"))
    
    Alternans1 = abs(APD1(1,:) - APD1(2,:));
    Alternans2 = abs(CaT1(1,:) - CaT1(2,:));
    Threshold1 = 0;
    Threshold2 = 0;
    
    for i = 1:length(BCL)
        if(Alternans1(i) >= 5)
            Threshold1 = BCL(i);
            break
        end
    end
    for i = 1:length(BCL)
        if(Alternans2(i) >= 0.01)
            Threshold2 = BCL(i);
            break
        end
    end
    
    OutputLine = file + " Search Range" + num2str(max(BCL)) + "-" + num2str(min(BCL)) + " APD Threshold: " + num2str(Threshold1) + " CaT Threshold: " + num2str(Threshold2);

    Output = [Output; OutputLine];

    %% Extract the time course data and use it describe the model behavior before and after the onset of action potential and Ca^{2+} Alternans.
    Baseline = readmatrix("Outcomes_t/" + file);
    t = Baseline(:,2);
    Vm = Baseline(:,11);
    CaT = Baseline(:,14);

    I1 = (Baseline(:,1) == Threshold1);
    I2 = (Baseline(:,1) == (Threshold1+1));
    I3 = (Baseline(:,1) == Threshold2);
    I4 = (Baseline(:,1) == (Threshold1+2));

    timecourses = figure(8);
    clf
    subplot(2,4,1)
    plot(Vm(I1))
    xlabel("Time (ms)")
    ylabel("Vm (mV)")
    title("After AP Alternans: " + file)
    xlim([length(t(I1))-1200,length(t(I1))])

    subplot(2,4,2)
    plot(Vm(I2))
    xlabel("Time (ms)")
    ylabel("Vm (mV)")
    title("Before AP Alternans: " + file)
    xlim([length(t(I2))-1200,length(t(I2))])

    subplot(2,4,3)
    plot(Vm(I3))
    xlabel("Time (ms)")
    ylabel("Vm (mV)")
    title("After Ca^{2+} Alternans: " + file)
    xlim([length(t(I3))-1200,length(t(I3))])

    subplot(2,4,4)
    plot(Vm(I4))
    xlabel("Time (ms)")
    ylabel("Vm (mV)")
    title("Before Ca^{2+} Alternans: " + file)
    xlim([length(t(I4))-1200,length(t(I4))])
    
    subplot(2,4,5)
    plot(CaT(I1))
    xlabel("Time (ms)")
    ylabel("[Ca^{2+}]_i ({\mu}M)")
    title("After AP Alternans: " + file)
    xlim([length(t(I1))-1200,length(t(I1))])

    subplot(2,4,6)
    plot(CaT(I2))
    xlabel("Time (ms)")
    ylabel("[Ca^{2+}]_i ({\mu}M)")
    title("Before AP Alternans: " + file)
    xlim([length(t(I2))-1200,length(t(I2))])

    subplot(2,4,7)
    plot(CaT(I3))
    xlabel("Time (ms)")
    ylabel("[Ca^{2+}]_i ({\mu}M)")
    title("After Ca^{2+} Alternans: " + file)
    xlim([length(t(I3))-1200,length(t(I3))])

    subplot(2,4,8)
    plot(CaT(I4))
    xlabel("Time (ms)")
    ylabel("[Ca^{2+}]_i ({\mu}M)")
    title("Before Ca^{2+} Alternans: " + file)
    xlim([length(t(I4))-1200,length(t(I4))])

    %% Save the new figures.
    saveas(timecourses,("TimeCourse/TimeCourse " + file(10:13) + ".png"))
end
%% Save the alternans threshold data.
writematrix(Output,"AlternansThresholdSummary.txt")