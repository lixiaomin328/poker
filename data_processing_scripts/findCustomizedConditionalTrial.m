function allEntries = findCustomizedConditionalTrial(k)
dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat'] );
allEntries = repmat(struct(),[length(dataFiles),1]);
for i = 1:length(dataFiles)
    fileName = dataFiles(i).name;
    load([dataFolder,fileName]);
    %condition = dataStructure.P2card==k;
    if k==1
    condition = dataStructure.P2card==7&dataStructure.P1card<dataStructure.P2card;
    else
    condition = dataStructure.P2card==7&dataStructure.P1card>dataStructure.P2card; 
    end
    subjectId = str2double(fileName(13));
    conditionEntries = find(condition)+3;
    allEntries(i).subjectId = subjectId;
    allEntries(i).trialNumbers = conditionEntries;
end
