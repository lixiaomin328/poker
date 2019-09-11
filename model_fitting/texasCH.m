function [betRatep1,betRatep2,numberLevel,p1,p2] = texasCH(tau,b,lambda)
payoffparams = [3,1,1];
%numberLevel = 1/tau;
numberLevel = poisspdf(0,tau);
nCard =7;
p1level0 = b*ones(nCard,1);
%p1level0 = [b:(1-b)/(nCard-1):1]';
%p1level0 = [0;0;0;0;1;1;1];
if p1level0(1)==0
p1level0(1) = 1e-6;
end
%p2last = p1last;
p2level0 = p1level0;
p1last = p1level0;
p2last = p2level0;
p1 = p1level0;
p2 = p2level0;
for k = 1:10%max(round(5*tau),5)
    [bResponse1,bResponse2] = texasLevelDensity(p1last,p2last,payoffparams,p1level0,p2level0,lambda);
    %prop = 1/tau;
    prop = poisspdf(k,tau);
    numberLevel = [numberLevel;prop];
    p1 = [p1,bResponse1];
    p2 = [p2,bResponse2];
    p1last = diag(p1*numberLevel);
    p2last = diag(p2*numberLevel);
%     p1last = mixProb(p1,numberLevel);
%     p2last = mixProb(p2,numberLevel);
end
betRatep1=p1last;
betRatep2=p2last;
% betRatep1 = mixProb(p1,numberLevel);
% betRatep2=mixProb(p2,numberLevel);

