close all;
preParams = [-0.1465    0.0022    0.6595];
allParams = [];
figure
for card = 2 : 8
[rtHist, rtX] = hist(p1RtAll{card}, 10);
currTau = tau(card - 1);
params = fmincon(@(params)responsTimeLossFunc(currTau, rtX, rtHist, params, preParams),preParams,[],[],[],[],[-5,0,0],[5,50,1]);%x = lambda,taus,tauh,miu
subplot(2,4,card-1)
plot(exp(rtX), rtHist./sum(rtHist));
hold on;
%tau, mu0, muDelta, sigma, x
plot(exp(rtX), mixGaussianPdf(currTau, params(1), params(2), params(3), rtX));
preParams = params;
allParams = [allParams; params];
title(['card ',num2str(card)])
xlabel('time')
ylabel('density')
hold off;
%pause(1)
end