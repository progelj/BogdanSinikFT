clear all;
eeglab; % added to get the eeglab functions needed to load the data.
load('OnlineDataChannelsInfo.mat', 'onlineDataChannels');
load('ChanList.mat');
%datapath='/Users/ljeb/Documents/Faculty/3rd year/Thesis/DATA FROM INTERNET';
datapath='/media/peter/FCEB-1564/EEG-files';
numOfSubjects = 109;
[trainIndexes,valIndexes,testIndexes] = dividerand(numOfSubjects,0.9,0,0.1);
ElToConsider = {'Cz..','C3..','C4..'};
ChanIndexes = find(ismember(ChanList,ElToConsider))     % PR: check if it preserves the channel order given in "ElToConsider"
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

    % PR: add rereferencing to average
    % PR: assure the same sampling frequency for all imported files (from
    % all sources - MotorImageryDataset has 160! ).  
    XTrain{j*2-2+i,1} = EEG.data(ChanIndexes,:);     %% why so complex indexes
    XTrain{j*2-2+i,1} = XTrain{j*2-2+i,1}(:,any(XTrain{j*2-2+i,1},1)); %remove zero columns % PR: will if work if there is 0 in the correct part of the signal?
    Len=length(XTrain{j*2-2+i,1});
    YTrain{j*2-2+i,1} = categorical( ones(1,Len), [0 1], {'eyesClosed', 'eyesOpen'})
    
    i=2
    %value="eyesClosed"
    fname=[datapath '/S' num2str(j,'%03d')  '/S' num2str(j,'%03d')  'R0' int2str(i) '.edf'];
    EEG = pop_biosig(fname);
    % rereferencing?
    XTrain{j*2-2+i,1} = EEG.data(ChanIndexes,:);    %% why so complex indexes
    XTrain{j*2-2+i,1} = XTrain{j*2-2+i,1}(:,any(XTrain{j*2-2+i,1},1)); %remove zero columns
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
    XTest{j*2-2+i,1} = XTest{j*2-2+i,1}(:,any(XTest{j*2-2+i,1},1));
    Len=length(XTest{j*2-2+i,1});
    YTest{j*2-2+i,1} = categorical( ones(1,Len), [0 1], {'eyesClosed', 'eyesOpen'})

    i=2
    %value="eyesClosed"
    fname=[datapath '/S' num2str(j,'%03d')  '/S' num2str(j,'%03d')  'R0' int2str(i) '.edf'];
    EEG = pop_biosig(fname);
    % rereferencing?
    XTest{j*2-2+i,1} = EEG.data(ChanIndexes,:);    %% why so complex indexes
    XTest{j*2-2+i,1} = XTest{j*2-2+i,1}(:,any(XTest{j*2-2+i,1},1));
    Len=length(XTest{j*2-2+i,1});
    YTest{j*2-2+i,1} = categorical( zeros(1,Len), [0 1], {'eyesClosed', 'eyesOpen'});
    
    %remove empty cells
    XTest = XTest(~cellfun('isempty',XTest));
    YTest = YTest(~cellfun('isempty',YTest));
end

save("AllOnlineDataWithoutZeros.mat","XTrain","YTrain","XTest", "YTest");
