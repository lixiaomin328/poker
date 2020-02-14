x = randi([2,8],5000,1);
%test_cdf = [x,cdf('Discrete Uniform',x,'7')];
frequencies = [30    17   15    16    14    14];
lastOne = 120 - sum(frequencies);
frequencies = [frequencies,lastOne];
cardsSamples = [];
for i = 1:length(frequencies)
    cardi = (i+1)*ones(frequencies(i),1);
    cardsSamples = [cardsSamples;cardi];
end

h = kstest2(cardsSamples,x) %#ok<NOPTS>
frequencies %#ok<NOPTS>