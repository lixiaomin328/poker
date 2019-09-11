function loglk = llNormal(data,mu,sigma)
loglk = 0;
for i = 1:length(data)
    loglk = loglk + log(normpdf(data(i),mu,sigma));
end