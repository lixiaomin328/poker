dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat'] );
allEntries = repmat(table(),[length(dataFiles),1]);
fullStruct = struct;

howMany = 100 %length(dataStructure.P1card);
binSize = round(howMany/20);
binIndex = zeros(howMany/binSize, 1);
opportunityIndex = zeros(howMany/binSize, 1);

for i = 1:length(dataFiles)
    fileName = dataFiles(i).name;
    load([dataFolder,fileName]);
    
    start = 1;
    
    for j = 1:binSize:howMany  %approx 1:5:100
        segment = ((dataStructure.player1ActionCheck_keys(j:(j+binSize-1))));
        whereNaN = find(isnan(segment));
        if ~isempty(whereNaN)
            segment(whereNaN) = [];
        end
        noChoice = sum(binTrials == -1);
        betProportion = sum(segment == 1)/ (length(segment) - noChoice);
        binIndex(start) = binIndex(start) + betProportion;
        
        if start ~= 20
            start = start+1;
        end
    end
    
end

binIndex = binIndex/6;

bar(binIndex)
title('call rate over experiment for p2')
xlabel('bin number (each bin = 5 trials)')
ylabel('number of call decisions seconds')