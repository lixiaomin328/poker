%%calculate loglikelihood
%prediction:model predicted variable
%truth: actual data
function loglk = logLikelihood(prediction,truth)
loglk = 0;
for i = 1:length(truth)
    loglk = loglk + log(prediction(i))*truth(i);
end