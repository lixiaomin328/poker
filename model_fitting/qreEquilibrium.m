%%QRE target function
function f = qreEquilibrium(s,lambda,mu,sigma,ps,ph)
Cs = 1/sum(exp(lambda*(ph+mu*s)));
Ch = 1/sum(exp(lambda*(sigma*(1-ps)+mu*s)));
f = [ps - Cs*exp(lambda*(ph+mu*s));
ph - Ch*exp(lambda*(sigma*(1-ps)+mu*s))];