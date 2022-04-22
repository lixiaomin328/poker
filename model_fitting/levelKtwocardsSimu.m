levelZeros =[0.5,0.5,0.5;1,1,1;1,0,0;1,0,1/2];
levelZero = [1,0,1];
taus =[1.5:1:8];
betSize=[2:10];
betRates= [];
%for i = 1:size(levelZeros,1)
for i = 1:length(betSize)
    %levelZero = levelZeros(i,:);
[betRatep1,betRatep2,numberLevel,p1,p2] = texasTwoCardsCH(1.5,levelZero,99,betSize(i));
betRates =[betRates,[betRatep1;betRatep2]];
end