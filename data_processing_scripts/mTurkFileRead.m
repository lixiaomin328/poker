function mTurkFileRead(filename)
%Reads in behavioral data from a batch of mTurk
dataPath = '../mTurk_data';

if ~exist('mTurkDataMat')
    mkdir('mTurkDataMat')
end

dataTable = readtable([dataPath,'/',filename], 'ReadRowNames', false); %data into table form

%% how to classify if it's a p1 or p2 file
%WARNING: requires consistent csvfile naming conventionm, so all downloaded
%files from mTurk should say 'p1' or 'p2'

%numPractice = 0; %number of practice trials

type = strfind(filename, 'p1');
if isempty(type)
    type = 2; %type 2 means it's a p2 file
    otherType = 1;
else
    type = 1; %type 1 means it's a p1 file
    otherType = 2;
end


%% COLUMN ORDER OF DOWNLOADED mTURK (as of 9/2019)

% 1: index (1, 2, 3, ..., n) (double)
% 2: amazon ID (string)
% 3: card value (double)
% 4: action (string)
% 5: RT (double)
% 6: useless \N

%% Temporarily name columns

dataTable.Properties.VariableNames = {'Index', 'AmazonID', 'Card', 'Action', 'RT', 'extra'};

%% add extra columns for other player's data

howTall = height(dataTable);

%get rid of extra column
dataTable(:,6) = [];


%% METHOD 1 of adding new fields--preserves order, but requires 'addvars'

% if type == 1
%     Card2 = cell(howTall,1);
%     dataTable = addvars(dataTable, Card2,'After','Card');
%     Action2 = cell(howTall,1);
%     dataTable = addvars(dataTable, Action2,'After','Action');
%     RT2 = cell(howTall,1);
%     dataTable = addvars(dataTable, RT2,'After','RT');
% end
% 
% if type == 2
%     Card1 = cell(howTall,1);
%     dataTable = addvars(dataTable, Card1,'Before','Card');
%     Action1 = cell(howTall,1);
%     dataTable = addvars(dataTable, Action1,'Before','Action');
%     RT1 = cell(howTall,1);
%     dataTable = addvars(dataTable, RT1,'Before','RT');
% end

%% Get rid of seed data 

%null = seed data
whereNull = find(ismember(dataTable{:,2}, 'null'));

dataTable(whereNull, :) = [];

%% NEW COLUMN ORDER if use addvars above

% 1: index (1, 2, 3, ..., n) (double)
% 2: amazon ID (string)
% 3: card value (double)
% 4: card value
% 5: action (string)
% 6: action
% 7: RT (double)
% 8: RT

%% Code moves numerically rather than with words

%address time out trial if used addvars method
% if type == 1
%     whereTO = find(ismember(dataTable{:,7}, 'timeout'));
%     dataTable{whereTO, 7} = NaN;
% end
% if type == 2
%     whereTO = find(ismember(dataTable{:,8}, 'timeout'));
%     dataTable{whereTO, 8} = NaN;
% end

%address TO if you dont' use addvars
 whereTO = find(ismember(dataTable{:,4}, 'timeout'));
 dataTable{whereTO, 5} = NaN;


% make p1Move numerical-- bet=1, check=0, noAction = -1
if type == 1
    p1Move = array2table(dataTable.Action);
    p1Move = char(p1Move{:,:});
    p1Move = p1Move(:,1);
    p1Move = (p1Move == 'b') + (-1)*(p1Move == 't');
    dataTable.Action = p1Move;
end

% make p2Move numerical--   call = 1, fold = 0, noAction = -1
if type == 2
    p2Move = array2table(dataTable.Action);
    p2Move = char(p2Move{:,:});
    p2Move = p2Move(:,2);
    p2Move = (p2Move == 'ca') + (-1)*((p2Move == 'ch') || (p2Move == 'ti'));
    dataTable.Action = p2Move;
end




%% slice and dice by subject

%take out any Amazon ID with "test"
%NB: for our future testing, we should always use a fake amazonID that
%includes the word "test" so it is automatically removed by this.
%whereTest = (contains(dataTable{:,2},'test'));
%dataTable(whereTest==1, :) = [];

