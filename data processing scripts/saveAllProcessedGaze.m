dataFolder = 'GazeDataMat/';
dataFiles = dir([dataFolder,'*.mat']);
for i = 1:length(dataFiles)         
          if strcmp(dataFiles(i).name(4),'T')
              continue;
          end
    
        parcelTrials(dataFiles(i).name);
    
end