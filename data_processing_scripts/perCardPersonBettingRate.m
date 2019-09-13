function [proportionsBetP1,proportionsBetP2,p1RtperRate,p2RtperRate] = perCardPersonBettingRate(subId)    
[p1Actions,p1Cards,~,p2Actions,p2Cards,~, ~,~,p1rt,p2rt] = getIndividualRTandChoice(subId);    
%% set up P1
p1RtperRate = zeros(1, 7); 
p2RtperRate = zeros(1, 7); 
betChoicesP1 = p1Cards .* p1Actions;
betChoicesP1(betChoicesP1 <= 0) = [];    
proportionsBetP1 = zeros(1, 7);    
for cardNum = 2:8
    proportionsBetP1(1, cardNum-1) = (length(find(betChoicesP1 == cardNum)))/(sum(p1Cards == cardNum&p1Actions>-0.5));
    rtAll= p1rt(find(p1Cards==cardNum));
    p1RtperRate(1,cardNum-1) = mean(rtAll(~isnan(rtAll)));
end    
%% set up P2
p2Call = (p2Actions == 1);
p2Fold = (p2Actions == 0);
p2Opportunities = p2Call + p2Fold;    
betChoicesP2 = p2Cards .* p2Call;
betChoicesP2(betChoicesP2 == 0) = [];    
proportionsBetP2 = zeros(1, 7);    
for cardNum = 2:8
    howManyBets = length(find(betChoicesP2 == cardNum));
    howManyChances = sum((p2Opportunities == 1) & (p2Cards == cardNum&p1Actions>-0.5));
    proportionsBetP2(1, cardNum-1) = howManyBets/howManyChances;
    rtAll= p2rt(find(p2Cards==cardNum));
    p2RtperRate(1,cardNum-1) = mean(rtAll(~isnan(rtAll)));
end  