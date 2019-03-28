function allEntries = findConditionalTrial(condition)
dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat'] );
allEntries = repmat(struct(),[length(dataFiles),1]);
for i = 1:length(dataFiles)
    fileName = dataFiles(i).name;
    load([dataFolder,fileName]);
    subjectId = str2double(fileName(13));
    conditionEntries = find(condition)+3;
    allEntries(i).subjectId = subjectId;
    allEntries(i).trialNumbers = conditionEntries;
end