%List of which amazon IDs do we have (no repeats)
whichIDs = unique(dataTable{:,2});

%creating the dataStructure and file
for i = 1:length(whichIDs)
    
    %find the first unique ID, find where it is, and save the name for the
    %file right away
    wherePerson = ismember(dataTable{:,2}, char(whichIDs(i)));
    wherePerson = find(wherePerson == 1);
    name = cat(2, 'participant_', char(whichIDs(i)));
    
    %remove if there's too few trials of this one person
    if length(wherePerson) < 10
        continue;
    end
    
    %set up the data structure
    dataTable = dataTable(:, {'Index', 'AmazonID', 'Card', 'Action', 'RT'});
    dataStructure = struct();
    varNames = dataTable.Properties.VariableNames;
    
    %this fills the table looking only at rows where we have the same
    %AmazonID
    for j = 1:length(varNames)
        dataStructure.(varNames{j}) = table2array(dataTable(wherePerson,j));
    end
    
    %adjust the unit of the RT
    dataStructure.RT = dataStructure.RT/1000;
    
    
    %rename columns to match old ones, making it match if we're using P1 or
    %P2
    cardField = sprintf('%s%d%s', 'P', type, 'Card');
%     otherCard = sprintf('%s%d%s', 'P', otherType, 'Card')
    actionField = sprintf('%s%d%s', 'player', type, 'ActionCheck_keys');
%     otherAction = sprintf('%s%d%s', 'player', otherType, 'ActionCheck_keys');
    rtField = sprintf('%s%d%s', 'player', type, 'ActionCheck_rt');
%     otherRT = sprintf('%s%d%s', 'player', otherType, 'ActionCheck_rt');
    dataStructure = cell2struct(struct2cell(dataStructure), {'trials_thisN', ...
        'AmazonID', cardField, actionField, rtField});
    
    %     %adjusting RTs--commented out from behavioralFileRead.m because I
    %     think it's no longer necessary, but left in case needed later...
    
    %     dataStructure.trials_thisN = dataStructure.trials_thisN -numPractice;
    %     if participantNumber<10&&participantNumber>4
    %         dataStructure.player1ActionCheck_rt(dataStructure.player1ActionCheck_rt>3) = dataStructure.player1ActionCheck_rt(dataStructure.player1ActionCheck_rt>3) -3;
    %     elseif participantNumber<4
    %         dataStructure.player1ActionCheck_rt( dataStructure.player1ActionCheck_rt>0.5) = dataStructure.player1ActionCheck_rt( dataStructure.player1ActionCheck_rt>0.5) -0.5;
    %     else
    %
    %     end
    
    %delete amazon ID column-- commented for checking
    dataStructure = rmfield(dataStructure, 'AmazonID');
    
    %add extra 
    
    %add normalized RT
    if type == 1
        p1RtForMean = dataStructure.player1ActionCheck_rt(2:end);
        dataStructure.p1normalizedRt = dataStructure.player1ActionCheck_rt./mean(p1RtForMean(~isnan(p1RtForMean)));
        dataStructure.p2normalizedRt = [];
    end
    
    if type == 2
        p2RtForMean = dataStructure.player2ActionCheck_rt(2:end);
        dataStructure.p2normalizedRt = dataStructure.player2ActionCheck_rt./mean(p2RtForMean(~isnan(p2RtForMean)));
        dataStructure.p2normalizedRt = [];
    end
    
    %Add extra fields to the table so that it matches lab data
    if type == 1
        dataStructure.P2card = [];
        dataStructure.player2ActionCheck_keys = [];
        dataStructure.player2ActionCheck_rt = [];
    end
    
    if type ==2
        dataStructure.P1card = [];
        dataStructure.player1ActionCheck_keys = [];
        dataStructure.player1ActionCheck_rt = [];
    end
    
    %FINAL STEP TO SAVE
    save(['mTurkDataMat','/',name], 'dataStructure')
    
    
end


end