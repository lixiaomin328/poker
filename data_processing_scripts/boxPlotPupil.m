%%With different card
gazeFolder = 'processedGazeDataMat/';
dataFolder = 'DataMat/';
pupilInAllCards= cell(8,1);
    for i = 1:length(dir('DataMat/*.mat'));
        for k = 2:8
    allEntries = findConditionalTrial(k);
    
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
            cluster = cluster/60;
            cluster = round(cluster);
            new = [new,cluster];
            pupilOfInterest = [pupilOfInterest;new];
        end
        pupilOfInterest = pupilOfInterest(~isnan(pupilOfInterest(:,1)),:);
        pupilInAllCards{k} = [pupilInAllCards{k};pupilOfInterest];
        end
    end
    

%% plot out
meanVector = cell(length(pupilInAllCards),1);
countVector = cell(length(pupilInAllCards),1);
for i = 2:length(pupilInAllCards)

    for j = 1:max(pupilInAllCards{i}(:,3))+1
        indexBin = find(pupilInAllCards{i}(:,3)==j-1);
        
    meanVector{i} = [meanVector{i};mean(pupilInAllCards{i}(indexBin,1))];
    countVector{i} = [countVector{i};length(indexBin)];    
    end
end
%%
for i = 2:8
    meanVector{i} = meanVector{i} -meanVector{i}(1);
end
%%
for i = 2:8
plot([1:1:10],meanVector{i}(1:10))
hold on
end

legend('2','3','4','5','6','7','8')