function difference = targetRT(x,data)
mu = x(1);
sigma = x(2);
difference = llNormal(data,x(1),x(2));
 