rtB = [];
rtN = [];
for isAmazon = 0:1
%isAmazon = 0;
bluffRt = [];
nonBluffRt = [];
if isAmazon ==1
    dataFolder = 'mTurkDataMat1/';
    load('subIdAmazon.mat')
else
dataFolder = 'DataMat/';
end
dataFile = dir([dataFolder,'*.mat']);
for subId = 1:length(dataFile)
    filename = [dataFolder,dataFile(subId).name];
%filename = [dataFolder,'participant_',num2str(subId),'.mat'];
if ~exist(filename)
     continue;
end
load(filename);
[bluffingCards,bluffingTrialNum,nonBluffingTrialNum,nonbluffingCards]=findBluffingTrials(filename);
bluffRt = [bluffRt;bluffingCards,dataStructure.player1ActionCheck_rt(bluffingTrialNum),bluffingTrialNum];
nonBluffRt = [nonBluffRt;nonbluffingCards,dataStructure.player1ActionCheck_rt(nonBluffingTrialNum),nonBluffingTrialNum];
end
nonearlyTrialsNon = find(nonBluffRt(:,3)>4);
nonearlyTrialsBlu = find(bluffRt(:,3)>4);
nonBluffRt=nonBluffRt(nonearlyTrialsNon,:);
bluffRt = nonBluffRt(nonearlyTrialsBlu,:);
rtB = [rtB;bluffRt(:,2)];
rtN = [rtN;nonBluffRt(:,2)];
end
rtB(rtB>8)=[];
rtN(rtN>8)=[];

[h,t] = ttest2(rtB,rtN)%mean(bluffRt(find(bluffRt(:,1)==2),2))