%fitting fictitious play
%% not working code
subId = 3;
payoffparams = [3,1,1];
[p1Actions,p1Cards,p1rt,p2Actions,p2Cards,p2rt] = getIndividualRTandChoice(subId);
addpath('/Users/lixiaomin/Documents/GitHub/poker/model_fitting');
assessment = [];
fPlay = [];
for i = 2:length(p1Actions)
    p1mix = sum(p1Actions(1:i-1)==1)/sum(p1Actions(1:i-1)~=-1);
    if sum(~p1Actions(1:i-1)~=-1) ==0
        p2mix = -1;
    end
    p2mix = sum(p2Actions(1:i-1)==1)/sum(~p1Actions(1:i-1)~=-1);
    assessment = [assessment;p1mix,p2mix];
[bResponse1,bResponse2] = texasLevelDensity(p1mix,p2mix,payoffparams);
fPlay = [fPlay;bResponse1(p1Cards(i)),bResponse2(p2Cards(i))];
end