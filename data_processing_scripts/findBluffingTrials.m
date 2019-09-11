function [bluffingCards,bluffingTrialNum,nonBluffingTrialNum,nonbluffingCards]=findBluffingTrials(subId)
dataFolder = 'dataMat/';
load([dataFolder,'participant_',num2str(subId),'.mat']);
nonBluffingTrialNum=find(dataStructure.player1ActionCheck_keys==0&dataStructure.P1card<5);
bluffingTrialNum = find(dataStructure.player1ActionCheck_keys==1&dataStructure.P1card<5);%ADJUST BLUFF THREASHOLD HERE
bluffingCards = dataStructure.P1card(bluffingTrialNum);
nonbluffingCards = dataStructure.P1card(nonBluffingTrialNum);