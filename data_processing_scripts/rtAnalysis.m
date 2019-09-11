%function[] = rtAnalysis(dataStruct)
[p1Actions,p1Cards,p1rt,p2Actions,p2Cards,p2rt] = getRTandChoice();

%%for RT regardless of action
p1RtByCard = [];
p2RtByCard = [];
%% set up P1 rt per fold or call on each card
betChoicesP1 = p1Cards .* p1Actions;
checkChoicesP1 = p1Cards .* (p1Actions == 0);
p1BetRT = zeros(1,7);
p1CheckRT = zeros(1,7);
p2CallRT = zeros(1,7);
p2FoldRT = zeros(1,7);
callChoicesP2 = p2Cards .* (p2Actions == 1);
foldChoicesP2 = p2Cards .* (p2Actions == 0);
p1RtAll = cell(7,1);
p2RtAll = cell(7,1);
for i = 2:8
    whenBet = find((p1Cards == i) & (betChoicesP1 == i)); %give indexes
    p1BetRT(1, i-1) = mean(p1rt(whenBet));
    whenCheck = find((p1Cards == i) & (checkChoicesP1 == i)); %give indexes
    p1CheckRT(1, i-1) = mean(p1rt(whenCheck));
    whenCall = find((p2Cards == i) & (callChoicesP2 == i)); %give indexes
    p2CallRT(1, i-1) = mean(p2rt(whenCall));
    whenFold = find((p2Cards == i) & (foldChoicesP2 == i)); %give indexes
    p2FoldRT(1, i-1) = mean(p2rt(whenFold));
    p2rtCardi = p2rt(find(p2Cards ==i));
    p1rtCardi = p1rt(find(p1Cards ==i));
    p1RtAll{i} = p1rtCardi(~isnan(p1rtCardi));
    p2RtAll{i} = p2rtCardi(~isnan(p2rtCardi));
    p1RtByCard = [p1RtByCard;mean(p1rtCardi(~isnan(p1rtCardi)))];

    p2RtByCard = [p2RtByCard;mean(p2rtCardi(~isnan(p2rtCardi)))];
end



%% plot
w = 2:1:8;

subplot(3,1,1)
plot(w, p1BetRT)
hold on
plot(w, p1CheckRT)
legend('P1 Bet RT', 'P1 Check RT')
title('Reaction Times by Card for P1 Decisions')
xlabel('Card Value')
ylabel('Reaction Time (s)')

subplot(3,1,2)
plot(w, p2CallRT)
hold on
plot(w, p2FoldRT)
legend('P2 Call RT', 'P2 FoldRT')
title('Reaction Times by Card for P2 Decisions')
xlabel('Card Value')
ylabel('Reaction Time (s)')

subplot(3,1,3)
plot(w, p1RtByCard)
hold on
plot(w, p2RtByCard)
legend('p1 RT', 'P2 RT')
title('Reaction Times by Cards')
xlabel('Card Value')
ylabel('Reaction Time (s)')
%

