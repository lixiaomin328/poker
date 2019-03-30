gazeFolder = 'processedGazeDataMat/';
gazeFile =dir([gazeFolder,'*.mat']);
conditions = [3;4];
pupilInAllConditions = cell(length(conditions),1);
for k = 1:length(conditions)
    pupilOfInterestAllPeople =[];
for i = 1:length(gazeFile)
        load([gazeFolder,filesContain.name])
        baseline = mean(data_et.pupilSize(~isnan(data_et.pupilSize)));
        stdPupil = std(data_et.pupilSize(~isnan(data_et.pupilSize)));
        %to add all the pupil entries for each trial
        pupilOfInterest = [pupilOfInterest;data_et.pupilSize(data_et.eventType==conditions(k))];
        pupilOfInterest(isnan(pupilOfInterest))=[];
        pupilOfInterest(pupilOfInterest>baseline+2*stdPupil)=[];
        pupilOfInterest(pupilOfInterest<baseline-2*stdPupil)=[];
        pupilOfInterest = pupilOfInterest./baseline;
        pupilOfInterestAllPeople = [pupilOfInterestAllPeople;pupilOfInterest];
end
pupilInAllConditions{k} = pupilOfInterestAllPeople;
end
       meanCardGaze=[];
        for m = 1:2
            meanCardGaze = [meanCardGaze;mean(pupilInAllConditions{m})];
        end
        plot(meanCardGaze)
        hold on

