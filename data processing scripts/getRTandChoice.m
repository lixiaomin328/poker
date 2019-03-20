function [p1Actions,p1Cards,p1rt,p2Cards,p2rt] = getRTandChoice()
dataFolder = 'dataMat/';
dataFiles = dir([dataFolder,'*.mat']);
p1Cards = [];
p2Cards = [];
p1Actions = [];
p2Actions = [];
p1rt = [];
p2rt = [];
for i = 1:length(dataFiles)
    load([dataFolder,dataFiles(i).name]);
    p1Cards = [p1Cards;dataStructure.P1card];
    p2Cards = [p2Cards;dataStructure.P2card];
    p1Actions = [p1Actions;dataStructure.player1ActionCheck_keys];
    p2Actions = [p2Actions;dataStructure.player2ActionCheck_keys];
    p1rt = [p1rt;dataStructure.player1ActionCheck_rt];
    p2rt = [p2rt;dataStructure.player2ActionCheck_rt];
end