function f = qre(lambda,p1,p2,payoffparams) %for texas
[u1,u2]= utilityTexas(p1,p2,payoffparams);
pior = 1/(length(p1)-1);
qreP1 = ones(size(u1))./(1+exp(lambda*payoffparams(3)*([0:(length(p1)-1)]'*2*pior-1) -  lambda*u1));
qreP2 = ones(size(u2))./(1+exp(-lambda*payoffparams(2) - lambda*u2));

f = sum([(p1 - qreP1);(p2 - qreP2)].^2);