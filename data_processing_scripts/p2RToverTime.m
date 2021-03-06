dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat'] );
allEntries = repmat(table(),[length(dataFiles),1]);
fullStruct = struct;

howMany = 100 %length(dataStructure.P1card);
binSize = round(howMany/20);
binIndex = zeros(howMany/binSize, 1);
howManyChoices = zeros(20,1);

for i = 1:length(dataFiles)
    fileName = dataFiles(i).name;
    load([dataFolder,fileName]);
    
    [~,~,~,~,~,~, ~, p2AverageRT] = getIndividualRTandChoice(i);
    
    start = 1;
    
    for j = 1:binSize:howMany  %approx 1:5:100
        segment = ((dataStructure.player2ActionCheck_rt(j:(j+binSize-1))));
        whereNaN = find(isnan(segment));
        if ~isempty(whereNaN)
            segment(whereNaN) = [];
        end
        howManyChoices(start) = length(segment) + howManyChoices(start);
        binIndex(start,1) = binIndex(start,1) + sum(segment)/p2AverageRT;
        if start ~= 20
            start = start+1;
        end
    end
    
end


binIndex = binIndex./howManyChoices;

bar(binIndex)
title('Normalized RT over experiment for p2')
xlabel('bin number (each bin = 5 trials)')
ylabel('RT in seconds')