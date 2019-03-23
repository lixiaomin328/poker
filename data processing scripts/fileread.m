function [dataStructure] = fileRead(filename)
dataPath = '../data';
if ~exist('DataMat')
    mkdir('DataMat')
end
dataTable = readtable([dataPath,'/',filename], 'ReadRowNames', true); %data into table form

%% cut out practice trials and extra columns, saving participant number

participantNumber = table2array(dataTable(1,10)); %hard coded bc of change in col. name

numPractice = 3; %number of practice trials
if height(dataTable) > numPractice
    dataTable = dataTable(((numPractice+1):end),:);
end

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

%% make into a struct

dataTable = dataTable(:, {'trials_thisN', 'P1card', 'P2card', 'player1ActionCheck_keys', 'player1ActionCheck_rt', ...
    'player2ActionCheck_keys', 'player2ActionCheck_rt'});

dataStructure = struct();
varNames = dataTable.Properties.VariableNames;

for i = 1:length(varNames)  
    dataStructure.(varNames{i}) = table2array(dataTable(:,i));
end
dataStructure.trials_thisN = dataStructure.trials_thisN -3;
if participantNumber< 10&&participantNumber>4
    dataStructure.player1ActionCheck_rt = dataStructure.player1ActionCheck_rt -3;
elseif participantNumber< 10&&participantNumber<4
    dataStructure.player1ActionCheck_rt = dataStructure.player1ActionCheck_rt -0.5;
end
%% write data to a structure saved as a .mat, file named participant #

name = cat(2, 'participant_', int2str(participantNumber));

save(['DataMat','/',name], 'dataStructure')

end

