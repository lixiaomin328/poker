%%bootstrapped CH model parameter
%x = fmincon(@(x)modelDiff(x,hidehis,1, saliencyResampled),[50,1,0.3],[],[],[],[],[0,0,0],[inf,inf,1]);
load('modelSource.mat')
sourceHist1 = proportionsBetP1'./sum(proportionsBetP1);%original data
sourceHist2 = proportionsBetP2'./sum(proportionsBetP2);
sourceCdfs = cumsum(sourceHist1);%original data distribution
sourceCdfh = cumsum(sourceHist2);
nIter = 500;
sampleNum = 700;
params = zeros(nIter, 4);
%%resample process
for iter = 1 : nIter
    batchSample=zeros(7,2)';
    for batchNum = 1:sampleNum
    cards = zeros(1,2);
    while cards(1) == cards(2)
        cards = randi([2 8],1,2);
    end
    sample1 = binornd(1,sourceHist1(cards(1)-1));
    sample2 = binornd(1,sourceHist2(cards(2)-1));
    batchSample(1,cards(1)-1) = batchSample(1,cards(1)-1)+sample1;
    batchSample(2,cards(2)-1) = batchSample(2,cards(2)-1)+sample2;
    %samples = rand(1, sampleNum);
%     sampleBins = arrayfun(@(r) find(r<sourceCdfs,1,'first'),samples);
%     sampleBinh = arrayfun(@(r) find(r<sourceCdfh,1,'first'),samples);
%     sampleHists = hist(sampleBins, 1:length(sourceHist1));
    end
    sampleHist1= batchSample(1,:)/sampleNum;
    sampleHist2 = batchSample(2,:)/sampleNum;
%     sampleHisth = hist(sampleBinh, 1:length(sourceHist2))
    %x = fmincon(@(x)modelDiff(x,sampleHist,0, saliencyResampled),x,[],[],[],[],[29.7,0,0],[29.7,inf,1]);
    %%one batch bootstraped parameter
    x =fmincon(@(x)modelDiff(x,sampleHist1,sampleHist2),[2,1,0.7,100],[],[],[],[],[-6,1,0,199],[5,1,1,200]);%entropy tau/%
    params(iter, :) = x;
    [iter, x]
    bar(sampleHist1)
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