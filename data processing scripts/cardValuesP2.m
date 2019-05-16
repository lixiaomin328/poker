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
    
    start = 1;

    
    for j = 1:binSize:howMany  %approx 1:5:100
        segment = ((dataStructure.P2card(j:(j+binSize-1))));
        
        binIndex(start,1) = binIndex(start,1) + sum(segment)
        if start ~= 20
            start = start+1;
        end
    end
    
end
binIndex = binIndex/30;
bar(binIndex)
title('card values over experiment for p2')
xlabel('bin number (each bin = 5 trials)')
ylabel('average card value per bin')