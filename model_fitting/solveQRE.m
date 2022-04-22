%% solve a QRE
%x: equilibrium probability for hider and seeker. x(1:20) is seeker,
%x(21:40) is hider's
rate = [];
nBins = 20;
lambda = 100;%QRE parameter, tune this one to see difference
mu = 0.056;
sigma =4;
s = saliencyResampled;
for i = 1:2*nBins
x0 = 0.05*ones(2*nBins,1); %starting point
[x,value] = fsolve(@(x)qreEquilibrium(s,lambda,mu,sigma,x(1:20),x(21:end)),x0);
seekRate = sum(x(1:20).*x(21:end))-0.05;
rate = [rate;seekRate];
%%
plot([1:20],x(1:20));
hold on
plot([1:20],x(21:end));
hold off
end
%%
 subplot(2,1,1)
 plot([1:20]./20,x(1:20));
 hold on
 plot([1:20]./20,x(21:end));
 hold off
 subplot(2,1,2)
 plot([1:20]./20,x1(1:20));
 hold on
 plot([1:20]./20,x1(21:end));
 hold off