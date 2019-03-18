if ~exist('DataMat')
    mkdir('DataMat')
end
dataFolder = '../data/';
dataFiles = dir([dataFolder,'*.csv']);
for i = 1:length(dataFiles)
    fileread(dataFiles(i).name);
end