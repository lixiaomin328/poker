%% Individual level

dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat']);
individualsLevel1 = [];
individualsLevel2 = [];
isAmazon = 0;
p1RTs = [];
p2RTs = [];
bluffing = [];
payoffsP1 = [];
payoffsP2 = [];
load('modelSource20.mat')
load('../model_fitting/bestFitSub20.mat')
for i = 1:length(dataFiles)%2:1+length(dataFiles)
    %subId = amazonIds{i};
    subId = i +1;
%     if isAmazon
%         fileName = [dataFolder,'participant_',num2str(subId),'.mat'];
%     else
%         fileName = [dataFolder,'participant_',subId,'.mat'];
%     end
%     if ~exist(fileName)
%         continue
%     end
    [proportionsBetP1,proportionsBetP2,p1rt,p2rt] = individualStrategy(num2str(subId),dataFolder);
    bluffing = [bluffing;proportionsBetP1(1)];
    [p1Earnings,~]=twoStrategyCompete(proportionsBetP1,aveP2);
    [~,p2Earnings]=twoStrategyCompete(aveP1,proportionsBetP2);
    %[proportionsBetP1,proportionsBetP2,p1rt,p2rt] = individualStrategy(subId,dataFolder);
    p1rtAve = mean(p1rt(~isnan(p1rt)));
    p2rtAve = mean(p2rt(~isnan(p2rt)));
    lb = zeros(1,11);
    ub = ones(1,11);
    Aeq = ones(1,11);
    beq = 1;
    coef1 = lsqlin(p1,proportionsBetP1,[],[],Aeq,beq,lb,ub);
    coef2 = lsqlin(p2,proportionsBetP2,[],[],Aeq,beq,lb,ub);
    individualsLevel1 = [individualsLevel1,coef1];
    individualsLevel2 = [individualsLevel2,coef2];
    p1RTs = [p1RTs;p1rtAve];
    p2RTs = [p2RTs;p2rtAve];
    payoffsP1 = [payoffsP1;p1Earnings];
    payoffsP2 = [payoffsP2;p2Earnings];
end
%%
levelId = [0:1:10];
averageLevels1 = levelId*individualsLevel1;
averageLevels2 = levelId*individualsLevel2;
hist(averageLevels1)
hist(averageLevels2)
title('histgram of individual levels')
ylabel('density')
xlabel('level')
