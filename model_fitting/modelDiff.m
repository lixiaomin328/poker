%%target function for optimization
function difference = modelDiff(parameters,truthp1,truthp2)%x = lambda,taus,tauh,mu
card = [2:8];
%tau = parameters(1:7);
tau = parameters(1)*card.^2+parameters(2)*card+parameters(3);
b = parameters(end-1);
lambda = parameters(end);
%initialSlope = parameters(2);
[betRatep1,betRatep2] = texasCH(tau,b,lambda);


differenceh = -logLikelihood(betRatep1,truthp1);

differences = -logLikelihood(betRatep2,truthp2);

difference = differenceh+differences;
