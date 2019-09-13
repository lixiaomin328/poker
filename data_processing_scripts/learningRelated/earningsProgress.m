function earningsProgress(p1Earnings, p2Earnings)

dataTable = struct2table(dataStruct);

%% set up P1

p1Earnings = dataTable.p1Earnings;
p1Start = 0;
p1Cumulative = zeros(1, 1+length(p1Earnings));

for i = 1:length(p1Earnings)
    p1Cumulative(1,i+1) = p1Start + p1Earnings(i);
    p1Start = p1Start + p1Earnings(i);
end

p1EarningsCumulative = sum(p1Earnings);

%% set up p2

p2Earnings = dataTable.p2Earnings;
p2Start = 0;
p2Cumulative = zeros(1, 1+length(p2Earnings));

for i = 1:length(p2Earnings)
    p2Cumulative(1,i+1) = p2Start + p2Earnings(i);
    p2Start = p2Start + p2Earnings(i);
end

p2EarningsCumulative = sum(p2Earnings);


%% plot
periods = (1:(1+length(p1Earnings)));
limits = max(abs(p1EarningsCumulative), abs(p2EarningsCumulative)) + 5;
plot(periods, p1Cumulative)
hold on
plot(periods, p2Cumulative)
xlim([0 100])
ylim([-limits, limits])
legend('Player 1','Player 2')
title('Earnings Progression')

end
