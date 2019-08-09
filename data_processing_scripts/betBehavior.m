[p1Actions,p1Cards,p1rt,p2Actions,p2Cards,p2rt] = getRTandChoice();
dataMatrix = [p1Actions,p1Cards,p1rt,p2Actions,p2Cards,p2rt];
%% set up P1 & P2

%for P1 bet
betChoicesP1 = p1Cards .* p1Actions;
%betChoicesP1(betChoicesP1 <= 0) = [];
proportionsBetP1byCard = zeros(1, 7);
%for P1 check
checkChoicesP1 = p1Cards .* (p1Actions == 0);
p1BetRTbyCard = zeros(1,7);
p1CheckRTbyCard = zeros(1,7);

%for P2 bet
p2Call = (p2Actions == 1);
p2Fold = (p2Actions == 0);
p2Opportunities = p2Call + p2Fold;
betChoicesP2 = p2Cards .* p2Call;
%betChoicesP2(betChoicesP2 == 0) = []; 
proportionsBetP2byCard = zeros(1, 7);
%for p2 fold
callChoicesP2 = p2Cards .* (p2Actions == 1);
foldChoicesP2 = p2Cards .* (p2Actions == 0);
p2CallRTbyCard = zeros(1,7);
p2FoldRTbyCard = zeros(1,7);

 %fill out

for i = 2:8
    proportionsBetP1byCard(1, i-1) = (length(find(betChoicesP1 == i)))/(sum(p1Cards == i));
    
    howManyBets = length(find(betChoicesP2 == i)); 
    howManyChances = sum((p2Opportunities == 1) & (p2Cards == i));
    proportionsBetP2byCard(1, i-1) = howManyBets/howManyChances;
    
    whenBet = find((p1Cards == i) & (betChoicesP1 == i)); %give indexes
    p1BetRTbyCard(1, i-1) = mean(p1rt(whenBet));
    
    whenCheck = find((p1Cards == i) & (checkChoicesP1 == i)); %give indexes
    p1CheckRTbyCard(1, i-1) = mean(p1rt(whenCheck));
    
    whenCall = find((p2Cards == i) & (callChoicesP2 == i)); %give indexes
    p2CallRTbyCard(1, i-1) = mean(p2rt(whenCall));
    
    whenFold = find((p2Cards == i) & (foldChoicesP2 == i)); %give indexes
    p2FoldRTbyCard(1, i-1) = mean(p2rt(whenFold));
end

%% desired plot(s) code here


