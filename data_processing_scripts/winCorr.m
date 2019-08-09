%do trial by trial bet rate
%correlation with previous round outcome (dummy code as won or lost)

%inputs: p1Actions, p2Actions, whoWins (1 or 2), next round choice (bet or
%not)

p1Move = dataStructure.player1ActionCheck_keys;
p2Move = dataStructure.player2ActionCheck_keys;
p1Card = dataStructure.P1card;
p2Card = dataStructure.P2card;

p1MoveShift = [p1Move; 0];
indicatorShift = [0; indicatorWin];

[~,~, indicatorWin]= earningsCalc(p1Move, p2Move, p1Card, p2Card);

corrcoef(indicatorShift, p1MoveShift) %is there a stronger statistical way to do this?