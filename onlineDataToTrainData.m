clear all;
eeglab; % added to get the eeglab functions needed to load the data.
load('OnlineDataChannelsInfo.mat', 'onlineDataChannels');
load('ChanList.mat');
datapath='/Users/ljeb/Documents/Faculty/3rd year/Thesis/DATA FROM INTERNET';
numOfSubjects = 109;
[trainIndexes,valIndexes,testIndexes] = dividerand(numOfSubjects,0.9,0,0.1);
ElToConsider = {'Cz..','C3..','C4..'};
ChanIndexes = find(ismember(ChanList,ElToConsider))
%ChanIndexes = [11,9,13];

XTrain= cell(length(trainIndexes)*2,1);
YTrain= cell(length(trainIndexes)*2,1);
XTest= cell(length(testIndexes)*2,1);
YTest= cell(length(testIndexes)*2,1);
for j=trainIndexes
    i=1
    %value = "eyesOpen"
    fname=[datapath '/S' num2str(j,'%03d')  '/S' num2str(j,'%03d')  'R0' int2str(i) '.edf'];
    EEG = pop_biosig(fname);
    % rereferencing?
    XTrain{j*2-2+i,1} = EEG.data(ChanIndexes,:);     %% why so complex indexes
    %XTrain{j*2-2+i,1} = XTrain{j*2-2+i,1}(indices,:)
    Len=length(XTrain{j*2-2+i,1});
    YTrain{j*2-2+i,1} = categorical( ones(1,Len), [0 1], {'eyesClosed', 'eyesOpen'})

    i=2
    %value="eyesClosed"
    fname=[datapath '/S' num2str(j,'%03d')  '/S' num2str(j,'%03d')  'R0' int2str(i) '.edf'];
    EEG = pop_biosig(fname);
    % rereferencing?
    XTrain{j*2-2+i,1} = EEG.data(ChanIndexes,:);    %% why so complex indexes
    %XTrain{j*2-2+i,1} = XTrain{j*2-2+i,1}(indices,:);
    Len=length(XTrain{j*2-2+i,1});
    YTrain{j*2-2+i,1} = categorical( zeros(1,Len), [0 1], {'eyesClosed', 'eyesOpen'});
    
    %remove empty cells
    XTrain = XTrain(~cellfun('isempty',XTrain));
    YTrain = YTrain(~cellfun('isempty',YTrain));

end

for j = testIndexes
i=1
    %value = "eyesOpen"
    fname=[datapath '/S' num2str(j,'%03d')  '/S' num2str(j,'%03d')  'R0' int2str(i) '.edf'];
    EEG = pop_biosig(fname);
    % rereferencing?
    XTest{j*2-2+i,1} = EEG.data(ChanIndexes,:);     %% why so complex indexes
    %XTest{j*2-2+i,1} = XTest{j*2-2+i,1}(indices,:)
    Len=length(XTest{j*2-2+i,1});
    YTest{j*2-2+i,1} = categorical( ones(1,Len), [0 1], {'eyesClosed', 'eyesOpen'})

    i=2
    %value="eyesClosed"
    fname=[datapath '/S' num2str(j,'%03d')  '/S' num2str(j,'%03d')  'R0' int2str(i) '.edf'];
    EEG = pop_biosig(fname);
    % rereferencing?
    XTest{j*2-2+i,1} = EEG.data(ChanIndexes,:);    %% why so complex indexes
    %XTest{j*2-2+i,1} = XTest{j*2-2+i,1}(indices,:);
    Len=length(XTest{j*2-2+i,1});
    YTest{j*2-2+i,1} = categorical( zeros(1,Len), [0 1], {'eyesClosed', 'eyesOpen'});
    
    %remove empty cells
    XTest = XTest(~cellfun('isempty',XTest));
    YTest = YTest(~cellfun('isempty',YTest));
end

save("AllOnlineData.mat","XTrain","YTrain","XTest", "YTest");
