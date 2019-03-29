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
    %to add all the pupil entries for each trial
    for j = 1:length(allEntries(i).trialNumbers)
        what = (allEntries(i).trialNumbers(j));
        where = find(data_et.trialIndex == what);
        pupilOfInterest = [pupilOfInterest;data_et.pupilSize(where)];
    end
end
%pupilInAllCards{j} = pupilOfInterest;
%end
