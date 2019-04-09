%fixation analysis
%%With different card
gazeFolder = 'processedGazeDataMat/';
pupilInAllCards= cell(8,1);
for k = 2:8
    allEntries = findConditionalTrial(k);
    pupilOfInterestAllPeople = [];
    for i = 1:length(allEntries)
        fixationOfInterest = [];
        
        
        subId = allEntries(i).subjectId;
        filesContain = dir(sprintf('%s%02d_._*.mat',gazeFolder,subId));
        if isempty(filesContain)
            continue;
        end
        load([gazeFolder,filesContain.name])
        %to add all the pupil entries for each trial
        for j = 2%1:length(allEntries(i).trialNumbers)
            what = (allEntries(i).trialNumbers(j));
            where = find(data_et.trialIndex == what& data_et.eventType==1);
            if isempty(where)
                continue;
            end
            %per person per trial all pupil and timestamp
            new=[data_et.FixPosX(where),data_et.FixPosY(where),data_et.time(where)];
            cluster = new(:,2)-new(1,2);
            fixationOfInterest = [fixationOfInterest;new];
        end
        fixationOfInterest = fixationOfInterest(~isnan(fixationOfInterest(:,1)),:);
        pupilOfInterestAllPeople = [pupilOfInterestAllPeople;fixationOfInterest];
    end
    pupilInAllCards{k} = pupilOfInterestAllPeople;
end