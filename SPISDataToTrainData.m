clear all;
path = "/Users/ljeb/Downloads/Combined";
ecExt = "_restingPre_EC.mat";
eoExt = "_restingPre_EO.mat";

channelList = {'Fp1';'AF7';'AF3';'F1';'F3';'F5';'F7';'FT7';'FC5';'FC3';'FC1';'C1';'C3';'C5';'T7';'TP7';'CP5';'CP3';'CP1';'P1';'P3';'P5';'P7';'P9';'PO7';'PO3';'O1';'Iz';'Oz';'POz';'Pz';'CPz';'Fpz'; 'Fp2';'AF8';'AF4';'Afz';'Fz';'F2';'F4';'F6';'F8';'FT8';'FC6';'FC4';'FC2';'FCz';'Cz';'C2';'C4';'C6';'T8';'TP8';'CP6';'CP4';'CP2';'P2';'P4';'P6';'P8';'P10';'PO8';'PO4';'O2'};
elToConsider = {'Cz';'C3';'C4'};
elPositions = find(ismember(channelList, elToConsider));
XTrain = cell(10,1);
XTest = cell(1,1);
for i = 2 : 10
    midPart = "/S0";
    if(i>9) 
        midPart = "/S";
    end
    load(path+midPart+int2str(i)+ecExt);
    XTrain{i*2-3,:} = dataRest(elPositions,:);
    Len=length(XTrain{i*2-3,1});
    YTrain{i*2-3,:} = categorical( zeros(1,Len), [0 1], {'eyesClosed', 'eyesOpen'});

    load(path+midPart+int2str(i)+eoExt);
    XTrain{i*2-2,:} = dataRest(elPositions,:);
    Len=length(XTrain{i*2-3,1});
    YTrain{i*2-2,:} = categorical( ones(1,Len), [0 1], {'eyesClosed', 'eyesOpen'});

end

load(path + "/S11_restingPre_EC.mat")
Len=length(dataRest);
XTest{1,1} = dataRest(elPositions,:);
YTest{1,1} = categorical( zeros(1,Len), [0 1], {'eyesClosed', 'eyesOpen'});
load(path + "/S11_restingPre_EO.mat")
Len=length(dataRest);
XTest{1,1} = cat(2, XTest{1,1}, dataRest(elPositions,:));
YTest{1,1} = cat(2, YTest{1,1}, categorical( ones(1,Len), [0 1], {'eyesClosed', 'eyesOpen'}));
save("AllSPISDataTogetherTest.mat","XTrain","YTrain","XTest", "YTest");