dataFolder = 'dataMat/';
dataFiles = dir([dataFolder,'*.mat']);
w = 2:1:8;
for i = 1:length(dataFiles)
[proportionsBetP1,proportionsBetP2] = individualStrategy(i);
%% plot

plot(w, proportionsBetP2)
hold on 

%plot(w, proportionsBetP2)


%end
end
xlabel('Card Value')
ylabel('Bet Rate per Card')
title('Bet Rate p2 each person')