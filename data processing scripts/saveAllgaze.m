if ~exist('GazeDataMat')
    mkdir('GazeDataMat')
end
dataFolder = '../edfData/';
saveDir = 'GazeDataMat/';
dataFiles = dir([dataFolder,'*.EDF']);
for i = 13:length(dataFiles)
    if sum(dataFiles(i).name(1:2) == '00') ~= 2
        gazePreparation(saveDir,dataFiles(i).name,dataFolder)
    end
end

