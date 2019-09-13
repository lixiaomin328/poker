function psychoMetricCurvePlot(px)
[rtPerPersonPerCardp1,rtPerPersonPerCardp2] = psychoMetricCurveInput();
if px ==1
    dataSource =rtPerPersonPerCardp1;
elseif px ==2 
    dataSource =rtPerPersonPerCardp2;
else 
    dataSource =[rtPerPersonPerCardp1;rtPerPersonPerCardp2];
end
[rtPerPersonPerCardp1,rtPerPersonPerCardp2] = psychoMetricCurveInput();
%% Scatter the result ALL
subplot(2,1,1)
scatter(dataSource(:,1),dataSource(:,2))
xlabel('probability to bet')
ylabel('Mean Rt')
%%Mean the result
[~,idx] = sort(dataSource(:,1));
sortedrtPerPersonPerCard= dataSource(idx,:);
binValues = hist(sortedrtPerPersonPerCard(:,1));
starting = [1,cumsum(binValues)+1];
meanRtProb = [];
for bin = 1:length(binValues)   
    meanRtProb = [meanRtProb;mean(sortedrtPerPersonPerCard(starting(bin):starting(bin)+binValues(bin)-1,:),1)];
end
subplot(2,1,2)
scatter(meanRtProb(:,1),meanRtProb(:,2))
xlabel('probability to bet')
ylabel('Mean Rt')

