%%With different card
gazeFolder = 'processedGazeDataMat/';
pupilInAllCards= cell(8,1);
for k = 2:8
    allEntries = findConditionalTrial(k);
    pupilOfInterestAllPeople = [];
for i = 2%1:length(allEntries)
    pupilOfInterest = [];
        
        
        subId = allEntries(i).subjectId;
        filesContain = dir(sprintf('%s%02d_._*.mat',gazeFolder,subId));
        if isempty(filesContain)
            continue;
        end
        load([gazeFolder,filesContain.name])
        baseline = median(data_et.pupilSize(~isnan(data_et.pupilSize)));
        stdPupil = std(data_et.pupilSize(~isnan(data_et.pupilSize)));
        %to add all the pupil entries for each trial
        for j = 1:length(allEntries(i).trialNumbers)
            what = (allEntries(i).trialNumbers(j));
            where = find(data_et.trialIndex == what& data_et.eventType==1);
            new=[data_et.pupilSize(where),data_et.time(where)];
            pupilOfInterest = [pupilOfInterest;new];
        end
        pupilOfInterest = pupilOfInterest(~isnan(pupilOfInterest(:,1)),:);
        pupilOfInterest = pupilOfInterest(pupilOfInterest(:,1)<baseline+2*stdPupil);
        pupilOfInterest = pupilOfInterest(pupilOfInterest(:,1)>baseline-2*stdPupil);
        pupilOfInterest = pupilOfInterest./baseline;
        pupilOfInterestAllPeople = [pupilOfInterestAllPeople;pupilOfInterest];
end
pupilInAllCards{k} = pupilOfInterestAllPeople;
end
%        meanCardGaze=[];
%         for m = 2:8
%             meanCardGaze = [meanCardGaze;mean(pupilInAllCards{m})];
%         end
%         plot(2:8,meanCardGaze)
%         hold on
% 
