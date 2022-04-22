function [u1,u2]= TwoPersonutilityTexas(p1,p2,payoffparams)
%payoffparams = [b,foldpay,checkpay];
b =payoffparams;
foldpay = 1;
%p1 = [bet,check], p2 = [call,fold]
posteriorP2 = p1(1)/sum(p1); %p2 think p1 at high state
u1 = [p2*(b+foldpay)+(1-p2)*foldpay;-p2*(b+foldpay)+(1-p2)*foldpay];%[card high utility bet,card low utility bet]
u2 = posteriorP2*(-b-foldpay)+(1-posteriorP2)*(b+foldpay);