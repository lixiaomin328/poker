%% solve a QRE
%x: equilibrium probability for hider and seeker. x(1:20) is seeker,
%x(21:40) is hider's
load('nObsPoker.mat')
load('modelSource.mat')
x =fmincon(@(x)modelDiffQRE(x,proportionsBetP1,proportionsBetP2),50,[],[],[],[],0,100);%entropy tau/%
[betRatep1,betRatep2]=QREtexas(x);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot comparison figure

stdP1 = sqrt(proportionsBetP1.*(1-proportionsBetP1)./nP1);
stdP2 = sqrt(proportionsBetP2.*(1-proportionsBetP2)./nP2);
figure
subplot(2,1,1)
w = [2:1:8];
errorbar(w, proportionsBetP1,stdP1,'--','MarkerSize',10,...
    'MarkerEdgeColor','red','MarkerFaceColor','red')
hold on
plot(w,betRatep1)
legend('real population','predicted')
xlabel('cards')
ylabel('bet rate')
title('Player 1 model comparison:quantal response equilibrium')
hold off
subplot(2,1,2)
logLikelihood(betRatep2,proportionsBetP2,nP2)
logLikelihood(betRatep1,proportionsBetP1,nP1)

errorbar(w, proportionsBetP2,stdP2,'--')
hold on
plot(w,betRatep2)
legend('real population','predicted')
xlabel('cards')
ylabel('bet rate')
title('Player 2 model comparison')
hold off
function [betRatep1,betRatep2]=QREtexas(lambda)
%QRE parameter, tune this one to see difference
payoffparams = [1.5,1,1];
numberOfCards = 7;
x0 = 0.5*ones(2*numberOfCards,1); %starting point
options = optimoptions('fmincon','MaxFunEvals',10000,'TolCon',1e-9);
[x,~] = fmincon(@(x)qre(lambda,x(1:numberOfCards),x(numberOfCards+1:2*numberOfCards),payoffparams),x0,...
    [],[],[],[],zeros(size(x0)),ones(size(x0)),[],options);
betRatep1 = x(1:numberOfCards);
betRatep2 = x(numberOfCards+1:end);
end

function difference = modelDiffQRE(lambda,truthp1,truthp2)%x = lambda,taus,tauh,mu
load('nObsPoker.mat')
[betRatep1,betRatep2]=QREtexas(lambda);
differenceh = -logLikelihood(betRatep1,truthp1,nP1);
differences = -logLikelihood(betRatep2,truthp2,nP2);
difference = differenceh+differences;
end