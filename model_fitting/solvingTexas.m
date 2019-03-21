%% solve a QRE
%x: equilibrium probability for hider and seeker. x(1:20) is seeker,
%x(21:40) is hider's

lambda = 20;%QRE parameter, tune this one to see difference
payoffparams = [1.5,1,1];
numberOfCards = 5;
x0 = 0.5*ones(2*numberOfCards,1); %starting point
options = optimoptions('fmincon','MaxFunEvals',10000,'TolCon',1e-9);
[x,value] = fmincon(@(x)qre(lambda,x(1:numberOfCards),x(numberOfCards+1:2*numberOfCards),payoffparams),x0,...
    [],[],[],[],zeros(size(x0)),ones(size(x0)),[],options);
figure(1);
plot(x(1:numberOfCards));
hold on;
plot(x(numberOfCards+1:end));
xlabel('card number')
ylabel('probablity to bet')
legend('Player 1','Player 2')
hold off;