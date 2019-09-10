if ~exist('DataMat')
    mkdir('DataMat')
end
dataFolder = '../data/';
dataFiles = dir([dataFolder,'*.csv']);
for i = 8:length(dataFiles)
    if sum(dataFiles(i).name(1:2) == '00') ~= 2
        behavioralFileRead(dataFiles(i).name);
    end
end
