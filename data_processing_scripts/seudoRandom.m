x = randi([2,8],5000,1);
%test_cdf = [x,cdf('Discrete Uniform',x,'7')];
frequencies = [25    20   15    16    14    14];
lastOne = 120 - sum(frequencies);
frequencies = [frequencies,lastOne];
cardsSamples = [];
for i = 1:length(frequencies)
    cardi = (i+1)*ones(frequencies(i),1);
    cardsSamples = [cardsSamples;cardi];
end
var= 6/49/120;
chi = (frequencies/120 - 1/7)/sqrt(var);
chi2cdf(chi*chi',6)
h = kstest2(cardsSamples,x) %#ok<NOPTS>
frequencies %#ok<NOPTS>
checkFre = [];
for i = 2:8
    checkFre = [checkFre;sum(x==i)];
end