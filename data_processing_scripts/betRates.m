[p1Actions,p1Cards,p1rt,p2Actions,p2Cards,p2rt] = getRTandChoice();

%% set up P1
betChoicesP1 = p1Cards .* p1Actions;
betChoicesP1(betChoicesP1 <= 0) = [];

proportionsBetP1 = zeros(1, 7);
nP1 = zeros(1, 7);
nP2 = zeros(1, 7);
for i = 2:8
    proportionsBetP1(1, i-1) = (length(find(betChoicesP1 == i)))/(sum(p1Cards == i&p1Actions>-0.5));
    nP1(1, i-1) = sum(p1Cards == i&p1Actions>-0.5);
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
    howManyChances = sum((p2Opportunities == 1) & (p2Cards == i&p2Actions>-0.5));
    proportionsBetP2(1, i-1) = howManyBets/howManyChances;
    nP2(1, i-1) = howManyChances;
end

%% plot
Lwidth = 1.5;
w = 2:1:8;
stdP1 = sqrt(proportionsBetP1.*(1-proportionsBetP1)./nP1);
errorbar(w, proportionsBetP1,stdP1)
xlabel('Card Value')
ylabel('Bet Rate per Card')
hold on
stdP2 = sqrt(proportionsBetP2.*(1-proportionsBetP2)./nP2);
errorbar(w, proportionsBetP2,stdP2)
plot(2:3,ones(2),'--b','LineWidth',Lwidth)
plot(2:5,0.01*ones(4),'--r','LineWidth',Lwidth)
plot(5:8,0.99*ones(4),'--r','LineWidth',Lwidth)
plot(3:6,zeros(4),'--b','LineWidth',Lwidth)
plot(6:8,ones(3),'--b','LineWidth',Lwidth)
legend('Player 1', 'Player 2')
vline(3,'--b')
vline(6,'--b')
vline(5,'--r')
title('Bet Rate Profiles per Player in Simplified Poker')
%end
hold off