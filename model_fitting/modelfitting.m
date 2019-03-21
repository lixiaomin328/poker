%% main function for estimation
%% load data first: hidehis is the data for hiding, hists is the data for seekers

%%seeking.
%%saliencyResampled: saliency distribution
%% Optimazion
x = fmincon(@(x)modelDiff(x,proportionsBetP1,proportionsBetP2),1.5);%x = lambda,taus,tauh,miu

%x = (xs+xh)./2; if doing matching, uncomment this line.
[betRatep1,betRatep2,numberLevel,p1,p2] = texasCH(x);
% plot comparison figure
figure
logLikelihood(betRatep1,proportionsBetP1)
subplot(2,1,1)
plot([2:1:8],proportionsBetP1)
hold on
plot([2:1:8],betRatep1)
legend('real population','predicted')
xlabel('hands')
ylabel('bet rate')
hold off
subplot(2,1,2)
logLikelihood(betRatep2,proportionsBetP2)
plot([2:1:8],proportionsBetP2)
hold on
plot([2:1:8],betRatep2)
legend('real population','predicted')
xlabel('hands')
ylabel('bet rate')
hold off

