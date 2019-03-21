function [u1,u2]= realUtilityTexas(p1,p2,card1,card2,payoffparams)
%payoffparams = [b,foldpay,checkpay];
b =payoffparams(1);
foldpay = payoffparams(2);
checkpay = payoffparams(3);
%p1 = [bet,check], p2 = [call,fold]
if card1>card2
    uP1bet = [[b,foldpay]*p2,[-b,-foldpay]*p2];
else
    uP1bet = -[[b,foldpay]*p2,[-b,-foldpay]*p2];
    checkpay = -checkpay;
end
u = [uP1bet;checkpay,-checkpay]'*p1;
u1 = u(1);
u2 = u(2);
