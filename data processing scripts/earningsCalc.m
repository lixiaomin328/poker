function [p1EarningsCumulative, p1Earnings, p2EarningsCumulative, p2Earnings] = earningsCalc(p1Move, p2Move, p1Card, p2Card)

%% create move profiles

whoHigher = double(p1Card > p2Card);

betCall = ((p1Move == 1) & (p2Move == 1));
betFold = ((p1Move == 1) & (p2Move == 0));
check = ((p1Move == 0) & (p2Move == -1));

%% tally p1 earnings

p1WinBetCall = (3*((betCall == 1) & (whoHigher == 1))); %3pt per winning a betCall,
p1WinCheck = ((whoHigher == 1) & (check == 1)); %1pt for winning check
p1WinNoMove = 2*((p1Move == 1) & (p2Move == -1));
p1Wins = p1WinBetCall + betFold + p1WinCheck + p1WinNoMove;

p1LoseBetCall = (-3)*((betCall == 1) & (whoHigher == 0));
p1LoseCheck = (-1)*((whoHigher == 0) & (check == 1));
p1NoMove = (-2)*(p1Move == -1);
p1Losses =  p1LoseBetCall + p1LoseCheck + p1NoMove;

p1Earnings = p1Wins + p1Losses;
p1EarningsCumulative = sum(p1Earnings);

%% tally p2 earnings

p2WinBetCall = (3*((betCall == 1) & (whoHigher == 0))); %3pt per winning a betCall,
p2WinCheck = ((whoHigher == 0) & (check == 1)); %1pt for winning check
p2WinNoMove = (2)*(p1Move == -1);
p2Wins = p2WinBetCall + p2WinCheck + p2WinNoMove;

p2LoseBetCall = (-3)*((betCall == 1) & (whoHigher == 1)); %-3pt per lose betcall
p2LoseCheck = (-1)*((whoHigher == 1) & (check == 1)); %-1pt per lose check
p2NoMove = (-2)*((p1Move == 1) & (p2Move == -1));
p2Losses =  p2LoseBetCall + p2LoseCheck + (-1)*(betFold) + p2NoMove;

p2Earnings = p2Wins + p2Losses;
p2EarningsCumulative = sum(p2Earnings);

