%%With different card
gazeFolder = 'processedGazeDataMat/';

%make allEntriesDecision equivalent to original all entries
%(subjectNo)*1 struct
%columns: subject instance duration
decisionStruct(1).subjectId = 3;
decisionStruct(1).trialNumbers = 1;
decisionStruct(1).duration = 2000;
decisionStruct(2).subjectId = 4;
decisionStruct(2).trialNumbers = 2;
decisionStruct(2).duration = 3000;

    %allEntries = findCustomizedConditionalTrial(k);
    %allEntries: trial num
    pupilOfInterestAllPeople = [];
    for i = 1:length(decisionStruct) %all entries
        pupilOfInterest = [];
        
        subId = decisionStruct(i).subjectId; %subjects where this happens
        filesContain = dir(sprintf('%s%02d_._*.mat',gazeFolder,subId)); %figure out this line
        
        if isempty(filesContain)
            continue;
        end
        
        load([gazeFolder,filesContain.name])
        baseline = mean(data_et.pupilSize(~isnan(data_et.pupilSize))); %average pupil size
        stdPupil = std(data_et.pupilSize(~isnan(data_et.pupilSize))); %standard dev pupil
        %to add all the pupil entries for each trial
        for j = 1:length(decisionStruct(i).trialNumbers) %how many trials
            what = (decisionStruct(i).trialNumbers(j)); %at what times
            where = find(data_et.trialIndex == what& data_et.eventType==1);
            if isempty(where)
                continue;
            end
            %per person per trial all pupil and timestamp
            new=[data_et.pupilSize(where)./baseline,data_et.time(where)]; 
            %pupil size during these times sdivided by baseline, at what
            %timepoint
            cluster = new(:,2)-new(1,2); %all times minus start time to get relative
            cluster = cluster/300; %why 300?
            cluster = round(cluster);
            new = [new,cluster];
            pupilOfInterest = [pupilOfInterest;new];
        end
        pupilOfInterest = pupilOfInterest(~isnan(pupilOfInterest(:,1)),:);
        pupilOfInterestAllPeople = [pupilOfInterestAllPeople;pupilOfInterest];
    end
%% plot out
meanVector = cell(length(pupilInAllCOnditions),1);
countVector = cell(length(pupilInAllCOnditions),1);

    for j = 1:max(decisionStruct.trialNumbers)
        indexBin = find(decisionStruct.trialNumbers==j);
        
    meanVector = [meanVector{1};mean(pupilOfInterestAllPeople(indexBin,1))];
    countVector{1} = [countVector{1};length(indexBin)];    
    end

%%
for i = 1:2
    lastBin = find(countVector{i}>10,1,'last');
plot(0.6*[1:1:lastBin],meanVector{i}(1:lastBin))
hold on
end

legend('win','lose')