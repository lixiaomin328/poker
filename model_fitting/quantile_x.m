%% Softmax function
function p = quantile(U,lambda)
p = zeros(length(U),1);
for i = 1:length(U)
p(i) = exp(lambda*U(i))/sum(exp(lambda*U));
end