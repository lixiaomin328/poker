function allEntries = findConditionalTrial(k)
dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat'] );
allEntries = repmat(struct(),[length(dataFiles),1]);
for i = 1:length(dataFiles)
    fileName = dataFiles(i).name;
    load([dataFolder,fileName]);
    condition = dataStructure.P2card==k;
%     if k==1
%     condition = dataStructure.player2ActionCheck_keys==1;
%     else
%     condition = dataStructure.player2ActionCheck_keys==0; 
%     end
    subjectId = str2double(fileName(13));
    conditionEntries = find(condition)+3;
    allEntries(i).subjectId = subjectId;
    allEntries(i).trialNumbers = conditionEntries;
end
