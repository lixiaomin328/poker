dataFolder = 'dataMat/';
subMax = 15;
bluffRt = [];
nonBluffRt = [];
for subId = 3:subMax    
filename = [dataFolder,'participant_',num2str(subId),'.mat'];
if ~exist(filename)
    continue;
end
load([dataFolder,'participant_',num2str(subId),'.mat']);
[bluffingCards,bluffingTrialNum,nonBluffingTrialNum,nonbluffingCards]=findBluffingTrials(subId);
bluffRt = [bluffRt;bluffingCards,dataStructure.p1normalizedRt(bluffingTrialNum),bluffingTrialNum];
nonBluffRt = [nonBluffRt;nonbluffingCards,dataStructure.p1normalizedRt(nonBluffingTrialNum),nonBluffingTrialNum];
end
nonearlyTrialsNon = find(nonBluffRt(:,3)>4);
nonearlyTrialsBlu = find(bluffRt(:,3)>4);
nonBluffRt=nonBluffRt(nonearlyTrialsNon,:);
bluffRt = nonBluffRt(nonearlyTrialsBlu,:);
%mean(bluffRt(find(bluffRt(:,1)==2),2))