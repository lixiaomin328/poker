dataFolder = 'GazeDataMat/';
dataFiles = dir([dataFolder,'*.mat']);
for i = 1:length(dataFiles)    
        parcelTrials(dataFiles(i).name);
    
end