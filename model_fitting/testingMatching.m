x = fmincon(@(x)modelDiff(x,histm,histm, saliencyResampled),[99,1.5,1.5,0.06],[],[],[],[],[99,0,0,0.06],[100,inf,inf,0.06]);%x = lambda,taus,tauh,miu
%xh = x(1,[1 3:4]);
xm = x(1,[1:2 4]);
%xm = [100,0.3,0.06];
[~,predictedm] = levelmodel(xm, saliencyResampled);
logLikelihood(predictedm,histm)
plot([0:1/(20-1):1],histm)
hold on
plot([0:1/(20-1):1],predictedm)
legend('real population','predicted')
xlabel('saliency value')
ylabel('density')
hold off

