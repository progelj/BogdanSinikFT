load("DryEEG8ChannelsIndexes.mat")
eeglab
XTest = {}
TTest = {}
srate = 500
% EEG = pop_loadbv('C:\Users\Bogdan\MATLAB Drive\EEG Recordings\Bogdan\', 'BogdanEC.vhdr'); 
% EEG = pop_resample( EEG, srate); 
% EEG = pop_reref( EEG, []);
% EEG = pop_eegfiltnew(EEG, 'locutoff',1,'hicutoff',50);
% 
% XTest{end+1,1} = EEG.data(ChanIndexes,:)
% Len = length(XTest{end,1})
% TTest{end+1,1} = categorical( zeros(1,Len), [0 1], {'eyesClosed', 'eyesOpen'});
% 
% EEG = pop_loadbv('C:\Users\Bogdan\MATLAB Drive\EEG Recordings\Bogdan\', 'BogdanEO.vhdr'); 
% EEG = pop_resample( EEG, srate); 
% EEG = pop_reref( EEG, []);
% EEG = pop_eegfiltnew(EEG, 'locutoff',1,'hicutoff',50);
% 
% XTest{end+1,1} = EEG.data(ChanIndexes,:)
% Len = length(XTest{end,1})
% TTest{end+1,1} = categorical( ones(1,Len), [0 1], {'eyesClosed', 'eyesOpen'});

EEG = pop_loadbv('C:\Users\Bogdan\MATLAB Drive\EEG Recordings\Kostas\', 'KostasEC.vhdr'); 
EEG = pop_resample( EEG, srate); 
EEG = pop_reref( EEG, []);
EEG = pop_eegfiltnew(EEG, 'locutoff',1,'hicutoff',50);

XTest{end+1,1} = EEG.data(ChanIndexes,:)
Len = length(XTest{end,1})
TTest{end+1,1} = categorical( zeros(1,Len), [0 1], {'eyesClosed', 'eyesOpen'});

EEG = pop_loadbv('C:\Users\Bogdan\MATLAB Drive\EEG Recordings\Kostas\', 'KostasEO.vhdr'); 
EEG = pop_resample( EEG, srate); 
EEG = pop_reref( EEG, []);
EEG = pop_eegfiltnew(EEG, 'locutoff',1,'hicutoff',50);

XTest{end+1,1} = EEG.data(ChanIndexes,:)
Len = length(XTest{end,1})
TTest{end+1,1} = categorical( ones(1,Len), [0 1], {'eyesClosed', 'eyesOpen'});

