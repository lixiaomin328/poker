%%target function for optimization
function difference = modelDiff(tau,truthp1,truthp2)%x = lambda,taus,tauh,mu

[betRatep1,betRatep2,numberLevel,p1,p2] = texasCH(tau);


differenceh = -logLikelihood(betRatep1,truthp1);

differences = -logLikelihood(betRatep2,truthp2);

difference = differenceh+differences;
