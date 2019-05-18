figure
logLikelihood(betRatep1,proportionsBetP1)
subplot(2,1,1)
plot([2:1:8],proportionsBetP1)
hold on
plot([2:1:8],betRatep1)
legend('real population','predicted')
xlabel('hands')
ylabel('bet rate')
title('p1 strategy and model prediction')
hold off
subplot(2,1,2)
logLikelihood(betRatep2,proportionsBetP2)
plot([2:1:8],x(1:7))
xlabel('hands')
ylabel('tau')
title('how tau distributed over the cards')
hold off