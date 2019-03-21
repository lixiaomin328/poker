%%CH model prediction given saliency distribution and all parameters(x)
function [predictedh,predicteds,ph,ps,numberLevel] = levelmodel(x, U)
a = x(1);%quantile parameter \
b = x(2); %poisson parameter
u = x(3); %utility rate 
%gamma = x(4);
n = 20; %length of observations
ph = [];
ps = [];
numberLevel = [];
plasth = 1/n*ones(n,1);
plasts = 1/n*ones(n,1);
for k = 1:max(round(5*b),5)
    prop = poisspdf(k-1,b);
    [~,pkh] = levelDensity(k,1,b,a,a,plasth,u,U);
    [~,pks] = levelDensity(k,0,b,a,a,plasts,u,U);
    numberLevel = [numberLevel;prop*n];
    ph = [ph,pkh];
    ps = [ps,pks];
    plasth = mixProb(ps,numberLevel);
    plasts = mixProb(ph,numberLevel);
end
predictedh = mixProb(ph,numberLevel);
predicteds=mixProb(ps,numberLevel);

