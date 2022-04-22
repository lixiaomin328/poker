%%calculate loglikelihood
%prediction:model predicted variable
%truth: actual data
function loglk = logLikelihood(prediction,truth,nP)
loglk = 0;
for i = 1:length(truth)
    if 1 - prediction(i)<1e-6
        prediction(i) = 1 -1e-6;
    end
    loglk = loglk + (log(prediction(i))*truth(i)+log(1-prediction(i))*(1-truth(i)))*nP(i);
end