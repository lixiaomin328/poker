dataFolder = 'DataMat/';
dataFiles = dir([dataFolder,'*.mat'] );
allEntries = repmat(table(),[length(dataFiles),1]);
fullStruct = struct;

howMany = length(dataStructure.P1card);
binSize = round(howMany/20);
binIndex = zeros(howMany/binSize, 1);

for i = 1:length(dataFiles)
    fileName = dataFiles(i).name;
    load([dataFolder,fileName]);

    start = 1;
    
    for j = 1:binSize:howMany  %approx 1:5:100
        binIndex(start) = sum(dataStructure.player1ActionCheck_rt(j:(j+binSize-1)));
        if start ~= 20
            start = start+1;
        end
    end
    
end

bar(binIndex)