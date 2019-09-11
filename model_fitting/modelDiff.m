%%target function for optimization
function difference = modelDiff(parameters,truthp1,truthp2)%x = lambda,taus,tauh,mu
card = [2:8];
%tau = parameters(1:7);
%tau =parameters(1)*ones(7,1)';
entroVec = [0;0.45;0.63;0.7;0.63;0.45;0]';
%tau = parameters(1)*ones(7,1)';
tau = parameters(1)./(1+entroVec*parameters(2));
%tau = exp(parameters(1)*entroVec+parameters(2));%parameters(2);%parameters(1)* [1.0150    0.9510    0.8858    0.9542    1.0239    1.1238    1.1066];
%tau = parameters(1)./[0.8301 1.1781 1.0767 1.1921 0.9454 0.8592 0.8524];
%*card.^2+parameters(2)*card+parameters(3);
b = parameters(end-1);
lambda = parameters(end);
%initialSlope = parameters(2);
[betRatep1,betRatep2] = texasCH(tau,b,lambda);


differenceh = -logLikelihood(betRatep1,truthp1);

differences = -logLikelihood(betRatep2,truthp2);

difference = differenceh+differences;
