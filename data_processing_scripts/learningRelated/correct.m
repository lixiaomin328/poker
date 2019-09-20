%% initialize things
%looks if there is a correlation between proportion of correct answers on a
%5 (tricky 'middle' value) and how long they thought about it
dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat']);
for k = 1:length(dataFiles)
load([dataFolder,dataFiles(k).name])

p1Card = dataStructure.P1card;
p2Card = dataStructure.P2card;
p1Action = dataStructure.player1ActionCheck_keys;
p2Action = dataStructure.player2ActionCheck_keys;

%% for p1


p1Total = length(p1Action);
p1Correct = zeros(1,8);
p1Wrong = zeros(1,8);


for i = 1:p1Total
    if (p1Card(i) == 2 || p1Card(i) >= 6) && (p1Action(i) == 1)
        p1Correct(p1Card(i)) = p1Correct(p1Card(i))+1;
    elseif (p1Card(i) == 2 || p1Card(i) >= 6) && (p1Action(i) == 0)
        p1Wrong(p1Card(i)) = p1Wrong(p1Card(i)) + 1;
    elseif ((3 <= p1Card(i)) &&  (p1Card(i) <= 5)) && (p1Action(i) == 0)
        p1Correct(p1Card(i)) = p1Correct(p1Card(i)) +1;
    else
        p1Wrong(p1Card(i)) = p1Wrong(p1Card(i)) + 1;
    end
end


p1PerformanceByCard = p1Correct./(p1Correct + p1Wrong);
p1PerformanceByCard = p1PerformanceByCard(2:end);

%% for p2

p2Correct = zeros(1,8);
p2Wrong = zeros(1,8);

p2Total = length(p2Action);

for i = 1:p2Total
    if (p2Card(i) >= 5) && (p2Action(i) == 1)
        p2Correct(p2Card(i)) = p2Correct(p2Card(i))+1;
    elseif (p2Card(i) >= 5) && (p2Action(i) == 0)
        p2Wrong(p2Card(i)) = p2Wrong(p2Card(i)) + 1;
    elseif (p2Card(i) < 5) && (p2Action(i) == 1)
        p2Wrong(p2Card(i)) = p2Wrong(p2Card(i)) + 1;
    else
        p2Correct(p2Card(i)) = p2Correct(p2Card(i))+1;
    end
end

p2PerformanceByCard = p2Correct./(p2Correct + p2Wrong);
p2PerformanceByCard = p2PerformanceByCard(2:end);

%% get the RTs

[p1Actions,p1Card,p1rt,p2Actions,p2Cards,p2rt] = getIndividualRTandChoice(k);

%use 5 as the mid card whetere decisions are the hardest
whereP15 = find(p1Card == 5);
p1rt5 = p1rt(whereP15);
p1Per5 = p1PerformanceByCard(4);
p1rt5 = nanmean(p1rt5);
scatter(p1rt5, p1Per5)
hold on
whereP25 = find(p2Card == 5);
p2rt5 = p1rt(whereP25);
p2Per5 = p2PerformanceByCard(4);
p2rt5 = nanmean(p2rt5);
scatter(p2rt5, p2Per5)
hold on
savedRT(k) = p1rt5;
savedPer(k) = p1Per5;
savedRT(k+6) = p2rt5;
savedPer(k+6) = p2Per5;
end
