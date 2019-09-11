function weightedP = mixProb(probAll,propotion)
%propotion = [#level,#level1,...]
percent = propotion./sum(propotion);
percent = repmat(percent,1,size(probAll,1))';
weightedP = percent.*probAll;
weightedP = sum(weightedP,2);
