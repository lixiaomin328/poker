function [proportionsBetP1,proportionsBetP2] = individualStrategy(subId)
%individual strategies
[p1Actions,p1Cards,p1rt,p2Actions,p2Cards,p2rt] = getIndividualRTandChoice(subId);
dataMatrix = [p1Actions,p1Cards,p1rt,p2Actions,p2Cards,p2rt];
%% set up P1
betChoicesP1 = p1Cards .* p1Actions;
betChoicesP1(betChoicesP1 <= 0) = [];

proportionsBetP1 = zeros(1, 7);

for i = 2:8
    proportionsBetP1(1, i-1) = (length(find(betChoicesP1 == i)))/(sum(p1Cards == i&p1Actions>-0.5));
end

%% set up P2
p2Call = (p2Actions == 1);
p2Fold = (p2Actions == 0);
p2Opportunities = p2Call + p2Fold;

betChoicesP2 = p2Cards .* p2Call;
betChoicesP2(betChoicesP2 == 0) = []; 

proportionsBetP2 = zeros(1, 7);

for i = 2:8
    howManyBets = length(find(betChoicesP2 == i)); 
    howManyChances = sum((p2Opportunities == 1) & (p2Cards == i&p1Actions>-0.5));
    proportionsBetP2(1, i-1) = howManyBets/howManyChances;
end

