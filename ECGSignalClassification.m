%Program to create CWT image database from ECG signals
load('ECGData.mat');    %loading ECG database
data=ECGData.Data;      %Getting Database
labels=ECGData.Labels; %Getting Labels
ARR=data(1:30,:); %Taken first 30 Recordings
CHF=data(97:126,:);
NSR=data(127:156,:);
signallength=500;

%Defining filters for cwt with amor wavelet and 12 filters per octave
fb=cwtfilterbank('SignalLength',signallength,'Wavelet','amor','VoicesPerOctave',12);
mkdir('ecgdataset'); %Main folder
mkdir('ecgdataset\arr'); %Sub folder
mkdir('ecgdataset\chf'); 
mkdir('ecgdataset\nsr');

ecgtype={'ARR','CHF','NSR'};

ecg2cwtscg(ARR,fb,ecgtype{1});
ecg2cwtscg(CHF,fb,ecgtype{2});
ecg2cwtscg(NSR,fb,ecgtype{3});
