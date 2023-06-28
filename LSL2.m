import lsl.*;
load('DryEEG8ChannelsIndexes.mat')
load("net.mat")

% Define the EEG channels of interest
channelsToConsider = {'C3','C4','Fp1','Fp2','P7','P8','O1','O2'};
numChannels = numel(channelsToConsider);

% Define the desired sampling rate
samplingRate = 500;

% Calculate the number of samples in each chunk based on the desired sampling rate
chunkDuration = 4;  % Chunk duration in seconds
chunkSize = ceil(samplingRate * chunkDuration);
YPred = [];

% Initialize a buffer to accumulate samples
buffer = [];

i = 1;
while true
    % Retrieve available samples from the inlet
    samples = inlet.pull_sample();
    
    % Store each sample as a separate column in the buffer
    buffer(:, i) = transpose(samples);
    
    % Increment the column index
    i = i + 1;
    
    % Check if the buffer is full
    if i > chunkSize
        % Extract the chunk from the buffer
        chunk = buffer;
        
        % Reset the column index
        i = 1;
        
        % Extract the channels of interest from the chunk
        eegData = chunk(ChanIndexes,:);
        
        % Preprocess the EEG data
        % preprocessedData = preprocess(eegData);
        
        % Perform classification using the model
        predictedLabels = classify(net, eegData);
        YPred = [YPred, predictedLabels];
        
        % Do something with the predicted labels
        disp(predictedLabels);
        buffer = [];
        YPred = [];
    end
    
    % Add a delay or use an event-based approach to control the data acquisition rate
end
