%fixation analysis
%%With different card
gazeFolder = 'processedGazeDataMat/';
pupilInAllCards= cell(8,1);
screenSize =[1024,1280];
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
        for j = 1:length(allEntries(i).trialNumbers)
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
addpath('/Users/lixiaomin/Documents/GitHub/poker/fixation-visualization');
img = imread('../poker screenshots/screen1.PNG');
img = imresize(img,screenSize);

%%
figure()
numberOfTomFixation = [];
for j = 2:8
fixationDecenter = pupilInAllCards{j}(:,1:2);
fixationDecenter = fixationDecenter(fixationDecenter(:,1)>900&fixationDecenter(:,2)<400,:);
%fixationDecenter = fixationDecenter(fixationDecenter(:,2)<300|fixationDecenter(:,2)>600,:);
numberOfTomFixation = [numberOfTomFixation;length(fixationDecenter)];
subplot(2,4,j)
plotFixationHeatmap(img, fixationDecenter);
title(['card',' ',num2str(j)]);
hold on
end