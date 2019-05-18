%% main function for estimation
%% load data first: hidehis is the data for hiding, hists is the data for seekers

%%seeking.
%%saliencyResampled: saliency distribution
%% Optimazion
x = fmincon(@(x)modelDiff(x,proportionsBetP1,proportionsBetP2),[2,3,3,3,2,0,0,0.7,100],[],[],[],[],[0,0,0,0,0,0,0,0.5,10],[5,5,5,5,5,5,5,1,100]);%x = lambda,taus,tauh,miu
%x = fmincon(@(x)modelDiff(x,proportionsBetP1,proportionsBetP2),[1,0.3,20],[],[],[],[],[1,0,10],[5,1,100]);%x = lambda,taus,tauh,miu
%%
%modelDiff(x,proportionsBetP1,proportionsBetP2)

%x = (xs+xh)./2; if doing matching, uncomment this line.
[betRatep1,betRatep2,numberLevel,p1,p2] = texasCH(x(1:7),x(end-1),x(end));
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
% %%
% all levels
% for i = 1:7
% plot([1:7],p1(:,i))
% hold on 
% end
% plot(betRatep1)
