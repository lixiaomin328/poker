gazeFolder = 'processedGazeDataMat/';
pupilInAllCards= cell(8,1);
%for j = 1:8
allEntries = findConditionalTrial();
pupilOfInterest = [];
for i = 1:length(allEntries)
    subId = allEntries(i).subjectId;
filesContain = dir(sprintf('%s%02d_._*.mat',gazeFolder,subId));
if isempty(filesContain)
    continue;
end
load([gazeFolder,filesContain.name])
pupilOfInterest = [pupilOfInterest;data_et.pupilSize(allEntries(i).trialNumbers)];
end
pupilInAllCards{j} = pupilOfInterest;
%end
