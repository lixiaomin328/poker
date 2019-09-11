
x = fmincon(@(x)targetRT(x,data),[0.1,3,7.1],[],[],[],[],[0,0,0],[5,5,1]);%x = lambda,taus,tauh,miu
