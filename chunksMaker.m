
srate = 256;
TrainInputs = {};
TrainOutputs = {};
chunkSize = 4*srate;
for i = 1:length(XTrain)
    nChunks=floor(length(XTrain{i})/chunkSize);
    for j = 1:nChunks
        TrainInputs{end+1,1} = XTrain{i}(:,((j-1)*chunkSize+1):(j*chunkSize));
        TrainOutputs{end+1,1} = YTrain{i}(:,((j-1)*chunkSize+1):(j*chunkSize));
    end
end

TestInputs = {};
TestOutputs = {};
for i = 1:length(XTest)
    nChunks=floor(length(XTest{i})/chunkSize);
    for j = 1:nChunks
        TestInputs{end+1,1} = XTest{i}(:,((j-1)*chunkSize+1):(j*chunkSize));
        TestOutputs{end+1,1} = YTest{i}(:,((j-1)*chunkSize+1):(j*chunkSize));
    end
end