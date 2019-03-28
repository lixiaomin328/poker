gazeFolder = 'GazeDataMat/';
allEntries = findConditionalTrial(dataStructure.P2card==7&dataStructure.P2card<dataStructure.P1card);
pupilOfInterest = [];
for i = 1:length(allEntries)
    subId = allEntries(i).subjectId;
filesContain = dir(sprintf('%s%02d_._*.mat',gazeFolder,subId));
if isempty(filesContain)
    continue;
end
load([gazeFolder,filesContain.name])
pupilOfInterest = [pupilOfInterest;]
end
