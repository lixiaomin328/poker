%%bootstrapped CH model parameter
%x = fmincon(@(x)modelDiff(x,hidehis,1, saliencyResampled),[50,1,0.3],[],[],[],[],[0,0,0],[inf,inf,1]);
sourceHists = hists'./sum(hists);%original data
sourceHisth = hidehis'./sum(hidehis);
sourceCdfs = cumsum(sourceHists);%original data distribution
sourceCdfh = cumsum(sourceHisth);
nIter = 100;
sampleNum = 2038;
params = zeros(nIter, 4);
%%resample process
for iter = 1 : nIter
    samples = rand(1, sampleNum);
    sampleBins = arrayfun(@(r) find(r<sourceCdfs,1,'first'),samples);
    sampleBinh = arrayfun(@(r) find(r<sourceCdfh,1,'first'),samples);
    sampleHists = hist(sampleBins, 1:length(sourceHists));
    sampleHists = sampleHists./sum(sampleHists);
    sampleHisth = hist(sampleBinh, 1:length(sourceHisth));
    sampleHisth = sampleHisth./sum(sampleHisth);
    %x = fmincon(@(x)modelDiff(x,sampleHist,0, saliencyResampled),x,[],[],[],[],[29.7,0,0],[29.7,inf,1]);
    %%one batch bootstraped parameter
    x = fmincon(@(x)modelDiff(x,sampleHists,sampleHisth,saliencyResampled),x,[],[],[],[],[0,0,0,0],[100,inf,inf,1]);%x = lambda,taus,tauh,miu
    
    params(iter, :) = x;
    [iter, x]
    bar(sampleHists)
    pause(0.1);
end

% x = fmincon(@(x)modelDiff(x,sourceHist,0, saliencyResampled),xs,[],[],[],[],[0,0,0,0],[inf,inf,1]);
% [predictedh,predicteds,ph,ps,prop] = levelmodel(x, saliencyResampled);
% logLikelihood(predictedh,sourceHist)
% plot([0:1/(length(predictedh)-1):1],sourceHist)
% hold on
% plot([0:1/(length(predictedh)-1):1],predictedh)
% legend('real hider data','predicted')
% xlabel('saliency value')
% ylabel('density')
% title('Saliency level-k model fitting')
% hold off