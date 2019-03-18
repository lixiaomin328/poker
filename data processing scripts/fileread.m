function [dataStructure] = fileread(filename)
dataPath = '../data';
if ~exist('DataMat')
    mkdir('DataMat')
end
dataTable = readtable([dataPath,'/',filename], 'ReadRowNames', true); %data into table form

%% cut out practice trials, saving participant number

participantNumber = table2array(dataTable(1, 10));
dataTable = dataTable((4:end),:);

%% set up a column with who has the higher card, 1=(p1>p2), 0=(p2>p1)
p1Card = dataTable.P1card;
p2Card = dataTable.P2card;
whoHigher = double(p1Card > p2Card);

%% make p1Move numerical-- bet=1, check=0, noAction = -1

p1Move = array2table(dataTable.player1ActionCheck_keys);
p1Move = char(p1Move{:,:});
p1Move = p1Move(:,1);
p1Move = (p1Move == 'b') + (-1)*(p1Move == 'N');
dataTable.player1ActionCheck_keys = p1Move;

%% make p2Move numerical--   call = 1, fold = 0, noAction = -1
p2Move = array2table(dataTable.player2ActionCheck_keys);
p2Move = char(p2Move{:,:});
p2Move = p2Move(:,1);
p2Move = (p2Move == 'c') + (-1)*(p2Move == 'N');
dataTable.player2ActionCheck_keys = p2Move;

%% remove unneeded columns


%% create move profiles

moveSum = dataTable.player1ActionCheck_keys + dataTable.player2ActionCheck_keys;
betCall = ((p1Move == 1) & (p2Move == 1)); %p1 = 1, p2 = 1
betFold = ((p1Move == 1) & (p2Move == 0));
check = ((p1Move == 0) & (p2Move == -1));
noActionBoth = (moveSum == -2);

%% tally p1 earnings

p1WinBetCall = (3*((betCall == 1) & (whoHigher == 1))); %3pt per winning a betCall,
p1WinCheck = ((whoHigher == 1) & (check == 1)); %1pt for winning check
p1WinNoMove = 2*((p1Move == 1) & (p2Move == -1));
p1Wins = p1WinBetCall + betFold + p1WinCheck + p1WinNoMove;

p1LoseBetCall = (-3)*((betCall == 1) & (whoHigher == 0));
p1LoseCheck = (-1)*((whoHigher == 0) & (check == 1));
p1NoMove = (-2)*(noActionBoth == 1);
p1Losses =  p1LoseBetCall + p1LoseCheck + p1NoMove;

p1Earnings = p1Wins + p1Losses;

dataTable.p1Earnings = (p1Earnings);

%% tally p2 earnings

p2WinBetCall = (3*((betCall == 1) & (whoHigher == 0))); %3pt per winning a betCall,
p2WinCheck = ((whoHigher == 0) & (check == 1)); %1pt for winning check
p2WinNoMove = (2)*(p1Move == -1);
p2Wins = p2WinBetCall + p2WinCheck + p2WinNoMove;

p2LoseBetCall = (-3)*((betCall == 1) & (whoHigher == 1)); %-3pt per lose betcall
p2LoseCheck = (-1)*((whoHigher == 1) & (check == 1)); %-1pt per lose check
p2NoMove = (-2)*((p1Move == 1) & (p2Move == -1));
p2Losses =  p2LoseBetCall + p2LoseCheck + (-1)*(betFold) + p2NoMove;

p2Earnings = p2Wins + p2Losses;

dataTable.p2Earnings = (p2Earnings);

%% make into a struct

dataStructure = struct();
varNames = dataTable.Properties.VariableNames;

for i = 1:length(varNames)  
    dataStructure.(varNames{i}) = table2array(dataTable(:,i));
end
dataStructure.trial_thisN = dataStructure.trials_thisN -3;
%% write data to a structure saved as a .mat, file named participant #

name = cat(2, 'participant_', int2str(participantNumber));

save(['DataMat','/',name], 'dataStructure')

end

