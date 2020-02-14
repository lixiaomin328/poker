%% get overall density
[p1Actions,p1Cards,p1rtNorm,p2Actions,p2Cards,p2rtNorm,p1rt,p2rt] = getRTandChoice();
cardsActions1 = [p1Actions,p1Cards];
cardsActions2 = [p2Actions,p2Cards];
cardsActions1(cardsActions1(:,1)<0,:)= [];
cardsActions2(cardsActions2(:,1)<0,:)= [];
proportionsBetP1=grpstats(cardsActions1(:,1),cardsActions1(:,2),'mean');
proportionsBetP2=grpstats(cardsActions2(:,1),cardsActions2(:,2),'mean');

