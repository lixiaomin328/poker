function [vector] = handLoop(whatAction, whatClass, dataTable, vector)

for i = 1:length(whatAction)
    whichTrial = dataTable.trialIndex(whatAction(i), :);
    where = find(dataTable.trialIndex == whichTrial);
    vector(where) = whatClass;
end
