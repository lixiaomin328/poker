%% main function for estimation
%% load data first:
load('nObsPoker.mat')
load('modelSource.mat')
load('nObsPoker.mat')

%% Optimazion
%x = fmincon(@(x)modelDiff(x,proportionsBetP1,proportionsBetP2),[3.4,2.7,2,3,2,0.5,3,1,100],[],[],[],[],[0,0,0,0,0,0,0,0.5,100],[5,5,5,5,5,5,5,1,100]);%x = lambda,taus,tauh,miu
x =fmincon(@(x)modelDiff(x,proportionsBetP1,proportionsBetP2),[2,1,0.7,0],[],[],[],[],[0,1,0,0],[5,1,1,200]);%entropy tau/%
%x = fmincon(@(x)modelDiff(x,proportionsBetP1,proportionsBetP2),[1,0.3,20],[],[],[],[],[1,0,10],[5,1,100]);%x = lambda,taus,tauh,miu
%%
%modelDiff(x,proportionsBetP1,proportionsBetP2)
card = [2:8];%if squared
entroVec = [0 0.45 0.63 0.7 0.63 0.45 0];
tau = x(1)*ones(7,1)';
%tau = x(1)./(1+entroVec*x(2));% * [1.0150    0.9510    0.8858    0.9542    1.0239    1.1238    1.1066];
%tau2 = exp(x(1)*entroVec+x(2));%x(1)./[0.8301 1.1781 1.0767 1.1921 0.9454 0.8592 0.8524];
%tau = x(1:7);
%x(1)*card.^2+x(2)*card+x(3);
%x =  (xs+xh)./2; if doing matching, uncomment this line.
[betRatep1,~,~,p1,~] = texasCH(tau,x(end-1),x(end));
[~,betRatep2,~,~,p2] = texasCH(tau,x(end-1),x(end));

% plot comparison figure
stdP1 = sqrt(proportionsBetP1.*(1-proportionsBetP1)./nP1);
stdP2 = sqrt(proportionsBetP2.*(1-proportionsBetP2)./nP2);
figure
logLikelihood(betRatep1,proportionsBetP1,nP1)
subplot(2,1,1)
w = [2:1:8];
errorbar(w, proportionsBetP1,stdP1,'--','MarkerSize',10,...
    'MarkerEdgeColor','red','MarkerFaceColor','red')
hold on
plot(w,betRatep1)
legend('real population','predicted')
xlabel('cards')
ylabel('bet rate')
title('Player 1 model comparison')
hold off
subplot(2,1,2)
logLikelihood(betRatep2,proportionsBetP2,nP2)

errorbar(w, proportionsBetP2,stdP2,'--')
hold on
plot(w,betRatep2)
legend('real population','predicted')
xlabel('cards')
ylabel('bet rate')
title('Player 2 model comparison')
hold off
% %%
% all levels
% for i = 1:7
% plot([1:7],p1(:,i))
% hold on 
% end
% plot(betRatep1)
