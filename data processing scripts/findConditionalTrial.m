function allEntries = findConditionalTrial()
dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat'] );
allEntries = repmat(struct(),[length(dataFiles),1]);
for i = 1:length(dataFiles)
    fileName = dataFiles(i).name;
    load([dataFolder,fileName]);
    condition = dataStructure.P2card==7&dataStructure.P2card>dataStructure.P1card;
    subjectId = str2double(fileName(13));
    conditionEntries = find(condition)+3;
    allEntries(i).subjectId = subjectId;
    allEntries(i).trialNumbers = conditionEntries;
end
