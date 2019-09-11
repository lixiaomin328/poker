%x = fmincon(@(x)modelDiff(x,hists,hidehis,saliencyResampled),[99,1.2,1.5,0.06],[],[],[],[],[99,0,0,0.06],[100,2,2,0.06]);%x = lambda,taus,tauh,miu
%x = (xs+xh)./2;
%% plot likelihood surface for different parameterss
n_tau = 100;
n_mu = 100;
likelihood = zeros(n_tau,n_mu);
for i = 1:n_tau
    for j = 1:n_mu
        tau = 0.5*i;
        lambda = j;
        xh = [lambda;tau;0.3];
[predictedh,predicteds,phh,phs,prop] = levelmodel(xh, saliencyResampled);
likelihood(i,j) = logLikelihood(predictedh,hidehis);
    end
end