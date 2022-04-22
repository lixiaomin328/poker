%function[] = rtAnalysis(dataStruct)
%[p1Actions,p1Cards,~,p2Actions,p2Cards,~,p1rt,p2rt] = getRTandChoice();
%%normalized
[p1Actions,p1Cards,p1rt,p2Actions,p2Cards,p2rt,~,~] = getRTandChoice();
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

p1BetRTstd = zeros(1,7);
p1CheckRTstd = zeros(1,7);
p2CallRTstd = zeros(1,7);
p2FoldRTstd = zeros(1,7);
p1RtByCardstd = [];
p2RtByCardstd = [];
for i = 2:8
    whenBet = find((p1Cards == i) & (betChoicesP1 == i)); %give indexes
    p1BetRT(1, i-1) = mean(p1rt(whenBet));
    p1BetRTstd(1, i-1)=std(p1rt(whenBet))/length(p1rt(whenBet));
    whenCheck = find((p1Cards == i) & (checkChoicesP1 == i)); %give indexes
    p1CheckRT(1, i-1) = mean(p1rt(whenCheck));
    p1CheckRTstd(1, i-1)=std(p1rt(whenCheck))/length(p1rt(whenCheck));
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
    p1RtByCardstd = [p1RtByCardstd;std(p1rtCardi(~isnan(p1rtCardi)))/sqrt(length(p1rtCardi(~isnan(p1rtCardi))))];
    p2RtByCardstd = [p2RtByCardstd;std(p2rtCardi(~isnan(p2rtCardi)))/sqrt(length(p2rtCardi(~isnan(p2rtCardi))))];
    p2CallRTstd(1, i-1) = std(p2rt(whenCall))/length(p2rt(whenCall));
    p2FoldRTstd(1, i-1) = std(p2rt(whenFold))/length(p2rt(whenFold));
end



%% plot
w = 2:1:8;
%p2FoldRTstd(6)=0;
% subplot(3,1,1)
% errorbar(w, p1BetRT,p1BetRTstd)
% hold on
% errorbar(w, p1CheckRT,p1CheckRTstd)
% legend('P1 Bet RT', 'P1 Check RT')
% title('Reaction Times by Card for P1 Decisions')
% xlabel('Card Value')
% %ylabel('Reaction Time (s)')
% plotImprovement
% 
% subplot(3,1,2)
% errorbar(w, p2CallRT,p2CallRTstd)
% hold on
% errorbar(w, p2FoldRT,p2FoldRTstd)
% legend('P2 Call RT', 'P2 FoldRT')
% title('Reaction Times by Card for P2 Decisions')
% xlabel('Card Value')
% ylabel('Reaction Time (s)')
% plotImprovement

%subplot(3,1,3)
figure()
subplot(1,2,1)
errorbar(w, p1RtByCard,p1RtByCardstd)
hold on
errorbar(w, p2RtByCard,p2RtByCardstd)
legend('p1 RT', 'P2 RT')
title('Reaction Times by Cards')
xlabel('Card Value')
ylabel('Response Time')

%ylabel('Reaction Time (s)')
plotImprovement

%% conditional stats for two players
p1BetMean = mean(p1rt(p1Actions==1),'omitnan');
p1CheckMean= mean(p1rt(p1Actions==0),'omitnan');
p2BetMean = mean(p2rt(p2Actions==1),'omitnan');
p2CheckMean= mean(p2rt(p2Actions==0),'omitnan');

p1BetSte = std(p1rt(p1Actions==1),'omitnan')/sqrt(length(p1rt(p1Actions==1)));
p1CheckSte= std(p1rt(p1Actions==0),'omitnan')/sqrt(length(p1rt(p1Actions==0)));
p2BetSte = std(p2rt(p2Actions==1),'omitnan')/sqrt(length(p2rt(p2Actions==1)));
p2CheckSte= std(p2rt(p2Actions==0),'omitnan')/sqrt(length(p2rt(p2Actions==0)));
subplot(1,2,2)
barwitherr([p1BetSte,p1CheckSte;p2BetSte,p2CheckSte],[p1BetMean,p1CheckMean;p2BetMean,p2CheckMean]);
%xlabel('Player 1', 'Player 2')
legend('Bet/Call','Check/Fold')

set(gca,'XTickLabel',{'Player 1','Player 2'})
ylabel('Response Time')
plotImprovement