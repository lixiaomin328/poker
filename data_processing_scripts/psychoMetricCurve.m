dataFolder = 'dataMat/';
rtPerPersonPerCardp1 = [];
rtPerPersonPerCardp2 = [];
for subId = 3:15
    fileName = [dataFolder,'participant_',num2str(subId),'.mat'];
    if ~exist(fileName)
        continue;
    end   
[proportionsBetP1,proportionsBetP2,p1RtperRate,p2RtperRate] = perCardPersonBettingRate(subId); 
rtPerPersonPerCardp1 = [rtPerPersonPerCardp1;proportionsBetP1',p1RtperRate'];
rtPerPersonPerCardp2 = [rtPerPersonPerCardp2;proportionsBetP2',p2RtperRate'];
end
%Scatter the result
scatter(rtPerPersonPerCardp1(:,1),rtPerPersonPerCardp1(:,2))
xlabel('probability to bet')
ylabel('Mean Rt')
