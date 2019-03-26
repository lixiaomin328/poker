%plot a particular trial
function plotAtrialPupil(trialID,dataTable)
whereMsg =find((~strcmp(dataTable.message,'')&dataTable.trialNumber==trialID));
hold off
trial =[min(find(dataTable.trialNumber==trialID)):min(find(dataTable.trialNumber==trialID))+length(dataTable.pupilSize(dataTable.trialNumber==trialID))-1];
plot(trial,dataTable.pupilSize(dataTable.trialNumber==trialID))
hold on 
for i = 1:length(whereMsg)
    msg = dataTable.message(whereMsg(i));
vline(whereMsg(i),'r',msg)
end
end
