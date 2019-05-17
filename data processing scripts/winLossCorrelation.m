dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat'] );
savedCorr = zeros(1,length(dataFiles));

for i = 1:length(dataFiles)
    fileName = dataFiles(i).name;
    load([dataFolder,fileName]);
    p1Move = dataStructure.player1ActionCheck_keys;
    p2Move = dataStructure.player2ActionCheck_keys;
    p1Card = dataStructure.P1card;
    p2Card = dataStructure.P2card;
    [~,~, indicatorWin]= earningsCalc(p1Move, p2Move, p1Card, p2Card);
    %indicatorWin is -1 when P2 wins, +1 when P1 wins
    shiftedP1actions = [(p1Move(1:end-1))', 0]';
    whereCheck = find(shiftedP1actions == 0);
    shiftedP1actions(whereCheck) = -1; %so all checks are now -1
    
    savedCorr(1, i) = corr(shiftedP1actions, indicatorWin);
    lm = fitlm(indicatorWin, shiftedP1actions)
end