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
chunk = [];
chunkSize = 500;
filterChunkLength = 1000;
while true
    % Retrieve a chunk of EEG data
    chunk = [chunk,inlet.pull_chunk()];
    % Check if any data is received
    
    if (length(chunk) >= filterChunkLength )
        bpFilt = designfilt('bandpassiir','FilterOrder',2, ...
         'HalfPowerFrequency1',1,'HalfPowerFrequency2',50, ...
         'SampleRate',srate);
        filtered_data = (filter(bpFilt,(chunk)'))';
        % Extract the channels of interest from the chunk
        eegData = filtered_data(ChanIndexes,length(chunk)-chunkSize:length(chunk));
        % Perform classification using the model
        predictedLabels = classify(net,eegData);
        predict(net,eegData)
        %disp(predictedLabels);
        majorityCategory = mode(cat(1, predictedLabels));
        disp(majorityCategory);
        chunk = chunk(:,length(chunk)-chunkSize:length(chunk));

    end
    
    % Add a delay or use an event-based approach to control the data acquisition rate
end