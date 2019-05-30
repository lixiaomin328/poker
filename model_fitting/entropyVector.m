winProb = 0:1/6:1;
entropy = [];
for i = 2:length(winProb)-1
    p=winProb(i);
    entropy = [entropy;p*log(p)+(1-p)*log(1-p)];
end
entropy = [0;-1*entropy;0];
