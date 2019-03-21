function [betRatep1,betRatep2,numberLevel,p1,p2] = texasCH(tau)
payoffparams = [3,1,1];
%numberLevel = 1/tau;
numberLevel = poisspdf(0,tau);
nCard =7;
p1last =0.5*ones(nCard,1); 
p2last =0.5*ones(nCard,1);
p1 = p1last;
p2=p1last;
for k = 1:max(round(5*tau),5)
    [bResponse1,bResponse2] = texasLevelDensity(k,p1last,p2last,tau,payoffparams);
    prop = 1/tau;
    prop = poisspdf(k,tau);
    numberLevel = [numberLevel;prop];
    p1 = [p1,bResponse1];
    p2 = [p2,bResponse2];
    p1last = mixProb(p1,numberLevel);
    p2last = mixProb(p2,numberLevel);
end
betRatep1 = mixProb(p1,numberLevel);
betRatep2=mixProb(p2,numberLevel);
plot([1:nCard],betRatep1)
hold on
plot([1:nCard],betRatep2)
legend('P1','P2')
ylim([0,1])
hold off
%% change line width
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end
set(gca,'FontSize',36);
