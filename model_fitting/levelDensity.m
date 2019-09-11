%% This function output the strategy of a particular level given all parameters.
% k:current level
% lambda: poisson parameter (tau)
% u: saliency coefficient
% S: saliency distribution
% plast: strategy for last level
% qs/qh: softmax parameter. usually called lambda
% npercent: level k percentage in population
% p: level k player's strategy distribution
function [npercent,p] = levelDensity(k,H,lambda,qs,qh,plast,u, S)
if k ~=1
    u= 0;
end
if H == 1
    q = qh;
else
    q = qs;
end
npercent = poisspdf(k-1,lambda);
%U = [0:1/(length(plast)-1):1]';
%U = saliencyResampled;%quantile(U, gamma);
if H == 1
    U = (1-plast)+u*S;
    p = quantile(U,q);
    return;
end
U = 4*plast+u*S;
p = quantile(U,q);