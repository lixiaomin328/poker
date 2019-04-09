%%With different card
gazeFolder = 'processedGazeDataMat/';
pupilInAllCOnditions= cell(2,1);
for k = 1:length(pupilInAllCOnditions)
    allEntries = findCustomizedConditionalTrial(k);
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
            where = find(data_et.trialIndex == what& data_et.eventType==3);
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
    pupilInAllCOnditions{k} = pupilOfInterestAllPeople;
end
%% plot out
meanVector = cell(length(pupilInAllCOnditions),1);
countVector = cell(length(pupilInAllCOnditions),1);
for i = 1:length(pupilInAllCOnditions)

    for j = 1:max(pupilInAllCOnditions{i}(:,3))+1
        indexBin = find(pupilInAllCOnditions{i}(:,3)==j-1);
        
    meanVector{i} = [meanVector{i};mean(pupilInAllCOnditions{i}(indexBin,1))];
    countVector{i} = [countVector{i};length(indexBin)];    
    end
end
%%
for i = 1:2
    lastBin = find(countVector{i}>1000,1,'last');
plot(0.6*[1:1:lastBin],meanVector{i}(1:lastBin))
hold on
end

legend('win','lose')