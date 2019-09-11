function [u1,u2]= utilityTexas(p1,p2,payoffparams)
qreBelief = repmat(p1',[length(p1),1]).*(1-eye(length(p1)));
qreBelief = qreBelief./repmat(sum(qreBelief,2),[1,length(p1)]);
%payoffparams = [b,foldpay,checkpay];
b =payoffparams(1);
foldpay = payoffparams(2);
%p1 = [bet,check], p2 = [call,fold]
pior = 1/(length(p1)-1);
u2 = sum(tril(qreBelief,-1),2)*2*b-b;
u1 = cumsum([0;p2(1:end-1)])*pior*b-b*pior*(sum(p2)-cumsum(p2))+foldpay*(1-pior*sum(p2)+pior*p2);
