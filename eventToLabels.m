labels = categorical({})
d = 1
data = ALLEEG(4).data
%events = ALLEEG(4).event
%data = data(1:end-2,:)
%events(strcmp({events.type}, "0")) = []

for i=1:length(events)
    labels(d:events(i).latency) = categorical(string(getLabel(events(i).type)))
    d = events(i).latency
end
labels(end:length(data)) = categorical(string(getLabel(events(end-1).type)))

%XTrain{1} = data
YTrain{1} = labels
%save("Kostas70s10sIntervalTrainAuto.mat","XTrain","YTrain")
function output = getLabel (type)
    if type == '2'
        output = 'eyesClosed'
    else
        output = 'eyesOpen'
    end
end