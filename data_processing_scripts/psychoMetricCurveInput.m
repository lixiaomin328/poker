function [rtPerPersonPerCardp1,rtPerPersonPerCardp2] = psychoMetricCurveInput()
isAmazon = 1;
if isAmazon ==1
    dataFolder = 'mTurkDataMat/';
    load('subIdAmazon.mat')
else
dataFolder = 'dataMat/';
end
rtPerPersonPerCardp1 = [];
rtPerPersonPerCardp2 = [];
dataFile = dir([dataFolder,'*.mat']);
for i = 1:length(dataFile)
    if isAmazon ==1
        subId = amazonIds{i};
        fileName = [dataFolder,'participant_',subId,'.mat'];
    else
        subId = i+3;
        fileName = [dataFolder,'participant_',num2str(subId),'.mat'];
    end
    fileName = [dataFolder,'participant_',num2str(subId),'.mat'];
    if ~exist(fileName)
        continue;
    end
    [proportionsBetP1,proportionsBetP2,p1RtperRate,p2RtperRate] = perCardPersonBettingRate(subId,dataFolder);
    rtPerPersonPerCardp1 = [rtPerPersonPerCardp1;proportionsBetP1',p1RtperRate'];
    rtPerPersonPerCardp2 = [rtPerPersonPerCardp2;proportionsBetP2',p2RtperRate'];
end
