%%target function for optimization
function difference = modelDiff(parameters,truthp1,truthp2)%x = lambda,taus,tauh,mu
tau = parameters(1);
initialSlope = parameters(2);
[betRatep1,betRatep2,numberLevel,p1,p2] = texasCH(tau,initialSlope);


differenceh = -logLikelihood(betRatep1,truthp1);

differences = -logLikelihood(betRatep2,truthp2);

difference = differenceh+differences;
