%function[] = rtAnalysis(dataStruct)
[p1Actions,p1Cards,p1rt,p2Cards,p2rt] = getRTandChoice();


%% set up P1 rt per fold or call on each card
betChoicesP1 = p1Cards .* p1Actions;

checkChoicesP1 = p1Cards .* (p1Actions == 0);

p1BetRT = zeros(1,7);

for i = 2:8
    whenBet = find((p1Cards == i) & (betChoicesP1 == i)); %give indexes
    p1BetRT(1, i-1) = mean(p1rt(whenBet));
end

p1CheckRT = zeros(1,7);

for i = 2:8
    whenCheck = find((p1Cards == i) & (checkChoicesP1 == i)); %give indexes
    p1CheckRT(1, i-1) = mean(p1rt(whenCheck));
end

%% set up P2 rt per call and fold for each card
callChoicesP2 = p2Cards .* (p2Actions == 1);

foldChoicesP2 = p2Cards .* (p2Actions == 0);

p2CallRT = zeros(1,7);

for i = 2:8
    whenCall = find((p2Cards == i) & (callChoicesP2 == i)); %give indexes
    p2CallRT(1, i-1) = mean(p2rt(whenCall));
end

p2FoldRT = zeros(1,7);

for i = 2:8
    whenFold = find((p2Cards == i) & (foldChoicesP2 == i)); %give indexes
    p2FoldRT(1, i-1) = mean(p2rt(whenFold));
end

%% plot
w = 2:1:8;

subplot(2,1,1)
plot(w, p1BetRT)
hold on
plot(w, p1CheckRT)
legend('P1 Bet RT', 'P1 Check RT')
title('Reaction Times by Card for P1 Decisions')
xlabel('Card Value')
ylabel('Reaction Time (s)')

subplot(2,1,2)
plot(w, p2CallRT)
hold on
plot(w, p2FoldRT)
legend('P2 Call RT', 'P2 FoldRT')
title('Reaction Times by Card for P2 Decisions')
xlabel('Card Value')
ylabel('Reaction Time (s)')

%

