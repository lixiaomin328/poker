function [p1Actions,p1Cards,p1rtNorm,p2Actions,p2Cards,p2rtNorm,p1rt,p2rt] = getRTandChoice()
dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat']);
p1Cards = [];
p2Cards = [];
p1Actions = [];
p2Actions = [];
p1rtNorm = [];
p2rtNorm = [];
p1rt = [];
p2rt = [];
for i = 1:length(dataFiles)
    load([dataFolder,dataFiles(i).name]);
    p1rt = [p1rt;dataStructure.player1ActionCheck_rt]
    p2rt = [p2rt;dataStructure.player2ActionCheck_rt]
    p1Cards = [p1Cards;dataStructure.P1card];
    p2Cards = [p2Cards;dataStructure.P2card];
    p1Actions = [p1Actions;dataStructure.player1ActionCheck_keys];
    p2Actions = [p2Actions;dataStructure.player2ActionCheck_keys];
    p1AverageRT = mean(dataStructure.player1ActionCheck_rt(~isnan(dataStructure.player1ActionCheck_rt)));
    p2AverageRT = mean(dataStructure.player2ActionCheck_rt(~isnan(dataStructure.player2ActionCheck_rt)));
    p1rtNorm = [p1rtNorm;dataStructure.player1ActionCheck_rt/p1AverageRT];
    p2rtNorm = [p2rtNorm;dataStructure.player2ActionCheck_rt/p2AverageRT];
end
 