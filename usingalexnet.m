%Training and Validation using AlexNet
DataSetPath='D:\College Material\Electronics\MATLAB\ECGSignalClassification\ecgdataset\';

%Reading Images from ImageDataSet Folder
images=imageDatastore(DataSetPath,'IncludeSubfolders',true,'LabelSource','foldernames');

%Distributing Images in the set of Training and Testing
numTrainFiles=250;
[TrainImages,TestImages]=splitEachLabel(images,numTrainFiles,'randomize');

net=alexnet;  %Importing Pretrained AlexNet
layersTransfer = net.Layers(1:end-3); %Preserving all layers except last three
numclasses=3;  %Number of output classes : 'ARR','CHF','NSR'

%Defining layers of AlexNet
layers=[layersTransfer
    fullyConnectedLayer(numclasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];

%Training options
options = trainingOptions('sgdm',...
    'MiniBatchSize',20,...
    'MaxEpochs',8,...
    'InitialLearnRate',1e-4,...
    'Shuffle','every-epoch',...
    'ValidationData',TestImages,...
    'ValidationFrequency',10,...
    'Verbose',false,...
    'Plots','training-progress');

%Training AlexNet
netTransfer = trainNetwork(TrainImages,layers,options);

%Classifying Images
YPred=classify(netTransfer,TestImages);
YValidation=TestImages.Labels;
accuracy=sum(YPred==YValidation)/numel(YValidation);

%Plotting Confusion Matrix
plotconfusion(YValidation,YPred);