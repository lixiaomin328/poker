function [betRatep1,betRatep2,numberLevel,p1,p2] = texasTwoCardsCH(tau,levelZero,lambda,betSize)

%numberLevel = 1/tau;
numberLevel = poisspdf(0,tau);
%numberLevel = 1;
nCard =2;
p1level0 = levelZero(1:2)';
%p1level0 = [b:(1-b)/(nCard-1):1]';
%p1level0 = [0;0;0;0;1;1;1];
if p1level0(1)==0
p1level0(1) = 1e-6;
end
%p2last = p1last;
p2level0 = levelZero(3);
p1last = p1level0;
p2last = p2level0;
p1 = p1level0;
p2 = p2level0;
for k = 1:max(round(5*tau),5)
    [bResponse1,bResponse2] = TwoPersontexasLevelDensity(p1last,p2last,betSize,lambda);
    %prop = 1/tau;
    prop = poisspdf(k,tau);
    %prop= 1;
    numberLevel = [numberLevel;prop];
    p1 = [p1,bResponse1];
    p2 = [p2,bResponse2];
%     p1last = diag(p1*numberLevel);
%     p2last = diag(p2*numberLevel);
    p1last = mixProb(p1,numberLevel);
    p2last = p2*(numberLevel./sum(numberLevel));
end
betRatep1=p1last;
betRatep2=p2last;
% betRatep1 = mixProb(p1,numberLevel);
% betRatep2=mixProb(p2,numberLevel);
