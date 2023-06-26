
for i= 1 : 1
    YTrainEyesClosed = YTrain{i}(find(YTrain{i} == "eyesClosed"))
    YTrainEyesOpen = YTrain{i}(find(YTrain{i} == "eyesOpen"))
    XTrainEyesOpen = XTrain{i}(:,find(YTrain{i} == "eyesOpen"))
    XTrainEyesClosed = XTrain{i}(:,find(YTrain{i} == "eyesClosed"))
    XTrainAppended = horzcat(XTrainEyesClosed,XTrainEyesOpen)
    YTrainAppended = horzcat(YTrainEyesClosed,YTrainEyesOpen)
    
    XTrain{i} = XTrainAppended
    YTrain{i} = YTrainAppended
end