%% equilibrium for 4 cards
BetSize = 2;
equStrategies = [];
strategyOne = [0,0,0,1,1,0,0,1];
flexiblePositions = [1,2,3,6,7];
for i = 1:2^length(flexiblePositions)
    state = dec2bin(2,5);
    for j = 1:5
    strategyOne(flexiblePositions(j)) = str2num(state(j));
    end
    p2Stra= strategyOne(5:8);
    p1Stra = strategyOne(1:4);
    strategyOne(strategyOne==0) = -1;
    p11 = (sign(sum(p2Stra(2:end))/sum(p2Stra)*(-1)*BetSize+1-sum(p2Stra(2:end))/sum(p2Stra)+1)*strategyOne(1));
    p12 = (sign(sum(p2Stra(3:end))/sum(p2Stra)*(-1)*BetSize+1-sum(p2Stra(3:end))/sum(p2Stra)+1/3)*strategyOne(2));
    p13 = (sign(sum(p2Stra(end))/sum(p2Stra)*(-1)*BetSize+1-sum(p2Stra(end))/sum(p2Stra)-1/3)*strategyOne(3));
end