%%%Plot individual wise strategy curve
dataFolder = 'DataMat/';

dataFiles = dir([dataFolder,'*.mat']);
w = 2:1:8;
for subId = 1:16
    fileName = [dataFolder,'participant_',num2str(subId),'.mat'];
if~exist(fileName)
    continue;
end
[proportionsBetP1,proportionsBetP2] = individualStrategy(subId);
%% plot

plot(w, proportionsBetP2)
hold on 

%plot(w, proportionsBetP2)


%end
end
xlabel('Card Value')
ylabel('Bet Rate per Card')
title('Bet Rate each person')
