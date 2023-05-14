load('OnlineDataChannelsInfo.mat', 'onlineDataChannels')
XTrain= cell(109*2,1)
YTrain= cell(109*2,1)
for j=1 : 9
    EEG = pop_biosig(strcat('/Users/ljeb/Documents/Faculty/3rd year/Thesis/DATA FROM INTERNET/S00',int2str(j),'/S00',int2str(j),'R0',int2str(i),'.edf'));
    indices = onlineDataChannels{1,2}
    
    i=1
    value = "eyesOpen"
    XTrain{j*2-2+i,1} = EEG.data
    XTrain{j*2-2+i,1} = XTrain{j*2-2+i,1}(indices,:)
    YTrain{j*2-2+i,1} = categorical({})
    YTrain{j*2-2+i,1} = repmat(categorical(value),1,length(XTrain{j*2-2+i,1}))
    YTrain{j*2-2+i,1} = setcats(YTrain{j*2-2+i,1},{'eyesClosed','eyesOpen'})
    
    i=2
    value="eyesClosed"
    XTrain{j*2-2+i,1} = EEG.data
    XTrain{j*2-2+i,1} = XTrain{j*2-2+i,1}(indices,:)
    YTrain{j*2-2+i,1} = categorical({})
    YTrain{j*2-2+i,1} = repmat(categorical(value),1,length(XTrain{j*2-2+i,1}))
    YTrain{j*2-2+i,1} = setcats(YTrain{j*2-2+i,1},{'eyesClosed','eyesOpen'})

end
for j = 10 : 99
    EEG = pop_biosig(strcat('/Users/ljeb/Documents/Faculty/3rd year/Thesis/DATA FROM INTERNET/S0',int2str(j),'/S0',int2str(j),'R0',int2str(i),'.edf'));
    indices = onlineDataChannels{1,2}
    
    i=1
    value = "eyesOpen"
    XTrain{j*2-2+i,1} = EEG.data
    XTrain{j*2-2+i,1} = XTrain{j*2-2+i,1}(indices,:)
    YTrain{j*2-2+i,1} = categorical({})
    YTrain{j*2-2+i,1} = repmat(categorical(value),1,length(XTrain{j*2-2+i,1}))
    YTrain{j*2-2+i,1} = setcats(YTrain{j*2-2+i,1},{'eyesClosed','eyesOpen'})
    
    i=2
    value="eyesClosed"
    XTrain{j*2-2+i,1} = EEG.data
    XTrain{j*2-2+i,1} = XTrain{j*2-2+i,1}(indices,:)
    YTrain{j*2-2+i,1} = categorical({})
    YTrain{j*2-2+i,1} = repmat(categorical(value),1,length(XTrain{j*2-2+i,1}))
    YTrain{j*2-2+i,1} = setcats(YTrain{j*2-2+i,1},{'eyesClosed','eyesOpen'})
end

for j=100 : 109
    EEG = pop_biosig(strcat('/Users/ljeb/Documents/Faculty/3rd year/Thesis/DATA FROM INTERNET/S',int2str(j),'/S',int2str(j),'R0',int2str(i),'.edf'));
    indices = onlineDataChannels{1,2}
    
    i=1
    value = "eyesOpen"
    XTrain{j*2-2+i,1} = EEG.data
    XTrain{j*2-2+i,1} = XTrain{j*2-2+i,1}(indices,:)
    YTrain{j*2-2+i,1} = categorical({})
    YTrain{j*2-2+i,1} = repmat(categorical(value),1,length(XTrain{j*2-2+i,1}))
    YTrain{j*2-2+i,1} = setcats(YTrain{j*2-2+i,1},{'eyesClosed','eyesOpen'})
    
    i=2
    value="eyesClosed"
    XTrain{j*2-2+i,1} = EEG.data
    XTrain{j*2-2+i,1} = XTrain{j*2-2+i,1}(indices,:)
    YTrain{j*2-2+i,1} = categorical({})
    YTrain{j*2-2+i,1} = repmat(categorical(value),1,length(XTrain{j*2-2+i,1}))
    YTrain{j*2-2+i,1} = setcats(YTrain{j*2-2+i,1},{'eyesClosed','eyesOpen'})
end
save("AllOnlineData.mat","XTrain","YTrain")
