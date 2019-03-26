%function [] = parcelTrials(filename)
%dataTable = load(filename, 'data_et'); %load only that variable

filename = '03_._edf.mat';
load(['GazeDataMat/',filename], 'data_et'); %load only that variable

%% getting trial number to show

%DEBUG
dataTable = data_et;

whereMsg = find(contains(dataTable.message,'record_status_message')); 
eventStarts = whereMsg(1:2:end, :); %every other line is the start command

%cut out extra columns and whatever happens before first trial starts
dataTable = dataTable(eventStarts(1):end, (cat(2, 1:16, 44:46))); 

%to be added as a column that says TRIAL 1, 1, 1, 2, etc
trialIndex = zeros(1, height(dataTable)); 

startPoint = 1;

for i = 1:(length(eventStarts)) %for i = 1:103
    %case: you're at the last event start, so the event will last to end of
    %the data set.
    if (i == length(eventStarts))
        trialIndex(1, (startPoint:end)) = i;
    end
        %case: not at last event
    if (i < length(eventStarts))
        %how many recordings constitute this one trial
        howManyRecordings = height(dataTable(eventStarts(i):eventStarts(i+1), :));
        %i is trial number
        trialIndex(1, (startPoint:(startPoint + howManyRecordings-1))) = i;
        %from where to start the next trial
        startPoint = startPoint + (howManyRecordings-1);
    end

end

%add to table

dataTable.trialNumber = (trialIndex');

%% getting hand type to show (ex. fold, bet, check)

%give indices of where these tags are 
whereFold = find(contains(dataTable.message,'fold result revealed')); 
whereBet = find(contains(dataTable.message,'bet result revealed')); 
whereCheck = find(contains(dataTable.message,'check result revealed')); 

%to be added to table as a column with 1, 2, or 3 depending on what
%happened in that trial
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

%add to table
trialType = trialType';
dataTable.trialType = trialType;

%events that are still coded as 0 = time out? no tk timeout message

%% getting 'what's happening' to show

eventType = zeros(1, height(dataTable));

%temporarily cut out time-out trials out of table
notTimeOut = find(dataTable.trialType ~= 0);
dataTableNoTimeOut = dataTable(notTimeOut, :);

%problem: gives indices that don't correspond
whereP1See = find(contains(dataTableNoTimeOut.message,'P1 prechoose')); 
whereP1Decide = find(contains(dataTableNoTimeOut.message,'P1 choose time'));

whereP2See = find(contains(dataTableNoTimeOut.message,'P2 prechoose')); 
whereP2Decide = find(contains(dataTableNoTimeOut.message,'P2 choose timed')); 

%CODE 1 FOR WHEN p1 IS DECIDING
for i = 1:length(whereP1See) 
    %find index for where P1 sees card
    timestampS = dataTableNoTimeOut.time(whereP1See(i));
    whereInTableS = find(dataTable.time == timestampS);
    %find index for where P1 decides
    timestampD = dataTableNoTimeOut.time(whereP1Decide(i));
    whereInTableD = find(dataTable.time == timestampD);
    %code all those rows as P1 thinking
    eventType(1, whereInTableS:(whereInTableD - 1)) = 1;
    
end

%CODE 2 FOR WHEN p2 IS DECIDING
for i = 1:length(whereP2See) 
    %find index for where P2 sees card
    timestampS = dataTableNoTimeOut.time(whereP2See(i));
    whereInTableS = find(dataTable.time == timestampS);
    %find index for where P2 decides
    timestampD = dataTableNoTimeOut.time(whereP2Decide(i));
    whereInTableD = find(dataTable.time == timestampD);
    %code all those rows as P2 thinking
    eventType(1, whereInTableS:(whereInTableD - 1)) = 2;
end

%% coding for when outcomes revealed 
 
%CODE 3 for when BET REVEALED

for i = 1:length(whereBet) %number of times where bets have been revealed
   %gives index in relation to the whereBet start point, so adjust in next
   %line
    whereNextMsg = find(contains(dataTable.message((whereBet(i)):(height(dataTable))),'record_status_message')); %gives index
    whereNextMsg = whereNextMsg + whereBet(i);
    
    if isempty(whereNextMsg) %if the last trial is of this type
        whereNextMsg = height(dataTable); %next message is end of exp
        eventType(1, whereBet(i):end) = 3; 
    else
        whereNextMsg = whereNextMsg(1, 1);
        eventType(1, whereBet(i):(whereNextMsg - 1)) = 3;
    end
end
    

%CODE 4 for when FOLD REVEALED
%logic same as above

for j = 1:length(whereFold)
    whereNextMsg = find(contains(dataTable.message(whereFold(j):end),'record_status_message')); 
        whereNextMsg = whereNextMsg + whereFold(j);

    if isempty(whereNextMsg) %#ok<ISMT> %if the last trial is of this type
        whereNextMsg = height(dataTable); %next message is end of exp
        eventType(1, whereFold(j):end) = 3; %is there an end tk msg
    else %#ok<ISMT>
        whereNextMsg = whereNextMsg(1, 1);
        eventType(1, whereFold(j):(whereNextMsg - 1)) = 4;
    end
end

%CODE 5 for when CHECK REVEALED
%logic same as above
for k = 1:length(whereCheck)
    whereNextMsg = find(contains(dataTable.message(whereCheck(k):end),'record_status_message')); 
    whereNextMsg = whereNextMsg + whereCheck(k);

    if isempty(whereNextMsg) %if the last trial is of this type
        whereNextMsg = height(dataTable); %next message is end of exp
        eventType(1, whereCheck(k):end) = 3; %is there an end tk msg
    else
        whereNextMsg = whereNextMsg(1, 1);
        eventType(1, whereCheck(k):(whereNextMsg - 1)) = 5;
    end
end

%add to table
dataTable.eventType = eventType';