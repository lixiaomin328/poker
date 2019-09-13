function pdf = mixGaussianPdf(tau, mu0, muDelta, sigma, x)
pdf = zeros(size(x));
for i = 0 : tau * 5
    pdf = pdf + poisspdf(i, tau) * normpdf(x, mu0 + i * muDelta, sigma);
end
pdf = pdf ./ sum(pdf);


