if ~exist('GazeDataMat')
    mkdir('GazeDataMat')
end
dataFolder = '../edfData/';
saveDir = 'GazeDataMat/';
dataFiles = dir([dataFolder,'*.EDF']);
for i = 1:length(dataFiles)
    if strcmp(dataFiles(i).name(4),'T')
              continue;
    end
    if sum(dataFiles(i).name(1:2) == '00') ~= 2
        gazePreparation(saveDir,dataFiles(i).name,dataFolder)
    end
end

