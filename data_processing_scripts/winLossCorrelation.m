dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat'] );


for i = 1:length(dataFiles)
    fileName = dataFiles(i).name;
    load([dataFolder,fileName]);
    p1Move = dataStructure.player1ActionCheck_keys;
    p2Move = dataStructure.player2ActionCheck_keys;
    p1Card = dataStructure.P1card;
    p2Card = dataStructure.P2card;
    [~,~, indicatorWin]= earningsCalc(p1Move, p2Move, p1Card, p2Card);
    %indicatorWin is 0 when P2 wins, +1 when P1 wins
    %modify indicatorWin
    whereNeg = find(indicatorWin == -1);
    indicatorWin(whereNeg) = 0;
    
    %to add in card dealt
    %p1CardCategorical = categorical(p1Card);
    indicatorAndCards = [indicatorWin, p1Card];
    
    
    shiftedP1actions = [(p1Move(1:end-1))', 0]';
    whereBet = find(shiftedP1actions == 1);
    shiftedP1actions(whereBet) = 2; %so all bets are now 2
    whereCheck = find(shiftedP1actions == 0);
    shiftedP1actions(whereCheck) = 1; %checks are 1
    whereTO = find(shiftedP1actions == -1);
    if ~isempty(whereTO) %remove TO
        shiftedP1actions(whereTO) = [];
        indicatorAndCards(whereTO, :) = [];
    end
    
    %savedCorr(1, i) = corr(shiftedP1actions, indicatorWin);
    %statsname = char(compose('stats%d', i));
    [B,dev,stats] = mnrfit(indicatorAndCards, shiftedP1actions)
    pVal = stats.p
    tVal = stats.t
    seVal = stats.se
    
end