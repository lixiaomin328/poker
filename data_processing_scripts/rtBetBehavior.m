dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat'] );
allEntries = repmat(table(),[length(dataFiles),1]);
fullStruct = struct;
for i = 1:length(dataFiles)
    fileName = dataFiles(i).name;
    load([dataFolder,fileName]);
    %one is sequence of cards
    if i == 1
        fullStruct.cardSequence = dataStructure.P1card;
    else
        cardSequence = cat(1, fullStruct.cardSequence, dataStructure.P1card);
    end
    %one is sequence of actions
    if i == 1
        fullStruct.actionSequence = dataStructure.player1ActionCheck_keys;
    else
        cardSequence = cat(1, fullStruct.actionSequence, dataStructure.player1ActionCheck_keys);
    end
    %remove nans
    dataStructure.player1ActionCheck_rt = dataStructure.player1ActionCheck_rt(~isnan(dataStructure.player1ActionCheck_rt));
    dataStructure.P1card = dataStructure.P1card(~isnan(dataStructure.player1ActionCheck_rt));
    dataStructure.player1ActionCheck_keys = dataStructure.player1ActionCheck_keys(~isnan(dataStructure.player1ActionCheck_rt));
    
    [~,~,~,~,~,~, p1AverageRT, ~] = getIndividualRTandChoice(i);
    
    for j = 2:8 %card range
        betRtName = char(compose('betRTcard%d', j));
        whereBet = find((dataStructure.P1card == j) & (dataStructure.player1ActionCheck_keys == 1));
        checkRtName = char(compose('checkRTcard%d', j));
        whereCheck = find((dataStructure.P1card == j) & (dataStructure.player1ActionCheck_keys == 0));
        whereCard = find(dataStructure.P1card == j);
        cardRtName = char(compose('RTcard%d', j));
        cardActionName = char(compose('ActionCard%d', j));
        
        if i == 1
            fullStruct.(betRtName) = (dataStructure.player1ActionCheck_rt(whereBet))/p1AverageRT;
            fullStruct.(checkRtName) = (dataStructure.player1ActionCheck_rt(whereCheck))/p1AverageRT;
            fullStruct.(cardRtName) = (dataStructure.player1ActionCheck_rt(whereCard))/p1AverageRT;
            fullStruct.(cardActionName) = (dataStructure.player1ActionCheck_keys(whereCard));
        else
            fullStruct.(betRtName) = cat(1, fullStruct.(betRtName), dataStructure.player1ActionCheck_rt(whereBet))/p1AverageRT;
            fullStruct.(checkRtName) = cat(1, fullStruct.(checkRtName), dataStructure.player1ActionCheck_rt(whereCheck))/p1AverageRT;
            fullStruct.(cardRtName) = cat(1, fullStruct.(cardRtName),dataStructure.player1ActionCheck_rt(whereCard))/p1AverageRT;
            fullStruct.(cardActionName) = cat(1, fullStruct.(cardActionName), dataStructure.player1ActionCheck_keys(whereCard));
        end
        
    end
    
end
%correlation coefficients
[R8, P8] = corrcoef(fullStruct.RTcard8, fullStruct.ActionCard8)
[R7, P7] = corrcoef(fullStruct.RTcard7, fullStruct.ActionCard7)
[R6, P6] = corrcoef(fullStruct.RTcard6, fullStruct.ActionCard6)
[R5, P5] = corrcoef(fullStruct.RTcard5, fullStruct.ActionCard5)
[R4, P4] = corrcoef(fullStruct.RTcard4, fullStruct.ActionCard4)
[R3, P3] = corrcoef(fullStruct.RTcard3, fullStruct.ActionCard3)
[R2, P2] = corrcoef(fullStruct.RTcard2, fullStruct.ActionCard2)

%t-tests
[h2,p2,ci2,stats2] =  ttest2(fullStruct.betRTcard2, fullStruct.checkRTcard2)
[h3,p3,ci3,stats3] =  ttest2(fullStruct.betRTcard3, fullStruct.checkRTcard3)
[h4,p4,ci4,stats4] =  ttest2(fullStruct.betRTcard4, fullStruct.checkRTcard4)
[h5,p5,ci5,stats5] =  ttest2(fullStruct.betRTcard5, fullStruct.checkRTcard5)
[h6,p6,ci6,stats6] =  ttest2(fullStruct.betRTcard6, fullStruct.checkRTcard6)