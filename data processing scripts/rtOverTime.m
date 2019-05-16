dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat'] );
allEntries = repmat(table(),[length(dataFiles),1]);
fullStruct = struct;

howMany = 100 %length(dataStructure.P1card);
binSize = round(howMany/20);
binIndex = zeros(howMany/binSize, 1);

for i = 1:length(dataFiles)
    fileName = dataFiles(i).name;
    load([dataFolder,fileName]);
    
    [~,~,~,~,~,~, p1AverageRT, ~] = getIndividualRTandChoice(i);
    
    start = 1;
    
    for j = 1:binSize:howMany  %approx 1:5:100
        segment = ((dataStructure.player1ActionCheck_rt(j:(j+binSize-1))));
        whereNaN = find(isnan(segment));
        if ~isempty(whereNaN)
            segment(whereNaN) = [];
        end
        binIndex(start) = binIndex(start) + sum(segment)/p1AverageRT;
        if start ~= 20
            start = start+1;
        end
    end
end


binIndex = binIndex/30;

bar(binIndex)
title('Normalized RT over experiment for p1')
xlabel('bin number (each bin = 5 trials)')
ylabel('RT in seconds')