function y = squreMin(x, base, truth)
y = -logLikelihood(base * x,truth);%sum((base * x - truth).^2);
