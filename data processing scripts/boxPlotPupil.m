%%With different card
gazeFolder = 'processedGazeDataMat/';
pupilInAllCards= cell(8,1);
for k = 2:8
    allEntries = findConditionalTrial(k);
    pupilOfInterestAllPeople = [];
    for i = 1:length(allEntries)
        pupilOfInterest = [];
        
        
        subId = allEntries(i).subjectId;
        filesContain = dir(sprintf('%s%02d_._*.mat',gazeFolder,subId));
        if isempty(filesContain)
            continue;
        end
        load([gazeFolder,filesContain.name])
        baseline = mean(data_et.pupilSize(~isnan(data_et.pupilSize)));
        stdPupil = std(data_et.pupilSize(~isnan(data_et.pupilSize)));
        %to add all the pupil entries for each trial
        for j = 1:length(allEntries(i).trialNumbers)
            what = (allEntries(i).trialNumbers(j));
            where = find(data_et.trialIndex == what& data_et.eventType==1);
            if isempty(where)
                continue;
            end
            %per person per trial all pupil and timestamp
            new=[data_et.pupilSize(where)./baseline,data_et.time(where)];
            cluster = new(:,2)-new(1,2);
            cluster = cluster/300;
            cluster = round(cluster);
            new = [new,cluster];
            pupilOfInterest = [pupilOfInterest;new];
        end
        pupilOfInterest = pupilOfInterest(~isnan(pupilOfInterest(:,1)),:);
        pupilOfInterestAllPeople = [pupilOfInterestAllPeople;pupilOfInterest];
    end
    pupilInAllCards{k} = pupilOfInterestAllPeople;
end