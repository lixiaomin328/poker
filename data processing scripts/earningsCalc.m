function  [p1Earnings,p2Earnings]= earningsCalc(p1Move, p2Move, p1Card, p2Card)
%% create move profiles
betCall = ((p1Move == 1) & (p2Move == 1));
betFold = ((p1Move == 1) & (p2Move == 0));
check = p1Move == 0;
indicatorWin = 2*double(p1Card > p2Card)-1;
%% tally p1 earnings
p1Earnings = 3*indicatorWin.*(betCall == 1)+indicatorWin.*check+betFold+2*((p1Move == 1) & (p2Move == -1))-2*(p1Move == -1);
p2Earnings = -p1Earnings;

