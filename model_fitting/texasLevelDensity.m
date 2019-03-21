%% This function output the poker strategy of a particular level given all parameters.
function [bResponse1,bResponse2] = texasLevelDensity(k,p1last,p2last,tau,payoffparams)
%n is number of card
[u1,u2]= utilityTexas(p1last,p2last,payoffparams);%utility of betting
%U = [0:1/(length(plast)-1):1]';
%U = saliencyResampled;%quantile(U, gamma);
prior = 1/(length(p1last)-1);
%lambda = 20;
%bResponse2 = 1./(1+exp(-lambda*(u2 + payoffparams(2))));
%bResponse1 = 1./(1+exp(-lambda*(u1 - (payoffparams(3)*([0:(length(p1last)-1)]'*2*prior-1)))));
bResponse2 = sign(u2 + payoffparams(2))/2+1/2;
bResponse1 = sign(u1 - (payoffparams(3)*([0:(length(p1last)-1)]'*2*prior-1)))/2+1/2;
