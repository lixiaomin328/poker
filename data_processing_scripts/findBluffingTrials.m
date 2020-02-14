function [bluffingCards,bluffingTrialNum,nonBluffingTrialNum,nonbluffingCards]=findBluffingTrials(fileName)
load(fileName);
nonBluffingTrialNum=find(dataStructure.player1ActionCheck_keys==0&dataStructure.P1card<4);
bluffingTrialNum = find(dataStructure.player1ActionCheck_keys==1&dataStructure.P1card<4);%ADJUST BLUFF THREASHOLD HERE
bluffingCards = dataStructure.P1card(bluffingTrialNum);
nonbluffingCards = dataStructure.P1card(nonBluffingTrialNum);