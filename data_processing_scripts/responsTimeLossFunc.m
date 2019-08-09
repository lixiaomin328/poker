function loss = responsTimeLossFunc(tau, x, rtHist, params, lastParams)
loss = -log(mixGaussianPdf(tau, params(1), params(2), params(3), x))*rtHist' + 10 * sum(abs(params - lastParams));
