function [] = parcelTrialsPartial(filename)

dataTable = load(filename, 'data_et'); %load only that variable

%% getting trial number to show

whereMsg = find(contains(dataTable.message,'record_status_message')); 
eventStarts = whereMsg(1:2:end, :); %every other line is the start command

%cut out extra columns and whatever happens before first trial starts
dataTable = dataTable(eventStarts(1):end, (cat(2, 1:16, 44:46))); 

%to be added as a column that says TRIAL 1, 1, 1, 2, etc
trialIndex = zeros(1, height(dataTable)); 

startPoint = 1;

for i = 1:(length(eventStarts)) %for i = 1:103
    if (i == length(eventStarts))
        %howManyRecordings = height(dataTable(eventStarts(i):end, :));
        trialIndex(1, (startPoint:end)) = i;
    end
    if (i < length(eventStarts))
        trialNumber = i;
        howManyRecordings = height(dataTable(eventStarts(i):eventStarts(i+1), :));
        trialIndex(1, (startPoint:(startPoint + howManyRecordings-1))) = trialNumber;
        startPoint = startPoint + (howManyRecordings-1);
    end

end

trialIndex = trialIndex';
dataTable.trialNumber = (trialIndex);

%% getting hand type to show (ex. fold, bet, check)

%give indices of where these tags are 
whereFold = find(contains(dataTable.message,'fold result revealed')); 
whereBet = find(contains(dataTable.message,'bet result revealed')); 
whereCheck = find(contains(dataTable.message,'check result revealed')); 

trialType = zeros(1, height(dataTable));

for i = 1:length(whereFold) %TRIALS ENDING WITH P2 FOLD CODED AS 2
    whichTrialF = dataTable.trialNumber(whereFold(i), :); 
    where = find(dataTable.trialNumber == whichTrialF);
    trialType(where) = 2;
end

for i = 1:length(whereBet) %TRIALS ENDING IN P2 BETTING CODED AS 3
    whichTrialB = dataTable.trialNumber(whereBet(i), :); 
    where = find(dataTable.trialNumber == whichTrialB);
    trialType(where) = 3;
end

for i = 1:length(whereCheck) %TRIALS ENDING IN CHECK CODED AS 1
    whichTrialC = dataTable.trialNumber(whereCheck(i), :); 
    where = find(dataTable.trialNumber == whichTrialC);
    trialType(where) = 1;
end

trialType = trialType';
dataTable.trialType = trialType;

%events that are still coded as 0 = time out? no tk timeout message

%% getting 'what's happening' to show

eventType = zeros(1, height(dataTable));

notTO = find(dataTable.trialType ~= 0);
dataTableNoTimeOut = dataTable(notTO, :);

%problem: gives indices that don't correspond
whereP1See = find(contains(dataTableNoTimeOut.message,'P1 prechoose')); 
whereP1Decide = find(contains(dataTableNoTimeOut.message,'P1 choose time'));

whereP2See = find(contains(dataTableNoTimeOut.message,'P2 prechoose')); 
whereP2Decide = find(contains(dataTableNoTimeOut.message,'P2 choose timed')); 

%CODE 1 FOR WHEN p1 IS DECIDING
for i = 1:length(whereP1See) 
    timestampS = dataTableNoTimeOut.time(whereP1See(i));
    whereInTableS = find(dataTable.time == timestampS);
    
    timestampD = dataTableNoTimeOut.time(whereP1Decide(i));
    whereInTableD = find(dataTable.time == timestampD);
    
    eventType(1, whereInTableS:(whereInTableD - 1)) = 1;
    
end

%CODE 2 FOR WHEN p2 IS DECIDING
for i = 1:length(whereP2See) 
    timestampS = dataTableNoTimeOut.time(whereP2See(i));
    whereInTableS = find(dataTable.time == timestampS);
    
    timestampD = dataTableNoTimeOut.time(whereP2Decide(i));
    whereInTableD = find(dataTable.time == timestampD);
    
    eventType(1, whereInTableS:(whereInTableD - 1)) = 2;
end