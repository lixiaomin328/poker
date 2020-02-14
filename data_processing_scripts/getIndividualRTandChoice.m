function [p1Actions,p1Cards,p1rt,p2Actions,p2Cards,p2rt, p1AverageRT, p2AverageRT,p1NormRt,p2NormRt] = getIndividualRTandChoice(fileName,dataFolder)
starting = 4;
dataFiles = dir([dataFolder,'*.mat']);
p1Cards = [];
p2Cards = [];
p1Actions = [];
p2Actions = [];
p1rt = [];
p2rt = [];
if ~exist(fileName)
    return
end
    load(fileName);
    p1Cards = dataStructure.P1card(starting:end);
    p2Cards = dataStructure.P2card(starting:end);
    p1Actions = dataStructure.player1ActionCheck_keys(starting:end);
    p2Actions = dataStructure.player2ActionCheck_keys(starting:end);
    p1AverageRT = mean(dataStructure.player1ActionCheck_rt(~isnan(dataStructure.player1ActionCheck_rt(starting:end))));
    p2AverageRT = mean(dataStructure.player2ActionCheck_rt(~isnan(dataStructure.player2ActionCheck_rt(starting:end))));
    p1rt = dataStructure.player1ActionCheck_rt(starting:end);
    p2rt = dataStructure.player2ActionCheck_rt(starting:end);
    p1NormRt = dataStructure.p1normalizedRt(starting:end);
    p2NormRt = dataStructure.p2normalizedRt(starting:end);
