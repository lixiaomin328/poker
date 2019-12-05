function  [p1Earnings,p2Earnings]=twoStrategyCompete(propP1,propP2)
betSize = 3;
allPossiblePayoffs = [];
for p1Card = 1:7
    for p2Card = 1:7
        if p2Card == p1Card
            continue
        end
        comResult = sign(p1Card - p2Card);
        p1Payoff = (1-propP1(p1Card))*comResult+propP1(p1Card)*(1-propP2(p2Card))+propP1(p1Card)*propP2(p2Card)*betSize*comResult;
        allPossiblePayoffs = [allPossiblePayoffs ; p1Payoff];
    end
end
p1Earnings = mean(allPossiblePayoffs);
p2Earnings = -p1Earnings;