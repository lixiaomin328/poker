%% This function output the poker strategy of a particular level given all parameters.
function [bResponse1,bResponse2] = TwoPersontexasLevelDensity(p1last,p2last,b,lambda)
%n is number of card
[u1,u2]= TwoPersonutilityTexas(p1last,p2last,b);%utility of betting
%lambda = 10;
bResponse2 = 1/(1+exp(-lambda*(u2 + 1)));
bResponse1 = 1./(1+exp(-lambda*(u1 + 1)));
% bResponse2 = 1./(1+exp(-lambda*(u2 + payoffparams(2))));
% bResponse1 = 1./(1+exp(-lambda*(u1 - (payoffparams(3)*([0:(length(p1last)-1)]'*2*prior-1)))));