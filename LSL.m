% Import the LSL library
import lsl.*;
load('DryEEG8ChannelsIndexes.mat')
load("net.mat")
% Resolve EEG stream
disp('Resolving an EEG stream...');
lib = lsl_loadlib();

result = {};
while isempty(result)
    result = lsl_resolve_byprop(lib, 'type', 'EEG');
end
disp('EEG stream resolved.');

% Create an inlet to receive the data
disp('Creating an EEG stream inlet...');
inlet = lsl_inlet(result{1});
disp('EEG stream inlet created.');

% Assuming you have a trained classification model called 'model'

% Define the EEG channels of interest
channelsToConsider = {'C3','C4','Fp1','Fp2','P7','P8','O1','O2'};

% Define the desired sampling rate
samplingRate = 500;

% Calculate the number of samples in each chunk based on the desired sampling rate
chunkSize = ceil(samplingRate);  % Assuming you want 1 second of data in each chunk
EC_count = 0;
EO_count = 0;
chunk = [];
while true
    % Retrieve a chunk of EEG data
    chunk = [chunk,inlet.pull_chunk()];
    % Check if any data is received
    
    if (length(chunk) >= 500 )

        % Extract the channels of interest from the chunk
        eegData = chunk(ChanIndexes,:);
       
        % Preprocess the EEG data
        %preprocessedData = preprocess(eegData);
        average_reference = mean(eegData, 1);
        rereferenced_data  = eegData - average_reference;
        % 
        % Define filter parameters
        order = 4;  % Filter order
        lowpass_cutoff = 50;  % Low-pass cutoff frequency in Hz
        highpass_cutoff = 1;  % High-pass cutoff frequency in Hz

        % Design the low-pass filter
        [b_low, a_low] = butter(order, lowpass_cutoff / (samplingRate/2), 'low');

        % Design the high-pass filter
        [b_high, a_high] = butter(order, highpass_cutoff / (samplingRate/2), 'high');

        % Apply the filters
        filtered_data = filtfilt(b_low, a_low, transpose(rereferenced_data));
        filtered_data = filtfilt(b_high, a_high, filtered_data);
        % Perform classification using the model
        predictedLabels = classify(net,(filtered_data)');
        %disp(predictedLabels);
        majorityCategory = mode(cat(1, predictedLabels));
        disp(majorityCategory);
        chunk = [];

    end
    
    % Add a delay or use an event-based approach to control the data acquisition rate
end
