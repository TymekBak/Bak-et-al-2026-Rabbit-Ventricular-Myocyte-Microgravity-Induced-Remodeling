%% Generate a list of files in the folder with AP recordings.
files = struct2table(dir("Baseline APs/*.txt"));
files = files.name;

for j = 1:length(files)
    %% Extract every file and compute the APD threshold
    if(startsWith(files(j),"._"))
        continue
    end
    A = readmatrix("Baseline APs/" + convertCharsToStrings(files(j)));
    threshold = (max(A) - min(A))*0.1 + min(A);
    
    %% Align the AP recording so that the depolarization is at the start of the file.
    for i = 1:length(A)
        AP_index = A > threshold;
        if((AP_index(1) == 0) || (AP_index(end) == 1))
            A_new = zeros(size(A));
            A_new(2:end) = A(1:(end-1));
            A_new(1) = A(end);
            A = A_new;
        else
            break
        end
    end
    
    %% Shift the recording by 10ms to create a repolarized time period before the action potential itself
    for i = 1:10
        A_new = zeros(size(A));
        A_new(2:end) = A(1:(end-1));
        A_new(1) = A(end);
        A = A_new;
    end
    %% Write the results in a new text file.
    writematrix(A,"Baseline AP Correction/" + convertCharsToStrings(files(j)))
end
