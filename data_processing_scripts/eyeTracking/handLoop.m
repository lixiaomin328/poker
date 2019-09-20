function vector = handLoop(whatAction, whatClass, dataTable, vector)

for i = 1:length(whatAction)
    whichTrial = dataTable.trialIndex(whatAction(i), :);
    vector((dataTable.trialIndex == whichTrial)) = whatClass;
end
