function parcelTrials(filename)

load(['GazeDataMat/',filename], 'data_et'); %load only that variable

%% getting trial number to show

whereMsg = find(contains(data_et.message,'P1 prechoose'));  %#ok<NODEF>

%cut out extra columns and whatever happens before first trial starts
data_et = data_et(whereMsg(1):end, (cat(2, 1:16, 44:46))); 

% make structure (or array) where each element is [start, duration]
eventStarts= find(contains(data_et.message,'P1 prechoose')); 
eventStarts = [eventStarts; height(data_et)]';
durations = (([eventStarts, 0 ] - [0, eventStarts]));
durations = durations(2:end-1);
eventStarts = eventStarts(1:end-1);

startDurations = [eventStarts; durations];

struct.both = startDurations;

%apply array fun
filledOut = arrayfun(@(x) testfunc(struct.both), struct, 'UniformOutput', false);
filledOut = filledOut{1};


data_et.trialIndex = filledOut';


%% getting hand type to show (ex. fold, bet, check)

%give indices of where these tags are 
whereFold = find(contains(data_et.message,'fold result revealed')); 
whereBet = find(contains(data_et.message,'bet result revealed')); 
whereCheck = find(contains(data_et.message,'check result revealed')); 

%to be added to table as a column with 1, 2, or 3 depending on what
%happened in that trial
trialType = zeros(1, height(data_et));

%TRIALS ENDING WITH P2 FOLD CODED AS 2
trialType = handLoop(whereFold, 2, data_et, trialType);

%TRIALS ENDING IN P2 BETTING CODED AS 3
trialType = handLoop(whereBet, 3, data_et, trialType);

%TRIALS ENDING IN CHECK CODED AS 1
trialType = handLoop(whereCheck, 1, data_et, trialType);

%add to table
trialType = trialType';
data_et.trialType = trialType;

%delete timeout trials
whereTO = data_et.trialType == 0;
data_et(whereTO, :) = [];
%0 is code for time out 

%% getting 'what's happening' to show

eventType = zeros(1, height(data_et));

%use where see and where decide as endpoints for thinking time
whereP1See = find(contains(data_et.message,'P1 prechoose')); 
whereP1Decide = find(contains(data_et.message,'P1 choose time'));

whereP2See = find(contains(data_et.message,'P2 prechoose')); 
whereP2Decide = find(contains(data_et.message,'P2 choose timed')); 

%CODE 1 FOR WHEN p1 IS DECIDING
eventType = eventloop(whereP1See, whereP1Decide, 1, eventType);

%CODE 2 FOR WHEN p2 IS DECIDING
eventType = eventloop(whereP2See, whereP2Decide, 2, eventType);

%% checked-related debugging 

%coded as 6: when p2 sees p1 checked, but doesn't see result

whereP2informed = find(contains(data_et.message,'P1 checked'));
whereCheck = find(contains(data_et.message,'check result revealed'));
p1ChooseCheck = find((contains(data_et.message,'P1 choose time')) & (data_et.trialType == 1));

eventType = eventloop(whereP2informed, whereCheck, 6, eventType);


%'P1 choose time' to 'p1 checked'  TAG AS 7
eventType = eventloop(p1ChooseCheck, whereP2informed, 7, eventType);


%% coding for when outcomes revealed 
 
%redefine without TO for correct indexing
whereFold = find(contains(data_et.message,'fold result revealed')); 
whereBet = find(contains(data_et.message,'bet result revealed')); 
%defined above: 
%whereCheck = find(contains(data_et.message,'check result revealed'));

%CODE 3 for when BET REVEALED
eventType = outcomeloop(whereBet, 3, data_et, eventType);

%CODE 4 for when FOLD REVEALED
eventType = outcomeloop(whereFold, 4, data_et, eventType);

%CODE 5 for when CHECK REVEALED
eventType = outcomeloop(whereCheck, 5, data_et, eventType);

%% add to table
data_et.eventType = eventType';
toDelete = (isnan(data_et.posX)&strcmp(data_et.message,''));
data_et(toDelete,:) = [];
recordStatus = contains(data_et.message,'record_status_message'); 
data_et(recordStatus,:) = [];
if ~exist('processedGazeDataMat')
    mkdir('processedGazeDataMat')
end
save(['processedGazeDataMat','/',filename], 'data_et')